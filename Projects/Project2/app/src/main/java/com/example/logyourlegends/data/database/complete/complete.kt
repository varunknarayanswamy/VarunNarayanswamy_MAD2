package com.example.logyourlegends.data.database.complete

import androidx.room.Entity
import androidx.room.PrimaryKey
import java.util.*

@Entity(tableName = "complete_table")
data class complete (
    @PrimaryKey(autoGenerate = true) val complete_id: Int= 0,
    val title: String,
    val Author: String?,
    val pages: Int?,
    val pagesRead: Int,
    val lastLoggedDate: Date,
    val goalDate: Date
    )