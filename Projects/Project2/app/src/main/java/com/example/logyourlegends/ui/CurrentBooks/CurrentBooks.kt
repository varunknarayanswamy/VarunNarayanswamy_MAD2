package com.example.logyourlegends.ui.CurrentBooks

import android.os.Bundle
import android.util.Log
import android.view.*
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import com.example.logyourlegends.R
import com.example.logyourlegends.data.LOG_TAG
import com.example.logyourlegends.data.models.BookChosen
import com.example.logyourlegends.ui.adapters.BookListAdapter

class CurrentBooks : Fragment(), BookListAdapter.BookItemListener {

    private lateinit var bookRecyclerView: RecyclerView
    private lateinit var currentVM: CurrentBooksViewModel
    private lateinit var navController: NavController
    private lateinit var adapter: BookListAdapter


    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        setHasOptionsMenu(true)

        val root = inflater.inflate(R.layout.fragment_current_books, container, false)
        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)
        currentVM = ViewModelProvider(requireActivity()).get(CurrentBooksViewModel::class.java)
        bookRecyclerView = root.findViewById(R.id.currentBookList)
        adapter = BookListAdapter(requireContext(), emptyList<BookChosen>(), this)
        bookRecyclerView.adapter = adapter
        // Inflate the layout for this fragment
        currentVM.currentBooks.observe(viewLifecycleOwner, Observer {
            adapter.bookList = it
            adapter.notifyDataSetChanged()
        })
        return root
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.additem,menu)
        super.onCreateOptionsMenu(menu, inflater)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        if (item.itemId == R.id.addBook){
            navController.navigate(R.id.action_currentBooks_to_searchBooks)
        }
        return super.onOptionsItemSelected(item)
    }

    override fun onCurrentBookClick(bookChosen: BookChosen) {
        Log.i(LOG_TAG, "current clicked")
        currentVM.selectedCurrentBook.value = bookChosen
        navController.navigate(R.id.action_currentBookList_to_bookLogging)
    }

    override fun onBookLongClicked(bookChosenID: Int) {
        currentVM.removeCurrent(bookChosenID)
    }
}
