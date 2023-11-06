import Foundation

func containerDecoding() {
  struct Profile: Decodable {
    typealias Location = (lat: Double, long: Double)
    let name: String
    let city: String
    let cordinate: Location
    let mail: String

    enum CodingKeys: CodingKey {
      case city, name, location, mails
    }

    init(from decoder: Decoder) throws {
      let container = try! decoder.container(keyedBy: CodingKeys.self)
      self.name = try container.decode(String.self, forKey: CodingKeys.name)
      let location = try container.decode(LocationInfo.self, forKey: CodingKeys.location)
      cordinate = (location.coordinate.lat, location.coordinate.long)
      city = location.city
      let mails = try container.decode([String].self, forKey: CodingKeys.mails)
      mail = mails[0]
    }

    struct LocationInfo: Decodable {
      let city: String
      let coordinate: Coordinate
    }

    struct Coordinate: Decodable {
      let lat: Double
      let long: Double
    }
  }

  let jsonURL = URL(
    filePath:
      "/Users/shayan/Documents/myStudy/Advance swift/Sources/Codable/sample_profile_data.json")
  let jsonData = try! Data(contentsOf: jsonURL)
  let jsonDecoder = JSONDecoder()
  let profile = try! jsonDecoder.decode(Profile.self, from: jsonData)
  print(profile)

}
