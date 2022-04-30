import Foundation

public class Node<Value> {
    var value: Value
    var next: Node<Value>?
    
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


public class LinkedList<Value> {
    var head: Node<Value>?
    var tail: Node<Value>?
    
    public init() {}
    
    public var isEmpty: Bool {
        head == nil
    }
    
    //adding
    
    public func push(_ value: Value){
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public func append(_ value: Value) {
        
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
    public func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    //removing
}

