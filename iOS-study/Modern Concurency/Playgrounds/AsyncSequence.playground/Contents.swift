import UIKit


struct TypeWriter: AsyncSequence {
    
    typealias Element = String
    
    
    let phrase: String
    
    func makeAsyncIterator() -> TypeWriterIterator {
        return TypeWriterIterator(phrase: phrase)
    }
    
    
}

struct TypeWriterIterator: AsyncIteratorProtocol {
    
    let phrase: String
    
    private var index: String.Index
    
    init(phrase: String) {
        self.phrase = phrase
        index = phrase.startIndex
    }
    
    mutating func next() async throws -> String? {
        if index > phrase.endIndex {
            return nil
        }
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        let nextIndex = phrase.index(after: index)
        let string = String(phrase[index..<nextIndex])
        index = nextIndex
        return string
    }
    
    
}

func pmain() async throws {
    let typeWriter = TypeWriter(phrase: "Hello Dear World")
    var iterator = typeWriter.makeAsyncIterator()
    
    while let item = try await iterator.next() {
        print(item)
    }
}

Task {
    try await pmain()
}


