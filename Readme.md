## RChat, a mobile chat powered by Realm

Special thanks to Chatto project for doing incredible work on the UI side of things

## Requirements to Build

You'll need **cococapods**
Install cocoapods with `$ sudo gem install cocoapods`

1. clone this repository `git clone https://github.com/realm/roc-ios`
2. go to the directory `$ cd roc-ios`
3. run `pod update`
4. open the workspace `open RChat.xcworkspace`

## Pointing to the Correct Server

Go to the file `RChatConstants.swift` (which is in the `RChat/Data` directory)  and replace the IP address for the Realm Server address with you server IP:

```swift
// NB: this is a Realm2.x app - it MUST run against a 2.x server
let realmServerAddress = "127.0.0.1"
```

## Initial User Setup

Since this is _client focued demo_, there is not a back-end server that sets up the RChat Realm or its permissions.  In order to ensure the Realm permissions are correctly set the first user that logs in using the RChat service needs to be a Realm Server Administrator user.

To accomplish this, launch Realm Studio and create one user that will be "user #1" for RChat  and grant that user Server Administrator permission. Tthis is done by creating or editing a user and then setting the administrator permission in the User Panel as shown here:

<center><img  src="Graphics/RealmStudio-admin-privs.png"/> </center>


