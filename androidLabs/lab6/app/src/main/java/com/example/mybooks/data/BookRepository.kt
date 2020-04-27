package com.example.mybooks.data

import android.app.Application
import android.database.Observable
import android.util.Log
import androidx.annotation.WorkerThread
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import com.example.mybooks.BASE_URL
import com.example.mybooks.LOG_TAG
import com.example.mybooks.utils.NetworkHelper
import com.squareup.moshi.Types
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory
import java.util.*

class BookRepository(val app: Application) {
    private var listType = Types.newParameterizedType(List::class.java, Book::class.java)

    private var retrofit: Retrofit = Retrofit.Builder()
        .baseUrl(BASE_URL)
        .addConverterFactory(MoshiConverterFactory.create())
        .build()
    private var service: GoogleBooksService

    init{
        service = retrofit.create(GoogleBooksService::class.java)
        CoroutineScope(Dispatchers.IO).launch {
            getBookList("Harry Potter")
        }
    }

    val searchTermEntered = Observer<String> {
        CoroutineScope(Dispatchers.IO).launch {
            getBookList(it)
        }
    }

    val bookDetails = MutableLiveData<List<Book>>()

    @WorkerThread
    private suspend fun getBookList(searchTerm: String){
        Log.i(LOG_TAG, searchTerm)
        if (NetworkHelper.networkConnected(app)){
            val response = service.searchBooks(searchTerm).execute()
            if (response.body() != null){
                val responseBody = response.body()
                Log.i(LOG_TAG, responseBody.toString())
                bookDetails.postValue(responseBody?.items?.toList())
            }else{
                Log.e(LOG_TAG, "Could not search books")
            }
        }
    }
}