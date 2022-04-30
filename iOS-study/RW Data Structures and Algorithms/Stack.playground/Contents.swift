

example(of: "Usage of Stack") {
    struct CD {
        let name: String
    }

    var cdStack: Stack = [CD(name: "A"), CD(name: "B"), CD(name: "C")]
    cdStack.push(CD(name: "D"))
    cdStack.push(CD(name: "E"))
    cdStack.push(CD(name: "F"))
    cdStack.pop()
    cdStack.pop()
    cdStack.push(CD(name: "G"))

    print(cdStack)
}

example(of: "Usage of linked list") {
    let list = LinkedList<Int>()
    list.push(1)
    list.push(2)
    list.push(3)
    list.append(1)
    
    let node = list.node(at: 2)!
    list.insert(10, after: node)
    
    print(list)
    
}
