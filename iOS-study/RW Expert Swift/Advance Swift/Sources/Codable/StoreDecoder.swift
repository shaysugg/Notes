import Foundation

func decodeStore() {
  struct Store: Decodable, CustomStringConvertible {
    struct StoreCategory: Decodable, CustomStringConvertible {
      struct Item: Decodable, CustomStringConvertible {
        let itemId: String
        let price: String
        let title: String
        let availableDate: Date
        var description: String {
          """
          title: \(title)
          price: \(price)
          date: \(availableDate)
          """
        }
      }
      let title: String
      let items: [Item]
      var description: String {
        """
        title: \(title)
        items: \(items.map { $0.description + "\n" })
        """
      }
    }

    let title: String
    let categories: [StoreCategory]

    var description: String {
      """
      title: \(title)
        categories: \(categories.map { $0.description + "\n" })
      """
    }
  }

  //TODO: Relative path
  let jsonURL = URL(
    filePath: "/Users/shayan/Documents/myStudy/Advance swift/Sources/Codable/sample_store.json")
  let jsonData = try! Data(contentsOf: jsonURL)
  let jsonDecoder = JSONDecoder()

  jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "'Date: 'YYYY MM dd, 'Time: ' hh:mm"
  jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)

  let store = try! jsonDecoder.decode(Store.self, from: jsonData)
  print(store)
}
