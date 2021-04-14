//: [Previous](@previous)

import Foundation
import CryptoKit

let str = "very secret stuff"
let data = str.data(using: .utf8)!

//Hash to random
var hasher = Hasher()
str.hash(into: &hasher)
let value = hasher.finalize() //different result everytime

//Hash by SHA256 (256Bit digest)
let digest = SHA256.hash(data: data) //same result everytime


//: [Next](@next)
