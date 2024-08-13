# CryptoKit
https://www.raywenderlich.com/10846296-introducing-cryptokit
## DATA Protection Levels
we usually protect user data in these 3 situations:
* **Data in motion**: *(ex: network)* 
	* using TLS: if server use TLS 1.3
	* authentications and other cryptographics techniques
	
* **Data in Use**: *(ex: in memory)*
	* local authentications (Touch-ID, Face-ID)

* **Data at rest**: *(on disk)* we have three different protection levels here:
	1. **Protected Until First User Authentication**: the **default** one, file is not accessible while the device is booting up, but is then accessible until the device reboots, even while the device is locked.
	2. **Complete**: The file is accessible only when the device is unlocked.
	3. **Complete Unless Open**: If the file is open when the device locks, it’s still accessible. If the file is not open when the device locks, it’s not accessible until the device unlocks. *example: *
	```swift
	//here we write data by using 
	//Protected Until First User Authentication protection level
	try data.write(to: secretsURL)
	
	//we can change security level by
	try data.write(to: secretsURL, options: .completeFileProtection)
	```
	
## Hashing
🟢 Pros: nobody can't reverse the hash and find out the actual data.
🔴 Cons: attacker can use the digest (hashed data) instead of actual data.
for digital signature, password transitions, ...
### normal hash
not the same output each time *(very useless)*
```swift
item = "HASH ME!"
var hasher = Hasher()
item.hash(into: &hasher)
hasher.finalize()
```
### cryptographic hash
produce the same value each time!
```swift
item = "HASH ME!"
let data = item.data(using: .utf8)!
let digest = SHA256.hash()
```
### Digest converting
converting a digest to string
```swift
let string = digest.compactMap{ String(format: "%02x", $0) }
.joined()
```
## HMAC
Hash-based Message Authentication Code
Signing the digest

🟢 Pros: sender sign the data with a **Symmetric Key** and send it to receiver who also knows the **Symmetric Key** and receiver would **validate** the digest using the **Symmetric Key**.
🔴 Cons: digest only can get validate not encrypted - both sender and receiver should now the Symmetric Key.

```swift     
//create SymmetricKey
let key = SymmetricKey(size: .bits256)

//sign the stringdata using key
let sha256MAC = HMAC<SHA256\>.authenticationCode(for: stringdata, using: key)
//convert it to data
let authenticatedData = Data(sha256MAC)

// sender send authenticatedData through server ...

//receiver get authenticatedData and
//validate the signed data match the original data or not
HMAC<SHA256\>.isValidAuthenticationCode(authenticatedData, authenticating: stringdata, using: key)
```
**Symmetric Key = inner key (blue) + outer key (red)**

![[Screen Shot 2021-03-28 at 10.39.12 AM.png]]

## Encrypting Data
the technique that is using here is **Authenticated Encryption with Associated Data (AEAD)**
there are two AEAD common use:
* AES-GSM (Advanced Encryption Standard Galois/Counter Mode)
* ChaCha20-Poly1305

### Creating a Sealed Box
🟢 Pros: data can be encrypted and decrypted
🔴 Cons: both sender and receiver should now the Symmetric key
**inputs:**
* data that we want to get encrypted
* a Secret Key
* an IV or nonce
	
**operations:**
1. secret key + nonce = secondary key
2. use key and nonce to encrypt data and create a **encrypted data aka ciphertext **
3. secondary key + encrypted data = keyed digest
4. secret key + nonce + keyed digest = encrypted keyed digest

SealBox = encrypted data + encrypted keyed digest
	
![[Seal box.png]]

### Code Example
code is actually much more simpler and do a lots of these stuff under the hood.
```swift
let str = "very secret stuff"
let data = str.data(using: .utf8)!
let key = SymmetricKey(size: .bits256)

//sender creates sealbox
let sealBox = try! AES.GCM.seal(data, using: key)
let sealBoxData = sealBox.combined!

//Sender sends sealboxData through network ...

//Receiver get the sealbox
let receivedSealBox = try! AES.GCM.SealedBox(combined: sealBoxData)
let decryptedData = try! AES.GCM.open(receivedSealBox, using: key)
print(String(data: decryptedData, encoding: .utf8)!)
// prints "very secrey stuff"
```

## Digital Signature 
🟢 Pros: act like HMAC but data get **signed** by **private key** and **validate** by **public key.**
🔴 Cons: data can only get validated not decryptable.
![[Screen Shot 2021-03-29 at 5.31.16 PM.png]]

### Code Example
```swift
// sender creates private key and public key      
let senderSPrivateKey = Curve25519.Signing.PrivateKey()
let senderSPublicKeyData = senderSPrivateKey.publicKey.rawRepresentation
//sender signs the data
let signature = try! senderSPrivateKey.signature(for: stringdata)

 //sender sends signed data + public key data through network ...

//receiver catch public key data and signed data
//creates public key
let reciverSPublicKey = try! Curve25519.Signing.PublicKey(rawRepresentation: senderSPublicKeyData)
//then validates data
reciverSPublicKey.isValidSignature(signature, for: stringdata)
```

## End to End Encryptions
🟢 Pros: Data can get encrypted and decrypted, only public key transmitted through network, symmetric keys build on each device seperetly and they are exactly the same.
### How it works
Imagine A wants to send B a message
first A and B needs a same symmetric key that don’t get transmitted through network fully.
in order for this here is what they need to do:
1. **A** creates a **private key** by using Curve2519 and creates a **public key data** from it.

2. **B** creates a **private key** by using Curve2519 and creates a **public key data** from it.

3. they send their **public key data**s through network ...

4. **A** creates **B public key** using the **public key data** that did received.

5. **B** creates **A public key** using the **public key data** that did received.

6. **A** creates **shared secret** by using its own **private key** and **B public key**

7. **B** creates **shared secret** by using its own **private key** and **A public key**

8. they both create **the same symmetric key** from the **share secret** that they built and **some other info** like salt ...

### Code example
```swift
let str = "very secret stuff"
let data = str.data(using: .utf8)!
//some salt both did agree on
let salt = "some sult".data(using: .utf8)!

//A do this localy (1)
let APrivateKey = Curve25519.KeyAgreement.PrivateKey()
let APublicKeyDATA = APrivateKey.publicKey.rawRepresentation

//B do this localy (2)
let BPrivateKey = Curve25519.KeyAgreement.PrivateKey()
let BPublicKeyDATA = BPrivateKey.publicKey.rawRepresentation

// public key datas exchange through network ... (3)

//A received B public key data (4) (6) (8)
let BPublicKey = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: BPublicKeyDATA)
let ASharedSecret = try! APrivateKey.sharedSecretFromKeyAgreement(with: BPublicKey)
let ASymmetricKey = reciverSharedSecret.hkdfDerivedSymmetricKey(using: SHA512.self, salt: salt, sharedInfo: Data(), outputByteCount: 32) 

//B received A public key data (5) (7) (8)
let APublicKey = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: APublicKeyDATA)
let BSharedSecret = try! BPrivateKey.sharedSecretFromKeyAgreement(with: APublicKey)
let BSymmetricKey = senderSharedSecret.hkdfDerivedSymmetricKey(using: SHA512.self, salt: salt, sharedInfo: Data(), outputByteCount: 32)

//They are the same!
ASymmetricKey == BSymmetricKey //true
```

