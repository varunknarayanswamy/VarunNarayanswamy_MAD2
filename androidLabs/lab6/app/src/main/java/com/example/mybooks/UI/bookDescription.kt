package com.example.mybooks.UI

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.mybooks.R


class bookDescription : Fragment() {

    private lateinit var sharedSearchViewModel: SharedSearchViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val root = inflater.inflate(R.layout.fragment_book_description, container, false)
        var titleTextView = root.findViewById<TextView>(R.id.BookTitleTextView)
        val authorTextView = root.findViewById<TextView>(R.id.authorTextView)
        val bookTypeTextView = root.findViewById<TextView>(R.id.bookTypeTextView)
        val pagesTextView = root.findViewById<TextView>(R.id.pagesTextView)
        val ratingTextView = root.findViewById<TextView>(R.id.ratingTextView)

        sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)

        sharedSearchViewModel.selectedBook.observe(viewLifecycleOwner, Observer {
            titleTextView.text = it.volumeInfo.title
            var authorString = ""
            if (it.volumeInfo.authors != null) {
                for (author in it.volumeInfo.authors) {
                    if (author == it.volumeInfo.authors.last()) {
                        authorString += author
                    } else {
                        authorString += author + ","
                    }
                }
            }
            else{
                authorString = "no authors for this media"
            }
            authorTextView.text = authorString
            bookTypeTextView.text = it.volumeInfo.printType
            if (it.volumeInfo.pageCount != null) {
                pagesTextView.text = it.volumeInfo.pageCount.toString()
            }
            else
            {
                pagesTextView.text = "page number is not available or applicable"
            }
            if (it.volumeInfo.rating != null) {
                ratingTextView.text = it.volumeInfo.rating.toString()
            }
            else{
                ratingTextView.text = "rating is not available or applicable"
            }
        })


        return root
    }

}
