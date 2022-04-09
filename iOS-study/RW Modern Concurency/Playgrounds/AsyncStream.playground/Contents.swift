import UIKit

/// easier way to create somrthing like async sequenc

let string = "Hello world"
var index = string.startIndex

func makeTypeWriterStream() -> AsyncStream<String> {
    return AsyncStream<String> { continuation in
        Task {
            while index < string.endIndex {
                do {
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                } catch {
                    continuation.finish()
                }
                
                let subString = String(string[string.startIndex..<index])
                continuation.yield(subString)
                
                index = string.index(after: index)
            }
            continuation.finish()
        }
    }
}

func makeSimplerTypeWriterStream() -> AsyncThrowingStream<String, Error> {
    return AsyncThrowingStream {
        
        if index >= string.endIndex {
            return nil
        }
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
        } catch {
            return nil
        }
        
        index = string.index(after: index)
        
        let subString = String(string[string.startIndex..<index])
        return subString
    }
}

func main() async throws {
    //both do the same thing
    // functions implemantations are different
    
//    let stream = makeTypeWriterStream()
    let stream = makeSimplerTypeWriterStream()
    for try await item in stream {
        print(item)
    }
}

Task { try? await main() }
