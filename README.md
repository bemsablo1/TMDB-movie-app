# TMDb iOS Movie App

A simple iOS application built in **Swift** that integrates with [The Movie Database (TMDb) API](https://www.themoviedb.org/documentation/api).  
The app allows users to browse popular movies, view detailed information, watch trailers, search for movies, and manage favorite movies.

## Features

### 1. Movies List (Home)
- Displays a list of popular movies.
- Each movie shows:
  - Title
  - Duration
  - Rating
  - Poster image
- API used:  
`https://api.themoviedb.org/3/movie/popular?api_key={API_KEY}`

### 2. Movie Detail Page
- On selecting a movie, navigate to a detail screen.
- Features:
  - Video player to play trailer
  - Movie Title, Plot, Genres, Cast, Duration, Rating
- APIs used:  
  - Movie Details: `https://api.themoviedb.org/3/movie/{movie_id}?api_key={API_KEY}`  
  - Trailers: `https://api.themoviedb.org/3/movie/{movie_id}/videos?api_key={API_KEY}`

### 3. Search
- Search movies by title from the Home screen.
- API used:  
`https://api.themoviedb.org/3/search/movie?api_key={API_KEY}&query={QUERY}`

### 4. Favorites
- Mark/unmark favorite movies from both list and detail screens.
- Favorites persist on app relaunch using local sto
