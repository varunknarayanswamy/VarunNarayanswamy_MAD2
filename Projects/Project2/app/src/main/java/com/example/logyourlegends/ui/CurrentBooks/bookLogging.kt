package com.example.logyourlegends.ui.CurrentBooks

import android.app.AlertDialog
import android.content.DialogInterface
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.*
import androidx.fragment.app.Fragment
import android.widget.EditText
import android.widget.TextView
import androidx.annotation.RequiresApi
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import com.example.logyourlegends.R
import com.example.logyourlegends.data.LOG_TAG
import com.example.logyourlegends.data.models.BookChosen
import com.example.logyourlegends.ui.CompletedBooks.CompletedBookViewModel
import java.time.ZoneId
import java.time.format.DateTimeFormatter
import java.time.format.FormatStyle
import java.util.*
import java.util.concurrent.TimeUnit

class bookLogging : Fragment() {

    private lateinit var titleTextView: TextView
    private lateinit var authorTextView: TextView
    private lateinit var pagesTextView: TextView
    private lateinit var logPageEditText: EditText
    private lateinit var goalTextView: TextView
    private lateinit var remainingPagesTextView: TextView
    private lateinit var remainingDaysTextView: TextView

    private lateinit var currentVM: CurrentBooksViewModel
    private lateinit var completeVM: CompletedBookViewModel
    private lateinit var navController: NavController

    private lateinit var chosenBook: BookChosen

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        setHasOptionsMenu(true)
        // Inflate the layout for this fragment
        val root = inflater.inflate(R.layout.fragment_book_logging, container, false)
        titleTextView = root.findViewById(R.id.titleLoggingTextView)
        authorTextView = root.findViewById(R.id.authorLoggingTextView)
        pagesTextView = root.findViewById(R.id.pagesLoggingTextView)
        logPageEditText = root.findViewById(R.id.pageLoggingEditText)
        goalTextView = root.findViewById(R.id.goalTextView)
        remainingPagesTextView = root.findViewById(R.id.remainingPagesLogging)
        remainingDaysTextView = root.findViewById(R.id.remainingDays)

        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)
        currentVM = ViewModelProvider(requireActivity()).get(CurrentBooksViewModel::class.java)
        completeVM = ViewModelProvider(requireActivity()).get(CompletedBookViewModel::class.java)

        currentVM.selectedCurrentBook.observe(viewLifecycleOwner, androidx.lifecycle.Observer {
            chosenBook = it
            titleTextView.text = it.bookName
            if (it.author != null) {
                authorTextView.text = it.author.toString()
            } else {
                authorTextView.text = "No known authors"
            }
            pagesTextView.text = it.pages.toString()
            remainingPagesTextView.text = (it.pages?.minus(it.pagesRead)).toString()
            Log.i(LOG_TAG,"Pages Remaining " + (it.pages?.minus(it.pagesRead)).toString())
            var formatter = DateTimeFormatter.ofLocalizedDateTime(FormatStyle.SHORT)
                .withLocale(Locale.US)
                .withZone(ZoneId.systemDefault())
            val longDiff = it.endDate.time - Date().time
            val remainingDays = TimeUnit.DAYS.convert(longDiff,TimeUnit.MILLISECONDS)
            val formattedDate = formatter.format(it.endDate.toInstant())
            goalTextView.text = formattedDate
            remainingDaysTextView.text = remainingDays.toString() + " days"
        })



        return root
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.save, menu)
        super.onCreateOptionsMenu(menu, inflater)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        if (item.itemId == R.id.addBook) {
            if (logPageEditText.text.toString() != "" && logPageEditText.text.toString() != null) {
                val readPages = logPageEditText.text.toString().toInt()
                if (chosenBook.pagesRead + readPages >= chosenBook.pages!!) {
                    showAlert(true, chosenBook.pagesRead + readPages)
                    currentVM.removeCurrent(chosenBook.id)
                    completeVM.addCompleteBook(
                        BookChosen(
                            0,
                            chosenBook.bookName,
                            chosenBook.author,
                            chosenBook.pages,
                            chosenBook.pages!!,
                            Date(),
                            chosenBook.endDate
                        )
                    )
                } else {
                    val totalPagesRead = chosenBook.pagesRead + readPages
                    showAlert(false, totalPagesRead)
                    currentVM.removeCurrent(chosenBook.id)
                    currentVM.addCurrentBook(
                        BookChosen(
                            0,
                            chosenBook.bookName,
                            chosenBook.author,
                            chosenBook.pages,
                            totalPagesRead,
                            Date(),
                            chosenBook.endDate
                        )
                    )
                }
                navController.navigate(R.id.action_bookLogging_to_currentBookList)
            }
        }
        return super.onOptionsItemSelected(item)
    }

    fun showAlert(complete: Boolean, totalPagesRead: Int) {
        if (complete == true) {
            val alert = AlertDialog.Builder(context)
            alert.setTitle("Your finished!")
            alert.setMessage("You have read $totalPagesRead! Great job! Now onto your next book")
            alert.setPositiveButton("Ok", DialogInterface.OnClickListener { dialog, id ->
                dialog.dismiss()
            })
            alert.show()
        }
        else {
            val remainingPages = chosenBook.pages?.minus(totalPagesRead)
            val alert = AlertDialog.Builder(context)
            alert.setTitle("Good Work")
            alert.setMessage("You have read $totalPagesRead! You still have $remainingPages left! Keep going")
            alert.setPositiveButton("Ok", DialogInterface.OnClickListener { dialog, id ->
                dialog.dismiss()
            })
            alert.show()
        }
    }
}
