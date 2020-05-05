package com.example.logyourlegends.data.repos

import android.app.Application
import androidx.lifecycle.LiveData
import com.example.logyourlegends.data.database.AppDatabase
import com.example.logyourlegends.data.database.current.current
import com.example.logyourlegends.data.models.BookChosen
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class CurrentRepository(val app: Application) {
    private val db = AppDatabase.getDatabase(app)

    private val currentDAO = db.currentDAO()

    val currentRoomList: LiveData<List<current>> = currentDAO.getAllCurrent()

    fun addCurrent(BookChosen: BookChosen){
        CoroutineScope(Dispatchers.IO).launch {
            //insert the current
            currentDAO.insertCurrent(BookChosen.getRoomCurrent())
        }
    }
}