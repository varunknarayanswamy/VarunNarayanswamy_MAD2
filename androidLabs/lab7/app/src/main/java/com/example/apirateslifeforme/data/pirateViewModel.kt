package com.example.apirateslifeforme.data

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import com.example.apirateslifeforme.data.models.PirateMember
import com.example.apirateslifeforme.data.repos.PirateRepository

class pirateViewModel(app: Application): AndroidViewModel(app) {
    private val pirateRepo = PirateRepository(app)
    val pirateList: MutableLiveData<List<PirateMember>> =  MutableLiveData()

    private val pirateListObserver  = Observer<List<com.example.apirateslifeforme.data.database.pirateSaved.PirateMember>> {
        val allPirateMembers = mutableListOf<PirateMember>()

        for (pirate in it) {
            allPirateMembers.add(PirateMember.fromRoomPirates(pirate))
        }

        pirateList.value = allPirateMembers
    }
    init{
        pirateRepo.pirateCrew.observeForever(pirateListObserver)
    }

    override fun onCleared() {
        pirateRepo.pirateCrew.removeObserver(pirateListObserver)
        super.onCleared()
    }

    fun addPirate(pirate: com.example.apirateslifeforme.data.models.PirateMember){
        pirateRepo.addCrewmate(pirate)
    }

    fun removePirate(id: Int) = pirateRepo.removePirateFromCrew(id)

}