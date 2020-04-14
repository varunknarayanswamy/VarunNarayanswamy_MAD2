package com.example.mybooks.UI

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import com.example.mybooks.data.Book
import com.example.mybooks.data.BookRepository

class SharedSearchViewModel(app: Application): AndroidViewModel(app) {
    private val bookRepo = BookRepository(app)

    val bookDetails = bookRepo.bookDetails
    val selectedBook = MutableLiveData<Book>()
    val searchUserInput = MutableLiveData<String>()

    init {
        searchUserInput.observeForever(bookRepo.searchTermEntered)
    }

    override fun onCleared() {
        searchUserInput.removeObserver(bookRepo.searchTermEntered)
        super.onCleared()
    }
}