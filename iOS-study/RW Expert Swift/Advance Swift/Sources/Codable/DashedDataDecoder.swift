import Foundation

func decodeDashedData() {
  struct Person: Decodable {
    let firstName: String
    let lastName: String
    // let lastSeen: Date
  }

  let jsonURL = URL(
    filePath:
      "/Users/shayan/Documents/myStudy/Advance swift/Sources/Codable/sample_dashed_data.json")
  let jsonData = try! Data(contentsOf: jsonURL)
  let jsonDecoder = JSONDecoder()

  jsonDecoder.keyDecodingStrategy = .dashedCase
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "YYYY MM dd, hh:mm"
  jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)

  let store = try! jsonDecoder.decode(Person.self, from: jsonData)
  print(store)
}

extension JSONDecoder.KeyDecodingStrategy {
  static var dashedCase: JSONDecoder.KeyDecodingStrategy = .custom { keys in
    let codingKey = keys.last!
    let key = codingKey.stringValue

    guard key.contains("-") else { return codingKey }

    let words = key.components(separatedBy: "-")
    let camelCased = words[0] + words[1...].map(\.capitalized).joined()

    struct AnyCodingKey: CodingKey {
      let stringValue: String
      let intValue: Int?
      init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
      }
      init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = "\(intValue)"
      }
    }
    return AnyCodingKey(stringValue: camelCased)!
  }
}
