# Password Strength Testers

Checking out various Javascript-based password strength testers and trying to find one that best implements latest NIST guidelines.

## Notes

The [NIST Digital Identity Guidelines](https://pages.nist.gov/800-63-3/sp800-63-3.html) are generally considered the gold standard and are widely adopted. Passwords are covered in NIST 800-63B 5.1.1.2 Memorized Secret Verifiers. Here's a brief summary of the relevant recommendations:

* memorized secrets to be at least 8 characters in length
* permit memorized secrets to be at least 64 characters in length
* SHALL NOT permit the subscriber to store a password "hint"
* SHOULD NOT impose other composition rules (e.g. requiring mixtures of different character types or prohibiting consecutively repeated characters) for memorized secrets.
* SHALL reject prospective memorized secrets that are matched in:
  * Passwords obtained from previous breach corpuses.
  * Dictionary words.
  * Repetitive or sequential characters (e.g. "aaaaaa", "1234abcd").
  * Context-specific words, such as the name of the service, the username, and derivatives thereof.
* Verifiers SHOULD offer guidance to the subscriber, such as a password-strength meter
* SHALL implement a rate-limiting mechanism that effectively limits the number of failed authentication attempts that can be made on the subscriber’s account
* SHOULD permit claimants to use "paste" functionality when entering a memorized secret
* SHOULD offer an option to display the secret being entered

These items all relate to the authentication user experience, and the notes that follow are a quick examination of available Javascript libraries, with the specific intent of finding those that do a good job of representing the latest NIST recommendations.

Results so far:

* [jquery.pwstrength.bootstrap](https://github.com/ablanco/jquery.pwstrength.bootstrap) - best free-standing Javascript library
* [enzoic](https://www.enzoic.com/) - best as-a-service offering


## Evaluating Available Libraries

Certainly not exhaustive, but here's a quick look at some libraries, taken from [10 Best Password Strength Checkers In JavaScript](https://www.jqueryscript.net/blog/best-password-strength-checker.html) and other web searches.

### jquery.pwstrength.bootstrap

The [jquery.pwstrength.bootstrap](https://github.com/ablanco/jquery.pwstrength.bootstrap) integrates very easily with Boostrap 2/3/4.
It provides an entropy check, and
[configuration options](https://github.com/ablanco/jquery.pwstrength.bootstrap/blob/master/OPTIONS.md)
to support some other NIST guidelines. For example:

* common options:
  * minChar: minimum required of characters for a password to not be considered too weak
  * maxChar: maximum allowed characters for a password
  * invalidCharsRegExp: A regular expression object to use to test for banned characters in the password.
  * usernameField: The username field to match a password to, to ensure the user does not use the same value for their password
  * specialCharClass: This is the regular expression class used to match special chars whitin the rules engine.
  * commonPasswords: A list of the most common passwords. If the user inputs a password present in the list, then it gets heavily penalized
* available rules to enable/disable:
  * wordNotEmail
  * wordMinLength
  * wordMaxLength
  * wordInvalidChar
  * wordSimilarToUsername
  * wordSequences
  * wordTwoCharacterClasses
  * wordRepetitions
  * wordLowercase
  * wordUppercase
  * wordOneNumber
  * wordThreeNumbers
  * wordOneSpecialChar
  * wordTwoSpecialChar
  * wordUpperLowerCombo
  * wordLetterNumberCombo
  * wordLetterNumberCharCombo


[![jquery.pwstrength.bootstrap](./assets/jquery.pwstrength.bootstrap.png?raw=true)](./examples/jquery.pwstrength.bootstrap/index.html)

* [basic demo](./examples/jquery.pwstrength.bootstrap/index.html)
* [barCssClasses demo](./examples/jquery.pwstrength.bootstrap/barCssClasses.html)
* [popover demo](./examples/jquery.pwstrength.bootstrap/popover.html)
* [username demo](./examples/jquery.pwstrength.bootstrap/username.html)
* [zxcvbn demo](./examples/jquery.pwstrength.bootstrap/zxcvbn.html)
* [translations demo](./examples/jquery.pwstrength.bootstrap/i18n.html)

### password_strength

The [password_strength](https://github.com/mkurayan/password_strength) library has a few problems:

* designed as a JQuery Widget which is nice, but this makes it quite difficult to add to existing forms/fields (probably the main developer use-case)
* provides entropy check/feedback
* also provides other password checks (length, permitted characters), however these don't follow NIST guidelines and are not configurable

[![password_strength](./assets/password_strength.png?raw=true)](./examples/password_strength/index.html)

### PWStrength

The [PWStrength](https://github.com/chenmeister/PWStrength) is very minimal - it is more a basic example framework that can be extended than a full solution. Limitations:

* not designed to be nicely namespaced and cleanly integrated into client-side code
* does not provide entropy check/feedback
* default password checks (length, permitted characters) don't follow NIST guidelines precisely

[![PWStrength](./assets/PWStrength.png?raw=true)](./examples/PWStrength/index.html)

## Enzoic

Enzoic [Password Strength Meter](https://www.enzoic.com/docs-password-strength-meter/) is a free-to-use but branded
Javascript library for checking password strength but also verify that the password has not been publicly exposed.

Enzoic also provide [services for server-side integration](https://www.enzoic.com/) for comprehensive account protection.

[![enzoic](./assets/enzoic.png?raw=true)](./examples/enzoic/index.html)

Note: this does NOT mean all the passwords are getting sent over to Enzoic. That would be a very inappropriate trust relationship.
As can be seen here, only partial SHA256, SHA1 and MD5 hashes of the password are being entered:

![enzoic_traffic](./assets/enzoic_traffic.png?raw=true)

## Other Services

* [haveibeenpwned API](https://haveibeenpwned.com/API/v3) - can be used to check for password and account breaches/pwnage.
* [zxcvbn](https://github.com/dropbox/zxcvbn) - "best known existing library for estimating password strength is zxcvbn by Dropbox"

## Credits and References

* [NIST Special Publication 800-63B](https://pages.nist.gov/800-63-3/sp800-63-3.html) aka NIST Password Guidelines
* [10 Best Password Strength Checkers In JavaScript](https://www.jqueryscript.net/blog/best-password-strength-checker.html)
* [password_strength](https://github.com/mkurayan/password_strength)
* [PWStrength](https://github.com/chenmeister/PWStrength)
* [jquery.pwstrength.bootstrap](https://github.com/ablanco/jquery.pwstrength.bootstrap)
* [haveibeenpwned API](https://haveibeenpwned.com/API/v3)
* [zxcvbn](https://github.com/dropbox/zxcvbn) - "best known existing library for estimating password strength is zxcvbn by Dropbox"
* [Enzoic Strength Meter](https://www.enzoic.com/free-password-strength-meter/)
