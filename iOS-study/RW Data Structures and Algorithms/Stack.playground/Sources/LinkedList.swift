import Foundation

public class Node<Value> {
    public fileprivate(set) var value: Value
    public fileprivate(set) var next: Node<Value>?
    
    init(value: Value, next: Node<Value>?) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> \(String(describing: next)) "
        
    }
}


public struct LinkedList<Value> {
    public private(set) var head: Node<Value>?
    public private(set) var tail: Node<Value>?
    
    public init() {}
    
    public var isEmpty: Bool {
        head == nil
    }
    
    //adding
    
    public mutating func push(_ value: Value){
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        
        if isEmpty {
            push(value)
        }
        
        tail?.next = Node(value: value, next: nil)
        
        tail = tail?.next
    }
    
    public func node(at index: Int) -> Node<Value>? {
        var currentValue = head
        var currentIndex = 0
        
        while currentValue != nil && currentIndex < index {
            currentValue = currentValue?.next
            currentIndex += 1
        }
        
        return currentValue
    }
    
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    //removing
    
    public mutating func pop() -> Value? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        
        return head?.value
    }
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        if isEmpty {
            return nil
        }
        
        if head?.next != nil {
            return pop()
        }
        
        var prev = head!
        var current = head!
        
        while let next = current.next {
            prev = current
            current = next
        }
        
        prev.next = nil
        tail = prev
        return current.value
    }
    
    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = node
            }
            
            node.next = node.next?.next
        }
        
        return node.next?.value
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        
        guard let head = head else {
            return "Empty List"
        }
        return String(describing: head)
    }
}

