package com.example.mybooks.UI

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import com.example.mybooks.R

class SearchBooks : Fragment() {
    private lateinit var sharedSearchViewModel: SharedSearchViewModel
    private lateinit var navController: NavController

    private lateinit var searchButton: Button
    private lateinit var searchEditText: EditText

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)
        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)

        val root = inflater.inflate(R.layout.fragment_search_books, container, false)

        searchButton = root.findViewById(R.id.searchButton)
        searchEditText = root.findViewById(R.id.searchInput)

        searchButton.setOnClickListener {
            searchBooks()
        }
        return root
    }

    private fun searchBooks() {
        val searchTerm = searchEditText.text.toString()
        if (searchTerm != null && searchTerm != "") {
            sharedSearchViewModel.searchUserInput.value = searchTerm
            navController.navigate(R.id.action_searchBooks_to_bookList)
        }
    }

}
