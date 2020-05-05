package com.example.logyourlegends.ui.CurrentBooks

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import com.example.logyourlegends.data.database.current.current
import com.example.logyourlegends.data.models.BookChosen
import com.example.logyourlegends.data.repos.CurrentRepository

class CurrentBooksViewModel(app: Application): AndroidViewModel(app) {
    private val currentRepo = CurrentRepository(app)
    val selectedBook = MutableLiveData<BookChosen>()
    val currentBooks: MutableLiveData<List<BookChosen>> = MutableLiveData()

    private val currentListObserver = Observer<List<current>> {
        val allCurrentBooks = mutableListOf<BookChosen>()

        for (current in it){
            allCurrentBooks.add(BookChosen.fromRoomCurrent(current))
        }

        currentBooks.value = allCurrentBooks
    }

    init {
        currentRepo.currentRoomList.observeForever(currentListObserver)
    }

    override fun onCleared() {
        currentRepo.currentRoomList.removeObserver(currentListObserver)
        super.onCleared()
    }

    fun addCurrent(currentBook: BookChosen){
        currentRepo.addCurrent(currentBook)
    }
}