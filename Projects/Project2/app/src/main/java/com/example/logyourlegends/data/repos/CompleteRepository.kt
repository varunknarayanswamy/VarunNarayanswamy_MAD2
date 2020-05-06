package com.example.logyourlegends.data.repos

import android.app.Application
import androidx.lifecycle.LiveData
import com.example.logyourlegends.data.database.AppDatabase
import com.example.logyourlegends.data.database.complete.complete
import com.example.logyourlegends.data.database.current.current
import com.example.logyourlegends.data.models.BookChosen
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class CompleteRepository(val app: Application) {
    private val db = AppDatabase.getDatabase(app)

    private val completeDAO = db.completeDAO()

    val completeRoomList: LiveData<List<complete>> = completeDAO.getAllComplete()

    fun addComplete(BookChosen: BookChosen){
        CoroutineScope(Dispatchers.IO).launch {
            //insert the complete
            completeDAO.insertComplete(BookChosen.getRoomComplete())
        }
    }

    fun removeComplete(id: Int){
        CoroutineScope(Dispatchers.IO).launch {
            completeDAO.removeComplete(id)
        }
    }
}