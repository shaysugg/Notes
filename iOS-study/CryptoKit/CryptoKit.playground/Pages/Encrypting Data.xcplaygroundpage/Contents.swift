//: [Previous](@previous)

import Foundation
import CryptoKit

// sender and reciver knows the key
// encryptable

let str = "very secret stuff"
let data = str.data(using: .utf8)!

let key = SymmetricKey(data: .bits128)
//we can use AES too
let sealBoxData = try! ChaChaPoly.seal(data, using: key).combined

//send sealBoxData through network ...

//server received the sealBoxData
//knows the key and would decrypt sealBoxData
let sealBox = try! ChaChaPoly.SealedBox(combined: sealBoxData)
let decryptedData = try! ChaChaPoly.open(sealBox, using: key)
String(data: decryptedData, encoding: .utf8)


print(sealBox.nonce) //changes every time
print(sealBox.tag) //encrypted digest (calculated by nouns + key)
//: [Next](@next)
