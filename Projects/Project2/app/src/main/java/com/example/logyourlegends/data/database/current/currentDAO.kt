package com.example.logyourlegends.data.database.current

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
@Dao
interface currentDAO {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertCurrent(current: current)

    @Query("SELECT * FROM current_table")
    fun getAllCurrent(): LiveData<List<current>>

    @Query("DELETE FROM current_table WHERE current_id = :id")
    fun removeCurrent(id: Int)
}