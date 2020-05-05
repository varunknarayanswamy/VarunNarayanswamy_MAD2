package com.example.logyourlegends.ui.details

import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import android.widget.TextView
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import com.example.logyourlegends.R
import com.example.logyourlegends.data.models.Book
import com.example.logyourlegends.data.models.BookChosen
import com.example.logyourlegends.ui.CurrentBooks.CurrentBooksViewModel
import com.example.logyourlegends.ui.searchBooks.SearchBooksViewModel
import java.util.*

class bookDetails : Fragment() {
    private lateinit var titleTextView: TextView
    private lateinit var authorTextView: TextView
    private lateinit var pagesTextView: TextView
    private lateinit var descriptionTextView: TextView
    private lateinit var navController: NavController
    private lateinit var searchVM: SearchBooksViewModel
    private lateinit var currentVM: CurrentBooksViewModel
    private lateinit var selectedBook: Book

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        setHasOptionsMenu(true)
        // Inflate the layout for this fragment
        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)
        searchVM = ViewModelProvider(requireActivity()).get(SearchBooksViewModel::class.java)
        currentVM = ViewModelProvider(requireActivity()).get(CurrentBooksViewModel::class.java)

        val root = inflater.inflate(R.layout.fragment_book_details, container, false)
        titleTextView = root.findViewById(R.id.bookTitle)
        authorTextView = root.findViewById(R.id.AuthorsTextView)
        pagesTextView = root.findViewById(R.id.PagesTextView)
        descriptionTextView = root.findViewById(R.id.DescriptionTextView)

        searchVM.selectedBook.observe(viewLifecycleOwner, androidx.lifecycle.Observer {
            selectedBook = it
            titleTextView.text = it.volumeInfo.title
            if (it.volumeInfo.authors != null)
            {
                authorTextView.text = it.volumeInfo.authors.toString()
            }
            else
            {
                authorTextView.text = "No known authors"
            }
            if (it.volumeInfo.pageCount != null)
            {
                pagesTextView.text = it.volumeInfo.pageCount.toString()
            }
            else
            {
                pagesTextView.text = "No pages"
            }
            if (it.volumeInfo.description != null)
            {
                descriptionTextView.text = it.volumeInfo.description
            }
            else
            {
                descriptionTextView.text = "No Description"
            }
        })
        return root
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.additem,menu)
        super.onCreateOptionsMenu(menu, inflater)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        if (item.itemId == R.id.addBook){
            currentVM.addCurrent(
                BookChosen(0,selectedBook.volumeInfo.title,selectedBook.volumeInfo.authors.toString(),selectedBook.volumeInfo.pageCount,0,
                    Date(),
                    Date()
                )
            )
            navController.navigate(R.id.action_bookDetails_to_currentBookList)
        }
        return super.onOptionsItemSelected(item)
    }
}
