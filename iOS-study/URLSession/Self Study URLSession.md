## URLSession Delegate
`URLSession` delegate provides multiple functions to inspecting request.
however if you fill the delegate in the configuration completion handlers and async awaits will not work anymore.
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
1) create a background configuration
2) store `application(_:handleEventsForBackgroundURLSession:completionHandler:)` completion handler in the downloadManager (or any class that handles the urlsession delegates)
3) in that class implement `urlSessionDidFinishEvents(forBackgroundURLSession:)` to execute the completion that you stored
### Background downloads Important notes
* When you attached xcode debugger even if it go to background lifecycle still Use OSLog to read your logs while a background upload is running
* [Other notes](https://www.avanderlee.com/swift/urlsession-common-pitfalls-with-background-download-upload-tasks/)
