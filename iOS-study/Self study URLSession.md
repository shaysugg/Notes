For greater controlling over a URLRequest we can take the delegate of a URLSession and use the function that it provides.
* Note that we need to call data task functions that **don't have completion handlers.**
```Swift
let session = URLSession(configuration: configuration,
                      delegate: self, delegateQueue: nil)

func startLoad() {
    loadButton.isEnabled = false
    let url = URL(string: "https://www.example.com/")!
    receivedData = Data()
    let task = session.dataTask(with: url)
    task.resume()
}


// delegate methods


func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse,
                completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
                //check response status
}


func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
//accumulating data
}


func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//error handling
}
```
