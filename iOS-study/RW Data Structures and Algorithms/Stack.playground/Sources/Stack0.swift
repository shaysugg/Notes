import Foundation

public struct Stack<Element> {
    private var storage: [Element] = []
    
    public mutating func push(_ newElement: Element) {
        storage.append(newElement)
    }
    
    @discardableResult
    public mutating func pop() {
        storage.popLast()
    }
    
    public func peek() -> Element? {
        storage.last
    }
    
    public var isEmpty: Bool {
        storage.isEmpty
    }
    
    public init() {}
    
    public init(_ elements: [Element]) {
        storage = elements
    }
}


extension Stack: CustomStringConvertible {
    public var description: String {
        """
---top---
\(storage.map {"\($0)"}.reversed().joined(separator: "\n"))
"""
    }
}


extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}
