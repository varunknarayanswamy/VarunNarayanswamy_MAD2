package com.example.logyourlegends.data.database.complete

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface completeDAO {
    @Insert(onConflict = OnConflictStrategy.IGNORE)
    fun insertComplete(complete: complete)

    @Query("SELECT * FROM complete_table")
    fun getAllComplete(): LiveData<List<complete>>

    @Query("DELETE FROM complete_table WHERE complete_id = :id")
    fun removeComplete(id: Int)
}