package com.example.logyourlegends.data.database.current

import androidx.room.Entity
import androidx.room.PrimaryKey
import java.util.*

@Entity(tableName = "current_table")
data class current (
    @PrimaryKey(autoGenerate = true) val current_id: Int = 0,
    val title: String,
    val Author: String?,
    val pages: Int?,
    val pagesRead: Int,
    val lastLoggedDate: Date,
    val goalDate: Date
)