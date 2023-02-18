
# Game Listing

Games Store app that list console games from [rawg.io](https://rawg.io) and store it into database then display to user.

## Screenshots

* ### iPhone:

<p float="left" align="center">
<img src="/screenshots/simulator_screenshot_78EA2134-3A73-4893-90F0-A6689067EBD3.png" width="40%"/>
<img src="/screenshots/simulator_screenshot_B98ABEDA-783E-4049-866A-00E91E6B18FB.png" width="40%"/>
</p>

* ### iPad:

<p float="left" align="center">
<img src="/screenshots/simulator_screenshot_247CF45D-7EC5-4D6D-9090-C8C11DD1FC3C.png" width="45%"/>
<img src="/screenshots/simulator_screenshot_0E182E76-D17F-462D-8E10-0161DA037149.png" width="45%"/>
</p>


## Features

- [x] Persistence
- [x] Pagination
- [x] Support for iPad
- [x] Rotation Support
- [ ] Unit / UI Testing

## Need to know

- Used clean architecture with MVVM to achieve code separation, easy testing, maintainable code and more.
- What I liked the most in the task is:
    + Multi screens support, because it's nice to see an app that works on almost any screen device.
      the offline first feature.

## What to improve if I have time
- Missing for Unit test as i did not have time but i will do it later.
- There's issues related to largeTitles when navigate to details screens.
- The app is almost ready for the store, only a few bugs to fix if I have more time.

## Comments

- The task was very good and challenging, made me to do some research to apply the best practices.
- A side note, I estimated the task on the main features including pagination without the other bonus requirements but I figured that making most of
  bonus features will be good at the end and it takes more time.

## API Key

Get one from [rawg.io/apidocs](https://rawg.io/apidocs) and put it inside `Resources/DebugConfirguration and Resources/ProductionConfiguration` like this `API_KEY=api_key_here`

## Built With

* Swift
* MVVM
* Clean Architecture

## Libraries

* Read More library.
