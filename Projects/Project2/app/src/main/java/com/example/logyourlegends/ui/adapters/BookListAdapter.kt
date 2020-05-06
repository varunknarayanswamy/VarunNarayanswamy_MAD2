package com.example.logyourlegends.ui.adapters

import android.content.Context
import android.os.Build
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.annotation.RequiresApi
import androidx.recyclerview.widget.RecyclerView
import com.example.logyourlegends.R
import com.example.logyourlegends.data.models.BookChosen
import java.time.ZoneId
import java.time.format.DateTimeFormatter
import java.time.format.FormatStyle
import java.util.*

class BookListAdapter(val context: Context, var bookList: List <BookChosen>, val itemListener: BookItemListener): RecyclerView.Adapter<BookListAdapter.ViewHolder>() {

    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView){
        val bookNameText = itemView.findViewById<TextView>(R.id.bookName)
        val authorText = itemView.findViewById<TextView>(R.id.bookAuthor)
        val lastLog = itemView.findViewById<TextView>(R.id.lastBookLog)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val view = inflater.inflate(R.layout.book_list_items, parent, false)
        return ViewHolder(view)
    }

    override fun getItemCount() = bookList.count()

    @RequiresApi(Build.VERSION_CODES.O)
    @SuppressWarnings("deprecation")
    override fun onBindViewHolder(holder: ViewHolder, position: Int) {

        val curBook = bookList[position]

        var formatter = DateTimeFormatter.ofLocalizedDateTime( FormatStyle.SHORT)
            .withLocale( Locale.US )
            .withZone( ZoneId.systemDefault())
        val formattedDate = formatter.format(curBook.currentDate.toInstant())
        holder.bookNameText.text = curBook.bookName
        holder.authorText.text = curBook.author
        holder.lastLog.text = formattedDate

        holder.itemView.setOnClickListener{
            itemListener.onCurrentBookClick(curBook)
        }
        holder.itemView.setOnLongClickListener {
            itemListener.onBookLongClicked(curBook.id)
            true
        }
    }

    interface BookItemListener{
        fun onCurrentBookClick(bookChosen: BookChosen)
        fun onBookLongClicked(bookChosenID: Int)
    }


}

