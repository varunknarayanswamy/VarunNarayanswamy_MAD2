package com.example.apirateslifeforme

import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.apirateslifeforme.data.models.PirateMember

class PirateRecyclerAdapter(var pirateList: List<PirateMember>, val itemListener: PirateItemListener) : RecyclerView.Adapter<PirateRecyclerAdapter.ViewHolder>() {
    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val pirateName: TextView = itemView.findViewById(R.id.pirateNameTextView)
        val position: TextView = itemView.findViewById(R.id.positionTextView)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        Log.i("onCreate", pirateList.size.toString())
        val newItemView = LayoutInflater.from(parent.context).inflate(R.layout.pirate_list_item, parent, false)
        return ViewHolder(newItemView)
    }

    override fun getItemCount() = pirateList.size

    override fun onBindViewHolder(holder: ViewHolder, position: Int){
        val currentItem = pirateList[position]
        holder.pirateName.text = currentItem.pirateName
        holder.position.text = currentItem.piratePosition

        holder.itemView.setOnClickListener {
            itemListener.onMemberClicked(currentItem.pirate_id)
        }
    }

    interface PirateItemListener{
        fun onMemberClicked(member_id: String)
    }

}
