package com.example.logyourlegends.data.models

import com.example.logyourlegends.data.database.complete.complete
import com.example.logyourlegends.data.database.current.current
import java.util.*

data class BookChosen (
    val id: Int,
    val bookName: String,
    val author: String?,
    val pages: Int?,
    val pagesRead: Int,
    val currentDate: Date,
    val endDate: Date
){
    fun getRoomCurrent(): current{
        return current(id,bookName,author,pages,pagesRead,currentDate,endDate)
    }
    fun getRoomComplete(): complete{
        return complete(id,bookName,author,pages,pagesRead,currentDate,endDate)
    }
    companion object{
        fun fromRoomCurrent(current: current): BookChosen{
            return BookChosen(current.current_id,current.title,current.Author, current.pages, current.pagesRead, current.lastLoggedDate, current.goalDate)
        }

        fun fromRoomComplete(complete: complete): BookChosen{
            return BookChosen(complete.complete_id,complete.title,complete.Author, complete.pages, complete.pagesRead, complete.lastLoggedDate, complete.goalDate)
        }
    }

}