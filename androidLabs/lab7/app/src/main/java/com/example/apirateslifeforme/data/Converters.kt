package com.example.apirateslifeforme.data

import androidx.room.TypeConverter
import java.util.*

class Converters {
        @TypeConverter
        fun fromTimestamp(value: Long?): Date?{
            return value?.let { Date(it) }
        }

        @TypeConverter
        fun dateToTimestapme(date: Date?): Long?{
            return date?.time?.toLong()
        }
}
