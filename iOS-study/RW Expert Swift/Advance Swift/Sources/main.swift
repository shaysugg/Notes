// The Swift Programming Language
// https://docs.swift.org/swift-book

// exampleOF("Json Decoding") {
//     decodeStore()
// }

// exampleOF("") {
//   containerDecoding()
// }

exampleOF("MetaTypes") {
  class Request {
    let url: String = ""
    func whoAmI() {
      print(self)
      print(Self.self)
    }
  }

  class HTTPRequest: Request {}

  let request = HTTPRequest()
  request.whoAmI()

}
