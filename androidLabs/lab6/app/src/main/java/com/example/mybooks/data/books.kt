package com.example.mybooks.data
import  com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
data class SearchResponse(
    val kind: String,
    val totalItems: Int,
    val items: List<Book>
)

@JsonClass(generateAdapter = true)
data class Book (
    val id: String,
    val volumeInfo: VolumeInfo
)

@JsonClass(generateAdapter = true)
data class VolumeInfo (
    val title: String,
    val authors: List<String>?,
    val description: String?,
    val pageCount: Int?,
    val printType: String,
    val rating: Double?
)