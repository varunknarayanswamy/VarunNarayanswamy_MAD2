package com.example.apirateslifeforme.data.repos

import android.app.Application
import android.util.Log
import androidx.lifecycle.MutableLiveData
import com.example.apirateslifeforme.data.models.PirateMember
import com.google.firebase.firestore.QuerySnapshot
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase

class PirateRepository(val app: Application) {
    private val db = Firebase.firestore

    val pirateCrew = MutableLiveData<List<PirateMember>>()

    init {
        db.collection("pirateMembers").addSnapshotListener{snapshot, error ->
            if (error != null)
            {
                Log.i("pirateMem","Firebase Error", error)
                return@addSnapshotListener
            }
            if (snapshot != null){
                parseAllPirates(snapshot)
            }
            else{
                Log.i("pirateMem","Data came out null")
            }

        }
    }

    private fun parseAllPirates(result: QuerySnapshot){
        var allPirate = mutableListOf<PirateMember>()

        for (pirate in result){
            val id: String = pirate.id
            val name = pirate.getString("pirateName")!!
            val position = pirate.getString("piratePosition")!!
            val pirateJoinDate = pirate.getDate("pirateJoinDate")!!
            val pirateNum = (pirate.get("pirateNum") as Long).toInt()

            allPirate.add(
                PirateMember(
                id,
                name,
                position,
                pirateJoinDate,
                pirateNum
            )
            )
            pirateCrew.value = allPirate
        }
    }

    fun addPirateMember(pirateMember: PirateMember){
        val pirateHash = hashMapOf(
            "pirateName" to pirateMember.pirateName,
            "piratePosition" to pirateMember.piratePosition,
            "pirateJoinDate" to pirateMember.pirateJoinDate,
            "pirateNum" to pirateMember.pirateNum
        )

        db.collection("pirateMembers")
            .add(pirateHash)
            .addOnSuccessListener {
                Log.i("pirateMem","Snapshot added with ID ${it.id}")
            }
            .addOnFailureListener{ error ->
                Log.i("pirateMem","Error add doc", error)
            }
    }

    fun removeCrewMate(id: String){
        db.collection("pirateMembers").document(id).delete()
    }
}