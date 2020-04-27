package com.example.apirateslifeforme

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.EditText
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.RecyclerView
import com.example.apirateslifeforme.data.models.PirateMember
import com.example.apirateslifeforme.data.pirateViewModel
import java.util.*

class MainActivity : AppCompatActivity() {

    private lateinit var pirateVM: pirateViewModel
    private lateinit var pirateRecyclerView: RecyclerView
    private lateinit var adapter: PirateRecyclerAdapter
    private lateinit var pirateNameInput: EditText
    private lateinit var positionInput: EditText
    private lateinit var pirateButton: Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        pirateVM = ViewModelProvider(this).get(pirateViewModel::class.java)
        pirateRecyclerView = this.findViewById(R.id.PirateList)
        pirateNameInput = this.findViewById(R.id.pirateName)
        positionInput = this.findViewById(R.id.piratePosition)
        pirateButton = this.findViewById(R.id.pirateButton)
        adapter = PirateRecyclerAdapter(emptyList<PirateMember>())
        pirateRecyclerView.adapter = adapter

        pirateButton.setOnClickListener {
            addPirate()
        }

        pirateVM.pirateList.observe(this, Observer {
            adapter.pirateList = it
            adapter.notifyDataSetChanged()
        })
    }

    private fun addPirate(){
        Log.i("add pirate", "add Pirate function")
        val date = Calendar.getInstance().time
        pirateVM.addPirate(PirateMember(0,"Luffy","Captain", date,0))
    }

}
