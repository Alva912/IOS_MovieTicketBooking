# IOS MovieTicketBooking 🎞
A movie-tickets booking mobile app for movie lovers😻.

## Environment Setup
1. First of all, `gem` and `ruby` normally comes with the macOS, just open the `terminal` and check the version of them.

2. When they are new and fresh and ready, install [cocoapods](https://cocoapods.org/).
```
sudo gem install -n /usr/local/bin cocoapods

pod setup

cd [ourProjectRootDirectary]

pod install
```
3. Additionally, [rvm](https://rvm.io/) and [homebrew](https://brew.sh/) are very handy when stuck at `ruby`.

4. Finally, use `.xcworkspace` to open our project file.

## Main Features

1. Sufficient movie info of new movies and outdated ones
    - Initially show all movies that are now playing on main page
    - 8 filter/options available so far
    - Search by keyword among all movies
    - More options to do...
2. Bulk-booking and all-in-one scheduling process (ideally)
    - A shopping-cart-like booking list
    - Max booking list length 20
    - Max ticket number 10 for each movie
3. User login and online payment
4. To be continue...

## Libraries & Tools
- [AFNetworking](https://github.com/AFNetworking/AFNetworking) for fetching images in UIImage
- [Alamofire](https://github.com/Alamofire/Alamofire) for making HTTP request
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) for parsing JSON data
- [JSON Cafe](http://www.jsoncafe.com/) for generating models from JSON data online
- [DropDown](https://github.com/AssistoLab/DropDown.git) for adding DropDown menu
