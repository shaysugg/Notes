import UIKit
import CryptoKit

let str = "very secret stuff"
let data = str.data(using: .utf8)!

let senderPrivateKey = Curve25519.KeyAgreement.PrivateKey()
let senderPublicKeyDATA = senderPrivateKey.publicKey.rawRepresentation

let reciverPrivateKey = Curve25519.KeyAgreement.PrivateKey()
let reciverPublicKeyDATA = reciverPrivateKey.publicKey.rawRepresentation

let salt = "unfortunately don't know what salt is rn".data(using: .utf8)!

//reciver
let senderPublicKey = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: senderPublicKeyDATA)
let reciverSharedSecret = try! reciverPrivateKey.sharedSecretFromKeyAgreement(with: senderPublicKey)
let reciverSymmetricKey = reciverSharedSecret.hkdfDerivedSymmetricKey(using: SHA512.self, salt: salt, sharedInfo: Data(), outputByteCount: 32)

//sender
let reciverPublicKey = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: reciverPublicKeyDATA)
let senderSharedSecret = try! senderPrivateKey.sharedSecretFromKeyAgreement(with: reciverPublicKey)
let senderSymmetricKey = senderSharedSecret.hkdfDerivedSymmetricKey(using: SHA512.self, salt: salt, sharedInfo: Data(), outputByteCount: 32)

//BOOM! They are the same
senderSymmetricKey == reciverSymmetricKey

let sealbox = try! AES.GCM.seal(data, using: senderSymmetricKey)
let sealBoxData = sealbox.combined!

//sender send the data through internet

let receivedSealBox = try! AES.GCM.SealedBox(combined: sealBoxData)
let receivedData = try! AES.GCM.open(receivedSealBox, using: reciverSymmetricKey)
print(String(data: receivedData, encoding: .utf8)!)
