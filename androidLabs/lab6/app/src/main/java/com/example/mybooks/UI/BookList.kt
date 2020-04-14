package com.example.mybooks.UI

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import com.example.mybooks.LOG_TAG
import com.example.mybooks.R
import com.example.mybooks.data.Book

class BookList : Fragment(), SearchRecyclerAdapter.BookItemListener {

    private lateinit var recyclerView: RecyclerView
    private lateinit var sharedSearchViewModel: SharedSearchViewModel
    private lateinit var navController: NavController

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)
        sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)
        val root = inflater.inflate(R.layout.fragment_book_list, container, false)
        recyclerView = root.findViewById(R.id.recyclerView)

        sharedSearchViewModel.bookDetails.observe(viewLifecycleOwner, Observer {
            val adapter = SearchRecyclerAdapter(requireContext(), it, this)
            recyclerView.adapter = adapter
        })
        return root
    }

    override fun onBookItemClick(book: Book){
        Log.i(LOG_TAG, book.toString())
        sharedSearchViewModel.selectedBook.value = book
        navController.navigate(R.id.action_bookList_to_bookDescription)
    }

}
