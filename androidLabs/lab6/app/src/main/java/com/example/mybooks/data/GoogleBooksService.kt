package com.example.mybooks.data

import com.example.mybooks.API_KEY
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Header
import retrofit2.http.Query
//https://www.googleapis.com/books/v1/volumes?q=Harry%20Potter&key=[YOUR_API_KEY]
interface GoogleBooksService {
    @GET("books/v1/volumes?apiKey=${API_KEY}")
    fun searchBooks(@Query("q") searchTerm: String): Call<SearchResponse>
}