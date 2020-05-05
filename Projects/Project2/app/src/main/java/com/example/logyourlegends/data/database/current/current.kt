package com.example.logyourlegends.data.database.current

import androidx.room.Entity
import androidx.room.PrimaryKey
import java.util.*

@Entity(tableName = "current_table")
data class current (
    @PrimaryKey val current_id: Int,
    val title: String,
    val Author: String?,
    val pages: Int?,
    val pagesRead: Int,
    val lastLoggedDate: Date,
    val goalDate: Date
)