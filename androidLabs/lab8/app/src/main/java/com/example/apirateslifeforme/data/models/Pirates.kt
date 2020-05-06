package com.example.apirateslifeforme.data.models
import java.util.*


data class PirateMember(
    val pirate_id: String,
    val pirateName: String,
    val piratePosition: String,
    val pirateJoinDate: Date,
    val pirateNum: Int
)