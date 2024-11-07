# **Movie Mania**

I made this app with Flutter using clean architecture and  bloc as state management.

## Description

Screen Scene is a Movie and TV Show data app and searching for them too.
I used (TMDB) for fetching the data.

## Badges

| Splash View | Home View | Popular Movies | Top Rated Movies |
| :-----------: | :---------: | :------------: | :--------------: |
![](https://github.com/user-attachments/assets/7833d356-d4b4-4e18-affe-be2237f45515)|![](https://github.com/AhmedKhaled8907/movies_app/blob/main/screenshots/movie.png?raw=true)|![](https://github.com/AhmedKhaled8907/movies_app/blob/main/screenshots/popular_movie.png?raw=true)|![](https://github.com/AhmedKhaled8907/movies_app/blob/main/screenshots/toprated_movie.png?raw=true)

| Movie Details View | Similar View | Movie Search Movies | 
| :-----------: | :---------: | :------------: 
![](https://github.com/AhmedKhaled8907/movies_app/blob/main/screenshots/movie_details.png?raw=true)|![](https://github.com/AhmedKhaled8907/movies_app/blob/main/screenshots/similar.png?raw=true)|![](https://github.com/AhmedKhaled8907/movies_app/blob/main/screenshots/movie_search.png?raw=true)|![]


| Light Movie View | Light Movie Details View | Light Search | 
| :-----------: | :---------: | :------------: 
![](https://github.com/AhmedKhaled8907/movies_app/blob/main/screenshots/light_movie.png?raw=true)|![](https://github.com/AhmedKhaled8907/movies_app/blob/main/screenshots/light_movie_details.png?raw=true)|![](https://github.com/AhmedKhaled8907/movies_app/blob/main/screenshots/light_search.png?raw=true)|![]

## Dependencies
```yaml
  animate_do: ^3.3.4
  cached_network_image: ^3.3.1
  carousel_slider: ^4.2.1
  cupertino_icons: ^1.0.6
  dartz: ^0.10.1
  dio: ^5.4.3+1
  equatable: ^2.0.5
  flutter_controller: ^8.1.6
  get_it: ^7.7.0
  google_fonts: ^6.2.1
  shared_preferences: ^2.2.3
  shimmer: ^3.0.0
```
## Directory Structure for project

```
├───core
│   ├───error
│   ├───global
|   |   ├───resources
|   |   └───theme
│   └───utils
│       ├───custom_widgets
│       ├───entities
│       ├───models
│       ├───network
│       ├───services
│       └───use_cases
└───features
    ├───home
    │   ├───bottom_nav_bar_cubit
    │   └───views
    ├───movie
    │   ├───data
    │   │   ├───data_sources
    │   │   ├───models
    │   │   └───repos
    │   ├───domain
    │   │   ├───entities
    │   │   ├───repos
    │   │   └───use_cases
    │   └───presentation
    │       ├───controller
    │       └───views
    │           |───movie_details_view
    |           └───movie_view
    ├───search
    │   ├───data
    │   │   ├───data_sources
    │   │   ├───models
    │   │   └───repos
    │   ├───domain
    │   │   ├───entities
    │   │   ├───repos
    │   │   └───use_cases
    │   └───presentation
    │       ├───controller
    │       └───views
    |           └───widgets
    ├───settings
    │   └───presentation
    │       └───views
    |            └───widgets  
    ├───splash
    │   └───presentation
    │       └───views
    |            └───widgets  
    └───tvs
        ├───data
        |   ├───data_sources
        |   ├───models
        |   └───repos
        ├───domain
        │   ├───entities
        │   ├───repos
        │   └───use_cases
        └───presentation
            ├───controller
            └───views
                |───tv_details_view
                └───tv_view
    
```


  
