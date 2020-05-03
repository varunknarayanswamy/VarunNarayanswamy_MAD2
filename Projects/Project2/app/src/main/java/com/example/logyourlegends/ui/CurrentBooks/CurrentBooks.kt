package com.example.logyourlegends.ui.CurrentBooks

import android.os.Bundle
import android.util.Log
import android.view.*
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import com.example.logyourlegends.R

class CurrentBooks : Fragment() {

    private lateinit var bookRecyclerView: RecyclerView
    private lateinit var currentVM: CurrentBooksViewModel
    private lateinit var navController: NavController


    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        setHasOptionsMenu(true)

        val root = inflater.inflate(R.layout.fragment_current_books, container, false)
        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)
        currentVM = ViewModelProvider(requireActivity()).get(CurrentBooksViewModel::class.java)
        bookRecyclerView = root.findViewById(R.id.currentBookList)
        // Inflate the layout for this fragment
        return root
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        Log.i("Creating Menu","Creating Menu")
        inflater.inflate(R.menu.additem,menu)
        super.onCreateOptionsMenu(menu, inflater)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        if (item.itemId == R.id.addBook){
            navController.navigate(R.id.action_currentBooks_to_searchBooks)
        }
        return super.onOptionsItemSelected(item)
    }
}
