package com.example.logyourlegends.ui.CompletedBooks

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
import com.example.logyourlegends.R
import com.example.logyourlegends.data.LOG_TAG
import com.example.logyourlegends.data.models.BookChosen
import com.example.logyourlegends.ui.CurrentBooks.CurrentBooksViewModel
import com.example.logyourlegends.ui.adapters.BookListAdapter

class CompletedBooks : Fragment(), BookListAdapter.BookItemListener {

    private lateinit var bookRecyclerView: RecyclerView
    private lateinit var completeVM: CompletedBookViewModel
    private lateinit var navController: NavController
    private lateinit var adapter: BookListAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val root = inflater.inflate(R.layout.fragment_completed_books, container, false)
        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)
        completeVM = ViewModelProvider(requireActivity()).get(CompletedBookViewModel::class.java)
        bookRecyclerView = root.findViewById(R.id.CompleteBookList)
        adapter = BookListAdapter(requireContext(), emptyList<BookChosen>(), this)
        bookRecyclerView.adapter = adapter
        // Inflate the layout for this fragment
        completeVM.completedBooks.observe(viewLifecycleOwner, Observer {
            adapter.bookList = it
            adapter.notifyDataSetChanged()
        })
        return root
    }

    override fun onCurrentBookClick(bookChosen: BookChosen) {
        Log.i(LOG_TAG,"Completed book clicked")
    }

    override fun onBookLongClicked(bookChosenID: Int) {
        completeVM.removeComplete(bookChosenID)
    }
}
