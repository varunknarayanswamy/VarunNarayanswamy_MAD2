package com.example.apirateslifeforme.data.database.pirateSaved

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query


@Dao
interface PirateDAO {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertPirate(pirateMember: PirateMember)

    @Query("SELECT * FROM pirate_table")
    fun getAllPirates():LiveData<List<PirateMember>>
}