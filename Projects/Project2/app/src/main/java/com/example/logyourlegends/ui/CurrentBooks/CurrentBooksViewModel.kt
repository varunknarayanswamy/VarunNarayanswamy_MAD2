package com.example.logyourlegends.ui.CurrentBooks

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import com.example.logyourlegends.data.models.Book
import com.example.logyourlegends.data.repos.BookRepository

class CurrentBooksViewModel(app: Application): AndroidViewModel(app) {
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