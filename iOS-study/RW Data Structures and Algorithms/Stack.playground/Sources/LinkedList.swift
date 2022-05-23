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
        copyNodes()
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        copyNodes()
        if isEmpty {
            push(value)
            return
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
        copyNodes()
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
        copyNodes()
        
        return head?.value
    }
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        copyNodes()
        if isEmpty {
            return nil
        }
        
        guard head?.next != nil else {
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
        guard let node = copyNodes(returningCopyOf: node) else {return nil}
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        
        return node.next?.value
    }
    
    
    private mutating func copyNodes() {
        if isKnownUniquelyReferenced(&head) {
           return
        }
        guard var oldNode = head else {
            return
        }
        
        head = Node(value: oldNode.value, next: nil)
        var newNode = head
        
        while let oldNodeNext = oldNode.next {
            newNode?.next = Node(value: oldNodeNext.value, next: nil)
            newNode = newNode?.next
            
            oldNode = oldNodeNext
        }
        
        tail = newNode
    }
    
    private mutating func copyNodes(returningCopyOf node:
    Node<Value>?) -> Node<Value>? {
      guard !isKnownUniquelyReferenced(&head) else {
    return nil
      }
      guard var oldNode = head else {
    return nil
    }
      head = Node(value: oldNode.value, next: nil)
      var newNode = head
      var nodeCopy: Node<Value>?
      while let nextOldNode = oldNode.next {
        if oldNode === node {
          nodeCopy = newNode
        }
          newNode!.next = Node(value: nextOldNode.value, next: nil)
        newNode = newNode!.next
        oldNode = nextOldNode
    }
      return nodeCopy
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


//GOT SO FUCKIN COMPLICATED
extension LinkedList: Collection {
    public struct Index: Comparable {
        
        let node: Node<Value>?
        
        public static func < (lhs: LinkedList<Value>.Index, rhs: LinkedList<Value>.Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains {$0 === rhs.node}
        }
        
        public static func == (lhs: LinkedList<Value>.Index, rhs: LinkedList<Value>.Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left === right
            case (nil, nil):
                return true
            default: return false
            }
        }
        
        
    }
    
    public var startIndex: Index {
        Index(node: head)
    }
    
    public var endIndex: Index {
        Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
        Index(node: i.node?.next)
    }
    
    public subscript(position: Index) -> Value {
        position.node!.value
    }
}

