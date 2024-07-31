## URLSession Delegate
`URLSession` delegate provides multiple functions to inspecting request.
However if you fill the delegate in the configuration completion handlers and async awaits will not work anymore.
```Swift
class RequestHandler {
	lazy private var session: URLSession = {
        let session = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: nil
        )
        return session
    }()

	func request() {
		session.dataTask(with: request)
		//result will be recieved through below delegate function
	}

	func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
	//process the data
	}
}
```
By using delegate functions we can have more information about the request and its response.
##  Downloading Data
### Resume Download
when you cancel a `URLsessionTask` it will provide a resume data which you can store it and use it later on to continue the task.
### Download on background
[Article](https://developer.apple.com/documentation/foundation/url_loading_system/downloading_files_in_the_background)
1) create a background configuration (with unique identifier)
2) store `application(_:handleEventsForBackgroundURLSession:completionHandler:)` completion handler in the downloadManager (or any class that handles the URLSession delegates). Note that we should check the identifier to see if it's the specific `URLSession` that we've defined in step 1.
3) in that class implement `urlSessionDidFinishEvents(forBackgroundURLSession:)` to execute the completion that you stored
### Background downloads Important notes
* When you attached Xcode debugger even if the app goes to background you don't see the expected function is getting executed mainly because Xcode debugger will prevent your app from getting suspended. Use OSLog and console app to read your logs while a background upload/download is running
* Set `isDiscretionary = true` only if we're dealing with a large amount of data and it's not important to start downloading them in background immediately.
* [Other notes](https://www.avanderlee.com/swift/urlsession-common-pitfalls-with-background-download-upload-tasks/)
## Cache Policies
Cache policies can be set on URLSession level for all the ongoing requests or on each individual request.
```Swift
var configuration = URLSessionConfiguration.default
configuration.requestCachePolicy = .useProtocolCachePolicy
URLSession(configuration: configuration)

URLRequest(url: URL(string: "")!, cachePolicy: .useProtocolCachePolicy)
```
### useProtocolCachePolicy
Cache policies by default are set to `useProtocolCachePolicy`. For Http and Https requests, the server can send request headers with cache-control field defining how often the client should use its cache or request from server.
```
Cache-Control: max-age=533280
```
### returnCacheDataElseLoad
We get one snapshot of the data from the server and store it. As long as it exists in our cache we won't need to retrieve it from server again.
### reloadIgnoringLocalCacheData
We make a request to the server every time and ignore any cached data. This may cause an overload on server. However can be useful in tests.
### returnCacheDataDontLoad
Data only will be retrieved from the cache and will never be read from the server. If no data exists our request will fail. Offline mode behavior
## Authentication Challenges
Sometimes servers use a basic authentication challenge before allowing to access their APIs. These challenges can be handled by this URLSession delegate:
```Swift
func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void

    ) {
    //check if auth methode is basic
    // you can also check other parameters like failureCount = challenge.previousFailureCount
    let authMethod = challenge.protectionSpace.authenticationMethod
	guard authMethod == NSURLAuthenticationMethodHTTPBasic else {
	    completionHandler(.performDefaultHandling, nil)
	    return
	}
	
	//provide credentials from outside (UI) using closures
	guard let credential = credentialOrNil else {
	    completionHandler(.cancelAuthenticationChallenge, nil)
	    return
	}

	//complete the challenge with credentials
	completionHandler(.useCredential, credential)
}
```
## Error Handling
URLSession Errors usually are identified with their error codes.
```Swift
let task = URLSession.shared.dataTask(with: url) { data, response, error in  
    if let error = error {  
        switch (error as NSError).code {  
        case NSURLErrorNetworkConnectionLost:  
		//other cases ...  
    }  
}
```
Full list of errors can be found at [URLError](https://developer.apple.com/documentation/foundation/urlerror)
## Mocking
Check: [[Unit Testing#Testing Network Logic]]
## Share operator
For networking with URLSession publish data task Its important to consider the `share` operator when it's suitable. By using the share operator we prevent extra network calls when we subscribe multiple times to a network publisher/
[[Operators#Share]]
Additionally the multicast delegate that explained here is also something that is worthwhile to consider.
[[Network#Publishing network data to multiple subscribers]]

## Waiting for connectivity
In order to not fail the request immediately if there is no internet connection we can wait an amount time before failing them. Maybe the connectivity issue is temporarily due to VPN connection or cellular signal lost.
```Swift
let configuration = URLSessionConfiguration.default
configuration.waitsForConnectivity = true
configuration.timeoutIntervalForRequest = 30
```
## Network Reachability checks
```swift
let pathMonitor = NWPathMonitor()
pathMonitor.pathUpdateHandler { path in
    switch path.status {
    case .satisfied:
        // Networking connection restored
    default:
        // There's no connection available
    }
}
```
## Web Sockets
* You don't have to poll anything
* used in interactive platforms such as: games, collaboration tools, chats
* Low latency communications
### Implementation
Important to recursively watch for the next message.
```swift
    var webSocketTask: URLSessionWebSocketTask?
    
    func connect() {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        receiveMessage()
    }
    
    func send(_ message: String) {
        let message = URLSessionWebSocketTask.Message.string(message)
        webSocketTask?.send(message)
    }
    
    func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
	        //Important you should recursively watch for the next message
	        defer {
		        self?.receiveMessage()
	        }
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    print("Received text message: \(text)")
                case .data(let data):
                    print("Received binary message: \(data)")
                @unknown default:
                    break
                }
                
            case .failure(let error):
                print("WebSocket receive error: \(error)")
            }
        }
    }
}

```