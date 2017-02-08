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

## Important Things to Consider

1. You need to create a default Conversation, which new installed users will join automatically. We are working on the best way to "bootstrap" this default Conversation

    Run `Conversation.generateDefaultConversation()` immediately upon logging in before going to the main ChatViewController 

2. Do not run that again or it will remove any other users.
