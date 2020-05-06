package com.example.logyourlegends.ui.CompletedBooks

import android.app.Application
import android.util.Log
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import com.example.logyourlegends.data.LOG_TAG
import com.example.logyourlegends.data.database.complete.complete
import com.example.logyourlegends.data.models.BookChosen
import com.example.logyourlegends.data.repos.CompleteRepository

class CompletedBookViewModel(app: Application): AndroidViewModel(app) {
    private val completeRepo = CompleteRepository(app)
    val completedBooks: MutableLiveData<List<BookChosen>> = MutableLiveData()

    private val completeListObserver = Observer<List<complete>> {
        val allCompleteBooks = mutableListOf<BookChosen>()
        for (complete in it){
            Log.i(LOG_TAG, "In observer")
            Log.i(LOG_TAG, complete.toString())
            allCompleteBooks.add(BookChosen.fromRoomComplete(complete))
        }

        completedBooks.value = allCompleteBooks
    }

    init {
        completeRepo.completeRoomList.observeForever(completeListObserver)
    }

    override fun onCleared() {
        completeRepo.completeRoomList.removeObserver(completeListObserver)
        super.onCleared()
    }

    fun addCompleteBook(completeBook: BookChosen){
        Log.i(LOG_TAG, "currentViewModel $completeBook")
        completeRepo.addComplete(completeBook)
    }

    fun removeComplete(id: Int) = completeRepo.removeComplete(id)
}