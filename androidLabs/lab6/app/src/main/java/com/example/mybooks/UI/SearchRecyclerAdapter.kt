package com.example.mybooks.UI

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.appcompat.view.menu.ActionMenuItemView
import androidx.recyclerview.widget.RecyclerView
import com.example.mybooks.R
import com.example.mybooks.data.Book
import kotlinx.android.synthetic.main.book_list_item.view.*

class SearchRecyclerAdapter(val context: Context, val bookList: List<Book> , val itemListener: BookItemListener) : RecyclerView.Adapter<SearchRecyclerAdapter.ViewHolder>() {
    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView){
        val titleText = itemView.findViewById<TextView>(R.id.titleTextView)
        val prepText = itemView.findViewById<TextView>(R.id.prepTextView)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val view = inflater.inflate(R.layout.book_list_item, parent, false)
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