# #322 Practical Cryptography in Python

Book notes: Practical Cryptography in Python: Learning Correct Cryptography by Example, by Seth James Nielso,  Christopher K. Monson. Published September 27, 2019.

[![Build](./assets/practical-cryptography-in-python_build.jpg?raw=true)](https://amzn.to/3E1BI5J)

## Notes

See also:

* [amazon](https://amzn.to/3E1BI5J)
* [goodreads](https://www.goodreads.com/book/show/45007555-practical-cryptography-in-python)
* <https://www.oreilly.com/library/view/practical-cryptography-in/9781484249000/>

## Contents

1 Cryptography: More Than Secrecy

* Setting Up Your Python Environment
* Caesar's Shifty Cipher
* A Gentle Introduction to Cryptography
* Uses of Cryptography
* What Could Go Wrong?
* YANAC: You Are Not A Cryptographer
* "Jump Off This Cliff"-The Internet
* The cryptodoneright.org Project
* Enough Talk, Let's Sum Up
* Onward

2 Hashing

* Hash Liberally with hashlib
* Making a Hash of Education
    * Preimage Resistance
    * Second-Preimage and Collision Resistance
* Digestible Hash
* Pass Hashwords...Er...Hash Passwords
    * Pick Perfect Parameters
* Cracking Weak Passwords
* Proof of Work
* Time to Rehash

3 Symmetric Encryption: Two Sides, One Key

* Let's Scramble!
* What Is Encryption, Really?
* AES: A Symmetric Block Cipher
* ECB Is Not for Me
* Wanted: Spontaneous Independence
    * Not That Blockchain
    * Cross the Streams
* Key and IV Management
* Exploiting Malleability
    * Gaze into the Padding
* Weak Keys, Bad Management
* Other Encryption Algorithms finalize

4 Asymmetric Encryption: Public/Private Keys

* A Tale of Two Keys
* Getting Keyed Up
* RSA Done Wrong: Part One
* Stuffing the Outbox
* What Makes Asymmetric Encryption Different?
* Pass the Padding
    * Deterministic Outputs
    * Chosen Ciphertext Attack
    * Common Modulus Attack
* The Proof Is in the Padding
* Exploiting RSA Encryption with PKCS #1 v1.5 Padding
    * Step 1: Blinding
    * Step 2: Searching for PKCS-Conforming Messages
    * Step 3: Narrowing the Set of Solutions
    * Step 4: Computing the Solution
* Additional Notes About RSA
    * Key Management
    * Algorithm Parameters
    * Quantum Cryptography
* Really Short Addendum.

5 Message Integrity, Signatures, and Certificates

* An Overly Simplistic Message Authentication Code (MAC)
* MAC, HMAC, and CBC-MAC
    * HMAC
    * CBC-MAC
    * Encrypting and MACing
* Digital Signatures: Authentication and Integrity
    * Elliptic Curves: An Alternative to RSA
* Certificates: Proving Ownership of Public Keys
* Certificates and Trust
* Revocation and Private Key Protection
* Replay Attacks
* Summarize-Then-MAC

6 Combining Asymmetric and Symmetric Algorithms

* Exchange AES Keys with RSA
* Asymmetric and Symmetric: Like Chocolate and Peanut Butter
* Measuring RSA's Relative Performance
* Diffie-Hellman and Key Agreement
* Diffie-Hellman and Forward Secrecy
* Challenge-Response Protocols
* Common Problems
* An Unfortunate Example of Asymmetric and Symmetric Harmony
* That's a Wrap.

7 More Symmetric Crypto: Authenticated Encryption and Kerberos

* AES-GCM
* AES-GCM Details and Nuances
* Other AEAD Algorithm
* Working the Network
* An Introduction to Kerberos
    * Additional Data

8 TLS Communications

* Intercepting Traffic
* Digital Identities: X.509 Certificates
    * X.509 Fields
    * Certificate Signing Requests
    * Creating Keys, CSRs, and Certificates in Python
* An Overview of TLS 1.2 and 1.3
    * The Introductory "Hellos"
    * Client Authentication
    * Deriving Session Keys
    * Switching to the New Cipher
    * Deriving Keys and Bulk Data Transfer
    * TLS 1.3
* Certificate Verification and Trusting Trust
    * Certificate Revocation
    * Untrustworthy Roots, Pinning, and Certificate Transparency
* Known Attacks Against TLS
    * POODLE
    * FREAK and Logjam
    * Sweet32
    * ROBOT
    * CRIME, TIME, and BREACH
    * Heartbleed
* Using OpenSSL with Python for TLS
* The End of the Beginning
