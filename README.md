# SpriteKitSeeThrough

[![Version](https://img.shields.io/cocoapods/v/SpriteKitSeeThrough.svg?style=flat)](http://cocoapods.org/pods/SpriteKitSeeThrough)
[![License](https://img.shields.io/cocoapods/l/SpriteKitSeeThrough.svg?style=flat)](http://cocoapods.org/pods/SpriteKitSeeThrough)
[![Platform](https://img.shields.io/cocoapods/p/SpriteKitSeeThrough.svg?style=flat)](http://cocoapods.org/pods/SpriteKitSeeThrough)

## What it is

`InvertedCircleMaskNode` allows you to create a SpriteKit node that can act as an inverted circular mask. It can be used, for example, to be able to allow the player to see behind walls if your character is behind a wall.

This is possible by using an image of a transparent (alpha 0) circle within a rectangle of the size of the scene. Behind the scenes, this little library will pre-generate this image for you given a position and radius so you don't have to create any assets manually.

![Constants](Example/images/iso-example.png)

It's easier to understand if you see for yourself, so try out the included example app.

## Usage

```swift
let cropNode = SKCropNode()

for wall in walls { cropNode.addChild(wall) }

let mask = InvertedCircleMaskNode(sceneSize: scene.size,
                                  circleCenter: position,
                                  radius: radius)

cropNode.maskNode = mask
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

SpriteKitSeeThrough is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SpriteKitSeeThrough"
```

## Author

Daniel Inkpen, dan2552@gmail.com

## License

SpriteKitSeeThrough is available under the MIT license. See the LICENSE file for more info.

