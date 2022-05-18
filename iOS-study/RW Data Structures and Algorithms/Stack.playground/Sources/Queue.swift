import Foundation
import LinkedList_PageSources


public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

public struct ArrayQueue<T>: Queue {
    private var array: [T] = []
    init() {}
    
    mutating public func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    mutating public func dequeue() -> T? {
        array.removeFirst()
    }
    
    public var isEmpty: Bool { array.isEmpty }
    
    public var peek: T? { array.last }
}

public struct LinkedListQueue<T>: Queue {
    public mutating func enqueue(_ element: T) -> Bool {
        linkedList.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        linkedList.removeLast()
    }
    
    public var isEmpty: Bool { linkedList.isEmpty }
    
    var linkedList = LinkedList<T>()
    
    public var peek: T? { linkedList.tail?.value }
}

