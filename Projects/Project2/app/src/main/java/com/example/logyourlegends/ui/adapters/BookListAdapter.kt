package com.example.logyourlegends.ui.adapters

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.logyourlegends.R
import com.example.logyourlegends.data.models.BookChosen

class BookListAdapter(val context: Context, var bookList: List <BookChosen>, val itemListener: BookItemListener): RecyclerView.Adapter<BookListAdapter.ViewHolder>() {

    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView){
        val bookNameText = itemView.findViewById<TextView>(R.id.bookName)
        val authorText = itemView.findViewById<TextView>(R.id.bookAuthor)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val view = inflater.inflate(R.layout.book_list_items, parent, false)
        return ViewHolder(view)
    }

    override fun getItemCount() = bookList.count()

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val curBook = bookList[position]

        holder.bookNameText.text = curBook.bookName
        holder.authorText.text = curBook.author
    }

    interface BookItemListener{
        fun onCurrentBookClick(bookChosen: BookChosen)
    }


}

