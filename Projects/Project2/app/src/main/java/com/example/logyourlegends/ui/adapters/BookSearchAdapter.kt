package com.example.logyourlegends.ui.adapters

import android.content.Context
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.logyourlegends.R
import com.example.logyourlegends.data.LOG_TAG
import com.example.logyourlegends.data.models.Book
import kotlinx.android.synthetic.main.book_search_item.view.*

class BookSearchAdapter(val context: Context, var bookList: List<Book>, val itemListener: BookItemListener) : RecyclerView.Adapter<BookSearchAdapter.ViewHolder>() {
    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView){
        val titleText = itemView.findViewById<TextView>(R.id.SearchBookName)
        val prepText = itemView.findViewById<TextView>(R.id.SearchBookAuthor)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val view = inflater.inflate(R.layout.book_search_item, parent, false)
        return ViewHolder(view)
    }

    override fun getItemCount() = bookList.count()

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val curBook = bookList[position]
        holder.titleText.text = curBook.volumeInfo.title
        holder.prepText.text = curBook.volumeInfo.authors?.get(0) ?: "no author"

        holder.itemView.setOnClickListener{
            itemListener.onBookItemClick(curBook)
        }
    }

    interface BookItemListener{
        fun onBookItemClick(book: Book)
    }
}