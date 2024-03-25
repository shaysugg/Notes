    private func fetchHelloWorlds(withMax max: Int) async throws -> [String] {
        let words = ["Hello", "World", "Foo", "Bar", "Zee", "John", "Doe", "Dead", "Beef"]
        
        @Sendable func fetch(_ word: String) async throws -> String {
            try await Task.sleep(for: self.articleFetchDuration)
            return word
        }
        
        let max = min(words.count, max)
        
        return try await withThrowingTaskGroup(of: String.self, returning: [String].self) { group in
            var strings = [String]() { didSet { print(strings) }}
            //only execute fetch for the maximum number
            for index in 0..<max {
                let _ = group.addTaskUnlessCancelled {
                    return try await fetch(words[index])
                }
            }
            var currentIndex = max
            while let string = try await group.next() {
                //check for cancellation
                if Task.isCancelled { return strings }
                
                // start a new task if still any words remain
                if currentIndex < words.count {
                    let wordAboutToFetch = words[currentIndex]
                    let _ = group.addTaskUnlessCancelled {
                        return try await fetch(wordAboutToFetch)
                    }
                    currentIndex += 1
                }
                
                strings.append(string)
            }
            
            return strings
        }
        
    }
