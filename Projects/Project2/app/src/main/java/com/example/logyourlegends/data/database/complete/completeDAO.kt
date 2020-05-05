package com.example.logyourlegends.data.database.complete

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface completeDAO {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertComplete(complete: complete)

    @Query("SELECT * FROM complete_table")
    fun getAllComplete(): LiveData<List<complete>>
}