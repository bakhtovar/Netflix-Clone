# Netflix-Clone
The clone of Netflix iOS application that displays movies and searches them from [TMDB API](https://www.themoviedb.org).

## Description

This appication allows users to see Top Rated, Popular, Upcoming movies from the API. Netflix Clone collects and displays them in the CollectionView. The users also could search for desired movies. Also, it has downloads where the user can store desired movies to watch later.

## Built by
* [Swift](https://developer.apple.com/swift/) language.
* [SDWebImage](https://github.com/SDWebImage/SDWebImage) library.
* [CoreData](https://developer.apple.com/documentation/coredata) library.
* [SnapKit](https://github.com/SnapKit/SnapKit) library.
* [UIKit](https://developer.apple.com/documentation/uikit/) library.
* [TMDB API](https://www.themoviedb.org) API.
* [Youtube API](https://developers.google.com/youtube/v3) API.


## How to use

```
struct Constants{
    static let API_KEY = "API_KEY" // Enter an api key 
    static let BASE_URL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "YoutubeAPI_KEY" // Enter a Youtube API
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}
```


Enter your API_KEY and YoutubeAPI_KEY inside the quotes marks! Without it the application will not work.


## Screenshots
<img src="Netflix Clone/AppScreenshots/Download.png" width="200"> <img src="Netflix Clone/AppScreenshots/Delete.png" width="200"> <img src="Netflix Clone/AppScreenshots/Upcoming.png" width="200"> <img src="Netflix Clone/AppScreenshots/Home.png" width="200">

<img src="Netflix Clone/AppScreenshots/Favorites.png" width="200" > <img src="Netflix Clone/AppScreenshots/Search.png" width="200">
<img src="Netflix Clone/AppScreenshots/WebView.png" width="200" > 
