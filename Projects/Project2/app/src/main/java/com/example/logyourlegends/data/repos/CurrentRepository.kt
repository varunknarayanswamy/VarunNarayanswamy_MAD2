package com.example.logyourlegends.data.repos

import android.app.Application
import android.util.Log
import androidx.lifecycle.LiveData
import com.example.logyourlegends.data.LOG_TAG
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
            Log.i(LOG_TAG, "addCurrent CurrentRepo $BookChosen")
            currentDAO.insertCurrent(BookChosen.getRoomCurrent())
        }
    }

    fun removeCurrent(id: Int){
        CoroutineScope(Dispatchers.IO).launch {
            currentDAO.removeCurrent(id)
        }
    }
}