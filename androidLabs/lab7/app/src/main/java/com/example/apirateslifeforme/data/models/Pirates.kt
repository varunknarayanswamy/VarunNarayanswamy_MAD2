package com.example.apirateslifeforme.data.models

import com.example.apirateslifeforme.data.database.pirateSaved.PirateMember
import java.util.*


data class PirateMember(
    val pirate_id: Int,
    val pirateName: String,
    val piratePosition: String,
    val pirateJoinDate: Date,
    val pirateNum: Int
){
    fun getPirate(): PirateMember{
        return PirateMember(
            pirate_id,
            pirateName,
            piratePosition,
            Date(),
            pirateNum
        )
    }

    companion object{
        fun fromRoomPirates(pirate: PirateMember): com.example.apirateslifeforme.data.models.PirateMember{
            return com.example.apirateslifeforme.data.models.PirateMember(
                pirate.pirate_id,
                pirate.pirateName,
                pirate.position,
                pirate.dateJoined,
                pirate.pirateNum
            )
        }
    }
}