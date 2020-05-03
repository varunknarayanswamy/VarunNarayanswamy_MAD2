package com.example.logyourlegends.data.services

import com.example.logyourlegends.data.API_KEY
import com.example.logyourlegends.data.models.SearchResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface GoogleBooksService {
    @GET("books/v1/volumes?apiKey=${API_KEY}")
    fun searchBooks(@Query("q") searchTerm: String): Call<SearchResponse>
}