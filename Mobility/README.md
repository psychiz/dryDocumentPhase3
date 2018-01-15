## Environment Setup
```bash
$ sudo gem install cocoapods
$ cd <into-project-root>
$ pod init  # only if project doesn't already have pod file, run in project root
$ pod install

# close any current Xcode sessions and use `Mobility.xcworkspace` for this project from now on

## To speed up local development/so don't have to sign in everytime, setup a local environment variable
$ export AEPMobilityUsername="username-to-sign-in-with"
$ export AEPMobilityPassword="usernames-password"

## For local development, need a local server running to receive HTTP requests
## Clone `aep-services` repo
$ cd aep-services
# follow directions in the `aep-services` projects `README.md`

## For offline data sync when hard line conneted to a computer, need to enable internet sharing
## Steps so: HTTP requests can be made over USB when no wifi or cell connection
## https://apple.stackexchange.com/questions/88449/can-i-share-my-imacs-internet-to-iphone-or-ipad-over-usb
## Setup AEPConnectionString to hostname of computer hardline connected to.
```

## Helpful Links for Getting Started
* iOS/Swift Getting Started
  - <https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/BuildABasicUI.html>
  - <https://appcoda.com/swift4-changes>
* Patterns Used
  - <http://ashishkakkad.com/2016/03/how-to-create-a-wrapper-for-alamofire-and-swiftyjson-swift-ios/>
  - <https://www.raywenderlich.com/160651/design-patterns-ios-using-swift-part-12>
* Core Data
  - <https://www.raywenderlich.com/145809/getting-started-core-data-tutorial>
* HTTP Requests
  - <https://www.raywenderlich.com/158106/urlsession-tutorial-getting-started>
  - <http://benscheirman.com/2017/06/ultimate-guide-to-json-parsing-with-swift-4/>
  - <https://github.com/Alamofire/Alamofire>
  - <https://www.raywenderlich.com/147086/alamofire-tutorial-getting-started-2>
* Core Data Syncing with Swift
  - <https://github.com/3lvis/Sync>
  - <https://github.com/3lvis/Sync/tree/master/iOSDemo>
* Git
  - gitignore: <https://www.gitignore.io/api/macos%2Cswift%2Cxcode%2Ccocoapods>
  
## Contributed Libraries
* Toast Swift: <https://github.com/scalessec/Toast-Swift> (MIT)
  - Need to use Swift 4 branch <https://github.com/scalessec/Toast-Swift/tree/feature/Swift-4>
* DDMathParser: <https://github.com/davedelong/DDMathParser> (MIT)
  - Need to use the Swift 4 branch <https://github.com/davedelong/DDMathParser/tree/swift4>
* Sync: <https://github.com/3lvis/Sync> (MIT)
  - Sync HTTP json responses to Core Data/app database.
* SwiftyJSON: <https://github.com/SwiftyJSON/SwiftyJSON/tree/4.0.0-alpha.1>
* Alamofire:
* AlamofireNetworkActivityIndicator:
* Perhaps use: <https://github.com/mxcl/PromiseKit>
* Reachability for network checks

## Tools
* Postman: <https://www.getpostman.com/>
  - For making adhoc HTTP requests.
* DB Browser for SQLLite: <http://sqlitebrowser.org/>
  - For inspecting local app database via Core Data.
* NodeJS
  - For mocking web services/backend.
  - `nodemon` modules for live reloading server side code.

## Tips and Tricks
* For Core Data, when changing any entities or attributes, [delete the app in the simulator](https://stackoverflow.com/a/8881845/1747442) and and clean the project with `command+shift+k`
  - For local developmenet only. For release model changes, create a Core Data migration.
* Evaluate `podfile` to most up to date dependencies
* Use environment variables when developing locally to hold senstive values so not kept in source control.

## Notes
* Due to high-precisicion calculations, Double should always be used over float types:
  - <https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#floating-point-numbers>
* Changing MaximoAPI on backend will break client side. Mapping of fields name in Core Data match Maximo Backend
  - Perhaps have proxy middleware the does the mapping? Thus, middware only needs updated as Maximo changes?
* Chose to keep Pod files/packages in source control due to ease of use and various opinions on StackOverflow.
  - Perhaps remove from source control when/if becomes an issue?
  - Per: <https://guides.cocoapods.org/using/using-cocoapods.html>, see question: "Should I check the Pods directory into source control?
" to get CocoaPod team's answer.
* Use `os.log` for logging. Not `print` or `NSLog`
  - <https://stackoverflow.com/questions/25951195/swift-print-vs-println-vs-nslog>
* Maximo doesn't return `id` field for entities. Need to key off of `_rowstamp` field.
- Core Data needs `rowstamp` field and set its `sync.remoteKey` to `_rowstamp` and set `rowstamp` to `sync.isPrimaryKey` = `true`

## Questions
* What is the best primary key for users, `whoami` endpoint. No unqiue number id and server alias' for logon names.
    - Currently using `loginID` field but several options to choose from.
* To keep or not to keep POD packages in source control?

## Issues
* Cannot sync over HTTP when Airplane mode is turned on. Any HTTP request throws: TIC TCP Conn Failed [11:0x1c417d400]: 1:50 Err(50)
  - HTTP load failed (error code: -1009 [1:50]):  <https://developer.apple.com/documentation/foundation/nsurlerrornotconnectedtointernet>

## View Controllers

## Login View Controller

*  Login View Controller, allows the user to authenticate to the app and make tours.
* TextField delegate is used (For text validation if the text fields of user name and passwords are empty the background color of login button will remain gray else the color of the login button would be blue)
* Handle login functionality : Validations are being made for current user name and password , if the username or password text field is empty it will show an alert .
* Network Check : If the internet is not available a network check is made which notifies in the alert controller if the internet is present or not.
* After authentication the user can access several data sources and tours according to that.
* Use debug and release modes for the app,
* debug: (It is for the development procedure where in the user can select the data source from the login view controller  `#Debug: If this app scheme is selected debug flow will be in the developement mode` )
  - In this mode the data source list will appear in the drop down.
  #drop down : Composed of tableview and uiview .
  
  * release: (It is for the release mode where in the user can authenticate and make tours  `#Release: If this app scheme is selected  flow will be in the relase mode` )
  - Once the authentication is done segue will be called and the flow will navigate to the user profile screen.
  
  ## User profile View Controller
  
   *     Profile View Controller, shows the user info with the user profile image name, current control room in which he is making the tour, email id of user
   *    The profile data is fetched from the api and it is stored in the local database, once the login is being done the data is fetched from the database and shown in the user profile.
   *  The selected control room will appear once the list of the controllers loaded on the screen.
   *   debug: (It is for the development procedure )
    * release: (It is for the release mode where in the user can authenticate and make tours  `#Release: If this app scheme is selected  flow will be in the relase mode` )
  
  ## Tours Table View Controller
  
  *     Tours Table View Controller, shows the recent tours.
  *    The tours are being fetched from the api and stored in the core data, once the user clicks on the download all the tours are fetched from the api and populated on the tableview
   * Network Check : If the internet is not available a network check is made which notifies in the alert controller if the internet is present or not.
 * Custom tableview cell is designed which shows the detail of the tour.
  * Elements shown in the detail
    - Start time
    - Tour name
    - Tour detail
* The tour list is composed of the progress bar which shows the status of the tour downloads

*    debug: (It is for the development procedure )
*    release: (It is for the release mode where in the user can authenticate and make tours  `#Release: If this app scheme is selected  flow will be in the relase mode` )
  - Once selection of a perticular tour from the list, a segue is called which navigates to the tour detail screen and tour detail appears

* refreshView : is called to refersh the tours list


## User profile Table View Controller

*     User Profile Table View Controller, shows the user info with the user profile image name, current control room in which he is making the tour, email id of user
*    LoadViewData() loads the data from the database on to the tableview
*    RefreshTechinicianData() refershes the technician data
*    Fetcher entity fetches the daya from the database
*    The AM training in help and support redirects to help and support
*    The profile data is fetched from the api and it is stored in the local database, once the login is being done the data is fetched from the database and shown in the user profile.
*    The selected control room will appear once the list of the controllers loaded on the screen.
*    debug: (It is for the development procedure )
*    release: (It is for the release mode where in the user can authenticate and make tours  `#Release: If this app scheme is selected  flow will be in the relase mode` )


## KtextFieldPlaceHolder

*    KtextFieldPlaceHolder is for creating android like animation in the text field in the user name and password
*    textfield delegates are called once the textdidchangeiscalled in the field the placeholder takes the position of the label


## Utility

 * Utility is a generic class which consists of methods which are to be in whole project
 * isInternetConnection() is for detecting the internet avaliability.
 * alertcontroller() is for showing up the error messages and toast.
 
 ## Fetcher
 * fetchLocalTechnician() : A local fetch request is generated which fetches the technician data from the local database.
 * deleteTheLocalTechnician() : Deletes the local technician from the local database
 * fetchLocalTour: Fetches the local tours from the local database
 * fetchremotetechnician : It fetches up the remote technician
 * fetchremotetours : It fetches up the reote tours
 * getRemoteTourByID : It fetches the remote tours by id
 
 ## Tours Service
 *tours () : Fetch up the tours from the server
  Alamofire external library for fetching up the tours
  *getToursByID : Fetch up the tours by the id.
  
  ## Extensions
  
  * getRecentTours () : Filters out the recent tours
  
  ## Sync  View Controller
  
 * Sync class to fetch the data from the api.
  * Alamofire request fired for sync mocked data
   - A local network connection is fetching up the mocked data from the local configued url
     scheme is selected  flow will be in the relase mode` )
   - Succss and failure completion block is handled which
   #Success : The api data is synced from the domestic connection
   #Failure :     An alert is being popped for bad request generated
    - Local host url is being configured to fetch up the data from the local database
    

    
    
    
  
  

