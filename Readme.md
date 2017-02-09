## RChat, a mobile chat powered by RealmChat

Special thanks to Chatto project for doing incredible work on the UI side of things

## Requirements to Build

You'll need **cococapods**
Install cocoapods with `$ sudo gem install cocoapods`

1. clone this repository `git clone https://github.com/mbalex99/rchat`
2. go to the directory `$ cd rchat`
3. run `pod install`
4. open the workspace `open RChat.xcworkspace`

## Pointing to the Correct Server

Go to the file `RChatConstants.swift` and replace **both** the urls for:

```swift
static var objectServerEndpoint : URL {
    return URL(string: "realm://138.197.85.79:9080" )!
}


static var authServerEndpoint : URL {
    return URL(string: "http://138.197.85.79:9080" )!
}
```
