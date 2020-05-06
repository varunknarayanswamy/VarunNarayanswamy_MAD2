package com.example.logyourlegends.ui.searchBooks

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import com.example.logyourlegends.R
import com.example.logyourlegends.data.LOG_TAG
import com.example.logyourlegends.data.models.Book
import com.example.logyourlegends.ui.CurrentBooks.CurrentBooksViewModel
import com.example.logyourlegends.ui.adapters.BookSearchAdapter

class searchBooks : Fragment(), BookSearchAdapter.BookItemListener {

    private lateinit var searchEditText: EditText
    private lateinit var searchRecyclerView: RecyclerView
    private lateinit var searchVM: SearchBooksViewModel
    private lateinit var currentVM: CurrentBooksViewModel
    private lateinit var navController: NavController
    private lateinit var searchButton: Button
    private lateinit var adapter: BookSearchAdapter


    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)
        searchVM = ViewModelProvider(requireActivity()).get(SearchBooksViewModel::class.java)
        currentVM = ViewModelProvider(requireActivity()).get(CurrentBooksViewModel::class.java)
        val root = inflater.inflate(R.layout.fragment_search_books, container, false)
        searchRecyclerView = root.findViewById(R.id.bookSearchRecyclerView)
        searchEditText = root.findViewById(R.id.searchEditText)
        adapter = BookSearchAdapter(requireContext(), emptyList<Book>(), this)
        searchRecyclerView.adapter = adapter
        searchButton = root.findViewById(R.id.searchButton)


        searchButton.setOnClickListener {
            searchBooks()
        }

        searchVM.bookDetails.observe(viewLifecycleOwner, Observer {
            Log.i(LOG_TAG, "change has been made")
            adapter.bookList = it
            adapter.notifyDataSetChanged()
        })
        // Inflate the layout for this fragment
        return root
    }

    private fun searchBooks() {
        val searchTerm = searchEditText.text.toString()
        if (searchTerm != null && searchTerm != "") {
            searchVM.searchUserInput.value = searchTerm
        }
    }

    override fun onBookItemClick(book: Book) {
        searchVM.selectedSearchBook.value = book
        navController.navigate(R.id.action_searchBooks_to_bookDetails)
    }
}
