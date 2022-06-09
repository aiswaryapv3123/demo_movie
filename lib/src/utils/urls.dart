class Url {
  static const baseUrl = "https://api.themoviedb.org";
  static const imagePathBaseUrl = "https://image.tmdb.org/t/p/original";
  static const apiKey = "6baea5ef838664a28d1e5b5e8ca1635b";
  static const trending = "$baseUrl/3/trending/all/day?api_key=$apiKey";
  static const genres = "$baseUrl/3/genre/movie/list?api_key=6baea5ef838664a28d1e5b5e8ca1635b";
  static const nowPlaying = "$baseUrl/3/movie/now_playing?api_key=$apiKey";
  static const movies = "$baseUrl/3/discover/movie?api_key=$apiKey";
  // https://api.themoviedb.org/3/genre/movie/list?api_key=6baea5ef838664a28d1e5b5e8ca1635b&language=en-US$apiKey";
}
// "https://api.themoviedb.org/3/discover/movie?api_key=6baea5ef838664a28d1e5b5e8ca1635b"