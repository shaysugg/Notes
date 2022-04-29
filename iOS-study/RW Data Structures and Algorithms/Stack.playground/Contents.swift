

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
