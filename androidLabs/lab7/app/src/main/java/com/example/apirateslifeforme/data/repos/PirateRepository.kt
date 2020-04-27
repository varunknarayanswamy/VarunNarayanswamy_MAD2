package com.example.apirateslifeforme.data.repos

import android.app.Application
import android.util.Log
import androidx.lifecycle.LiveData
import com.example.apirateslifeforme.data.AppDatabase
import com.example.apirateslifeforme.data.database.pirateSaved.PirateMember
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class PirateRepository(val app: Application) {
    private val db = AppDatabase.getDatabase(app)
    private val pirateDAO = db.pirateDAO()
    val pirateCrew: LiveData<List<PirateMember>> = pirateDAO.getAllPirates()

    fun addCrewmate(pirate: com.example.apirateslifeforme.data.models.PirateMember) {
        CoroutineScope(Dispatchers.IO).launch {
            pirateDAO.insertPirate(pirate.getPirate())
            Log.i("Add Pirate", "add pirate ${pirate}")
        }
    }

}