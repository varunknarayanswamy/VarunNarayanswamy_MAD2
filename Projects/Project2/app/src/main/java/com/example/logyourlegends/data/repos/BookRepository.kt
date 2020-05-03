package com.example.logyourlegends.data.repos

import android.app.Application
import android.util.Log
import androidx.annotation.WorkerThread
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import com.example.logyourlegends.data.BASE_URL
import com.example.logyourlegends.data.LOG_TAG
import com.example.logyourlegends.data.models.Book
import com.example.logyourlegends.data.services.GoogleBooksService
import com.example.logyourlegends.data.utils.NetworkHelper
import com.squareup.moshi.Types
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory

class BookRepository(val app: Application) {
    private var listType = Types.newParameterizedType(List::class.java, Book::class.java)

    private var retrofit: Retrofit = Retrofit.Builder()
        .baseUrl(BASE_URL)
        .addConverterFactory(MoshiConverterFactory.create())
        .build()
    private var service: GoogleBooksService

    init{
        service = retrofit.create(GoogleBooksService::class.java)
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