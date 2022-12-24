# Ten Percent Happier Technical Challenge

An iOS project showcasing technical skills architecting a simple app and working with networking, persistence, and user interface APIs.


##  Table of Contents
- [About](#about)
- [Libraries](#libraries)
- [Tools](#tools)
- [Decisions](#decisions)


## About
A two-screen iOS app that displays a list of featured topics on the first screen, and a list of meditations on second screen, organized by subtopic.

Upon receiving the data from the API, the app stores the data locally. The UI obtains its data from the persistance layer and is available for offline use.


## Libraries
SDWebImage is used to handle async image downloading and caching.


## Tools
Xcode 14.2.0

UIKit (Storyboard)

CoreData Framework

Swift Package Manager


## Decisions
I built my own networking layer instead of using a library. Network requests were made using async/await. It was my first time using it, but the result is less code that is easier to read. 

The real heavy lifter in the app is the CoreData framework. I initially considered storing the JSON to disk in plists, but I soon realized what was sorely missing was relationships between the data structures. CoreData does this quite well. I've not worked with it for a long time, so this is what I spent the majority of time focused on.

I chose to use Storyboard for building the UI to save time and avoid writing tedious layout code. 

I used SDWebImage mainly to add image caching capabilities, which makes loading images in reusable cells much more performant. **Note:** Some of the image asset urls are missing a host, so I gave the image view a default background color.

