# Home24-project by Dante Puglisi

## How to run project
Clone the repository in your computer locally and run using XCode.

This project was made using XCode 9.2 and Swift 4.

## Important info
### Architecture
The architecture used is MVC because it's easy to set up and for a small app like this one it's the best option in my opinion.

The API is handled by the class APIClient as a singleton.

The project code and files are separated in folder for better comprehension.

### 3rd-party libraries used
- [Alamofire](https://github.com/Alamofire/Alamofire) for the API calls.

- [AlamofireImage](https://github.com/Alamofire/AlamofireImage) to handle the download and caching of the images.

- [ZLSwipeableViewSwift](https://github.com/zhxnlai/ZLSwipeableViewSwift) to show the products for the user to "like/dislike".

- [DisplaySwitcher](https://github.com/Yalantis/DisplaySwitcher) to display the products for review as a "List" and as a "Grid".

- [SnapKit](https://github.com/SnapKit/SnapKit) to handle constraints in code.

### Considerations
The app is recommended to be ran in iPhone 6 screen size but works in every other iPhone size.
