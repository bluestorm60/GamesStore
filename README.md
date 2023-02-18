
# Game Listing

Games Store app that list console games from [rawg.io](https://rawg.io) and store it into database then display to user.

## Screenshots

* ### Phone:

<p float="left" align="center">
<img src="/screenshots/simulator_screenshot_375401F8-05D5-477D-9ED6-932EAA96752E.jpg" width="40%"/>
<img src="/screenshots/simulator_screenshot_4452BB2B-E3A7-472B-A37F-D6E38C361817" width="40%"/>
</p>

* ### Tablet:

<p float="left" align="center">
<img src="/screenshots/simulator_screenshot_247CF45D-7EC5-4D6D-9090-C8C11DD1FC3C.png" width="45%"/>
<img src="/screenshots/simulator_screenshot_0E182E76-D17F-462D-8E10-0161DA037149.png" width="45%"/>
</p>


## Features

- [x] Modularization
- [x] Persistence
- [x] Pagination
- [x] Material Design
- [x] Support for Tablets
- [x] Rotation Support
- [ ] Unit / UI Testing (Partial)

## Need to know

- The app is offline first and I used `RemoteMediator` from `Paging` library with `Room` to help achieving SSOT (Single Source of Truth).
- Used clean architecture with MVVM to achieve code separation, easy testing, maintainable code and more. Also MVVM have a huge support from Google
  and the community.
- What I liked the most in the task is:
    + Multi screens support, because it's nice to see an app that works on almost any screen device.
      the offline first feature.

## What to improve if I have time
- Missing for Unit test as i didnot have time but i will do it later.
- There's issues related to largeTitles when navigate to details screens.
- The app is almost ready for the store, only a few bugs to fix if I have more time.

## Comments

- The task was very good and challenging, made me to do some research to apply the best practices.
- A side note, I estimated the task on the main features including pagination without the other bonus requirements but I figured that making most of
  bonus features will be good at the end and it takes more time.

## API Key

Get one from [rawg.io/apidocs](https://rawg.io/apidocs) and put it inside `local.properties` like this `API_KEY="api_key_here"`

## Built With

* Swift
* MVVM
* Clean Architecture

## Libraries

* Read More library.
