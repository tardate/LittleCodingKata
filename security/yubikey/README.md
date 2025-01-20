# #165 YubiKey

A closer look at the YubiKey hardware security token, how it works, the CLI and GUI, and how it can be used with a range of services.
Also demonstrate how to setup with Wasabi Cloud Storage - an example of a service that supports 2-factor authentication but not specifically the YubiKey.

## Notes

I first heard about the [YubiKey](https://www.yubico.com/) hardware security key on
[Security Now! Podcast #143](https://www.grc.com/sn/sn-143.htm) - from way back in May 2008.

## YubiKey 5 NFC

* Multi-protocol support: FIDO2, U2F, Smart card, OTP, OpenPGP 3
* Interface: USB-A, NFC
* IP68 rated: dust tight and water submersible

[![yubikey5nfc](./assets/yubikey5nfc.png?raw=true)](https://www.yubico.com/sg/works-with-yubikey/catalog/#protocol=all&usecase=all&key=yubikey-5-nfc)

## Services

See [Works with YubiKey catalog](https://www.yubico.com/sg/works-with-yubikey/catalog/) for full list of currently supported services.

Some of the services I've personally used the YubiKey with...

* Google Account Login
    * [yubico: Google Accounts](https://www.yubico.com/sg/works-with-yubikey/catalog/google-accounts/)
    * [Google: Use a security key for 2-Step Verification](https://support.google.com/accounts/answer/6103523)
    * Tested:
        * MacOS High Sierra / Chrome browser
        * MacOS High Sierra / Firefox browser
* GitHub
    * [yubico: GitHub](https://www.yubico.com/sg/works-with-yubikey/catalog/github/)
    * [GitHub: Configuring two-factor authentication](https://docs.github.com/en/github/authenticating-to-github/configuring-two-factor-authentication#configuring-two-factor-authentication-using-fido-u2f)
    * enable 2FA with Google Authenticator app, then can add Yubikey as a security key
    * Tested:
        * MacOS High Sierra / Chrome browser
        * MacOS High Sierra / Firefox browser
* [Wasabi](https://wasabi.com/) Cloud Storage
    * not a documented/supported integration, but can use OATH
* [KeepassXC](https://keepassxc.org/project/) - cross-platform, open-source password manager successor to the original [KeePass](https://keepass.info/)
    * [GitHub - source](https://github.com/keepassxreboot/keepassxc)
    * [How do I configure my YubiKey / OnlyKey for use with KeePassXC?](https://keepassxc.org/docs/#faq-yubikey-howto)
    * [Using Your YubiKey with KeePass](https://support.yubico.com/hc/en-us/articles/360013779759-Using-Your-YubiKey-with-KeePass)

## YubiKey Manager (ykman) CLI & GUI

The YubiKey Manager (ykman) is a cross-platform application for configuring any YubiKey. It provides an easy way to perform the most common configuration tasks on a YubiKey, such as:

* Displaying the serial number and firmware version of a YubiKey
* Configuring a FIDO2 PIN
* Resetting the FIDO applications
* Configuring the OTP application. A YubiKey has two slots (Short Touch and Long Touch). This tool can configure a Yubico OTP credential, a static password, a challenge-response credential or an OATH HOTP credential in either or both of these slots.
* Manage certificates and PINs for the PIV application
* Swap the credentials between two configured slots
* Enable and disable USB and NFC interfaces

Installation

```sh
pip install --user yubikey-manager
```

The installation directory was not on the path, so added:

```sh
export PATH="$PATH:$HOME/.local/bin"
```

### ykman info

```sh
$ ykman list
YubiKey 5 NFC (5.2.7) [OTP+FIDO+CCID] Serial: ########
$ ykman info
Device type: YubiKey 5 NFC
Serial number: ########
Firmware version: 5.2.7
Form factor: Keychain (USB-A)
Enabled USB interfaces: OTP, FIDO, CCID
NFC transport is enabled.

Applications  USB     NFC
FIDO2     Enabled Enabled
OTP       Enabled Enabled
FIDO U2F  Enabled Enabled
OATH      Enabled Enabled
OpenPGP   Enabled Enabled
PIV       Enabled Enabled
```

## YubiKey Manager (ykman) GUI

The [YubiKey Manager (ykman) GUI](https://developers.yubico.com/yubikey-manager-qt/) is a cross-platform application
that provides a graphical user interface for managing most YubiKey features (a subset of what can be managed wuth the ykman command line tool)

![yubikey_manager](./assets/yubikey_manager.png?raw=true)

## OATH

The [YubiKey supports OATH](https://developers.yubico.com/OATH/OATH_Walk-Through.html)
that in turn can be used to authenticate with a wide range of services that support MFA - see the
[2FA Directory](https://2fa.directory/)

### Wasabi Cloud Storage

[Wasabi Cloud Storage](https://wasabi.com/) is an example of a service that supports MFA,
but doesn't have any direct integration or support for the YubiKey.

Here's my run-through to see how easy it is to setup.

First I installed [Yubico Authenticator](https://developers.yubico.com/yubioath-desktop/Releases/) (aka yubioath-desktop)
on my laptop. This provides a GUI tool for managing OATH accounts. The GUI is optional - this could all be done from the command line,
however the GUI specifically assists with:

* automatically capturing the QR code presented on the Wasabi MFA setup page
* provides a simple double-click to trigger auth prompt to generate code for completing MFA setup

In the Wasabi MFA setup page I turned on MFA and used the Yubico Authenticator to scan the QR code from the page:

![wasabi-mfa-enable](./assets/wasabi-mfa-enable.png?raw=true)

This adds the account in the Yubico Authenticator (actually, it is stored on the YubiKey):

![wasabi-add-account](./assets/wasabi-add-account.png?raw=true)

After using the Yubico Authenticator to generate two codes that need to be added to the Wasabi MFA setup page, MFA is enabled:

![wasabi-mfa-enabled](./assets/wasabi-mfa-enabled.png?raw=true)

Now when returning to Wasabi, I am prompted for MFA token:

![wasabi-mfa-prompt](./assets/wasabi-mfa-prompt.png?raw=true)

I need to insert my YubiKey and use the Yubico Authenticator to initiate touch code generation to get a code I can paste into the sign-in screen:

![wasabi-yubico-authenticator](./assets/wasabi-yubico-authenticator.png?raw=true)

Alternatively, codes can be generated from the command line instead of using the Yubico Authenticator GUI:

```sh
$ ykman oath accounts list
Wasabi Technologies:root-account-XXXXXXXXXXX@wasabi.com
$ ykman oath accounts code wasabi
Touch your YubiKey...
Wasabi Technologies:root-account-XXXXXXXXXXX@wasabi.com  739330
```

See [OATH_Commands](https://docs.yubico.com/ykman/OATH_Commands.html#) for more info.

## Credits and References

* [Yubico](https://www.yubico.com/)
* [YubiKey - start](https://www.yubico.com/start)
* [Security Now! Podcast #143: YubiKey](https://www.grc.com/sn/sn-143.htm)
* [YubiKey Manager (ykman) CLI & GUI Guide](https://docs.yubico.com/ykman/)
* [2FA Directory](https://2fa.directory/)
