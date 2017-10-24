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

Go to the file `RChatConstants.swift` and replace the IP address for the Realm Server address with you server IP:

```swift
// NB: this is a Realm2.x app - it MUST run against a 2.x server
let realmServerAddress = "127.0.0.1"
```
