package com.example.apirateslifeforme.data

import android.content.Context
import androidx.room.*
import com.example.apirateslifeforme.data.database.pirateSaved.PirateDAO
import com.example.apirateslifeforme.data.database.pirateSaved.PirateMember

@Database(entities = [PirateMember::class],
    version = 2,
    exportSchema = false)
@TypeConverters(Converters::class)

abstract class AppDatabase: RoomDatabase() {
    abstract fun pirateDAO(): PirateDAO

    companion object{
        var INSTANCE: AppDatabase? = null

        fun getDatabase(context: Context): AppDatabase {
            val tempInstance = INSTANCE
            if(tempInstance != null) return tempInstance
            synchronized(this){
                val instance = Room.databaseBuilder(context.applicationContext, AppDatabase::class.java, "pirate_database")
                    .fallbackToDestructiveMigration()
                    .build()
                INSTANCE = instance
                return instance
            }

        }
    }
}