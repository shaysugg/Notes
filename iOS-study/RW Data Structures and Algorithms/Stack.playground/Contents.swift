

//example(of: "Usage of Stack") {
//    struct CD {
//        let name: String
//    }
//
//    var cdStack: Stack = [CD(name: "A"), CD(name: "B"), CD(name: "C")]
//    cdStack.push(CD(name: "D"))
//    cdStack.push(CD(name: "E"))
//    cdStack.push(CD(name: "F"))
//    cdStack.pop()
//    cdStack.pop()
//    cdStack.push(CD(name: "G"))
//
//    print(cdStack)
//}
//
//example(of: "Usage of linked list") {
//    var list = LinkedList<Int>()
//    list.push(1)
//    list.push(2)
//    list.push(3)
//    list.append(1)
//
//    let node = list.node(at: 0)!
//    list.insert(10, after: node)
//
//    print(list)
//}
//
//example(of: "Linked List Collection") {
//    var list = LinkedList<Int>()
//    for i in 0...9 {
//        list.push(i)
//    }
//
//    print("List: \(list)")
//    print("First element: \(list[list.startIndex])")
//    print("Array containing first 3 elements: \(Array(list.prefix(3)))")
//    print("Array containing last 3 elements: \(Array(list.suffix(3)))")
//    let sum = list.reduce(0, +)
//    print("Sum of all values: \(sum)")
//}

example(of: "Copy on write (COW)") {
    var list1 = LinkedList<Int>()
    list1.append(1)
    list1.append(2)
    list1.append(3)
    
    var list2 = list1
    
    let node = list2.node(at: 0)!
    list2.remove(after: node)
    print(list1)
    print(list2)
}
