//: [Previous](@previous)

import Foundation
import CryptoKit

// sender and reciver knows the key
// use for signing - none encryptable!

let str = "very secret stuff"
let data = str.data(using: .utf8)!

let key = SymmetricKey(size: .bits256)

//sign the stringdata using key
let sha256MAC = HMAC<SHA256>.authenticationCode(for: data, using: key)
let authenticatedCode = Data(sha256MAC)

//validate the signed data match the original data or not
HMAC<SHA256>.isValidAuthenticationCode(authenticatedCode, authenticating: data, using: key)

//: [Next](@next)
