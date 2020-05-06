package com.example.logyourlegends.data.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import com.example.logyourlegends.data.database.complete.complete
import com.example.logyourlegends.data.database.complete.completeDAO
import com.example.logyourlegends.data.database.current.current
import com.example.logyourlegends.data.database.current.currentDAO


@Database(entities = [current::class, complete::class],
    version = 3,
    exportSchema = false)
@TypeConverters(Converters::class)
abstract class AppDatabase: RoomDatabase() {
    abstract fun completeDAO(): completeDAO
    abstract fun currentDAO(): currentDAO

    companion object {
        var INSTANCE: AppDatabase? = null

        //get reference to database OR create
        fun getDatabase(context: Context): AppDatabase {
            val tempInstance = INSTANCE
            //return instance if it exists
            if(tempInstance != null) return tempInstance

            //create instance if it does not exist
            synchronized(this) {
                val instance = Room.databaseBuilder(context.applicationContext, AppDatabase::class.java, "books_database")
                    .fallbackToDestructiveMigration()
                    .build()

                INSTANCE = instance
                return instance
            }
        }
    }

}