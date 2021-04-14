//: [Previous](@previous)

import Foundation
import CryptoKit

let str = "very secret stuff"
let data = str.data(using: .utf8)!

let senderSPrivateKey = Curve25519.Signing.PrivateKey()
let senderSPublicKeyData = senderSPrivateKey.publicKey.rawRepresentation

let signature = try! senderSPrivateKey.signature(for: data)

    //send signature + publicKeyData through internet

let reciverSPublicKey = try! Curve25519.Signing.PublicKey(rawRepresentation: senderSPublicKeyData)
reciverSPublicKey.isValidSignature(signature, for: data)

//: [Next](@next)
