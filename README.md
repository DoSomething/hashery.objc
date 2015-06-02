# hashery.objc

[![CI Status](http://img.shields.io/travis/Tong Xiang/hashery.objc.svg?style=flat)](https://travis-ci.org/Tong Xiang/hashery.objc)
[![Version](https://img.shields.io/cocoapods/v/hashery.objc.svg?style=flat)](http://cocoapods.org/pods/hashery.objc)
[![License](https://img.shields.io/cocoapods/l/hashery.objc.svg?style=flat)](http://cocoapods.org/pods/hashery.objc)
[![Platform](https://img.shields.io/cocoapods/p/hashery.objc.svg?style=flat)](http://cocoapods.org/pods/hashery.objc)

## Usage

This is an Objective-C library that converts numbers into human-readable word combinations.

#### Get the library
Include the following line within your podfile: 
```
pod 'Hashery', :git => 'https://github.com/DoSomething/hashery.objc.git'
```

#### How to use it

- Create sets of words. These are not provided to you by the library.

Creates an array of arrays. The number of arrays within the array becomes the number of words in the hash string. Each array needs to have the same number of words. 
```
        NSArray *wordArray = @[
            @[@"big", @"tall", @"short", @"husky"],
            @[@"orange", @"grey", @"purple", @"vermilion"],
            @[@"monkey", @"sloth", @"giraffe", @"dolphin"]
        ];
```

Instantiates a hashery object. 
```
        DSOHashery *hashery = [[DSOHashery alloc] init];
```

Sets the hashery object to use the wordArray. 
```
        [hashery setWordArrayLists:wordArray];
```

Encodes `13` into a unique string. 
```    
        [hashery encodeBase10ToUniqueString:13];
```

Decodes a unique string into an integer. 
```    
        [hashery decodeUniqueStringToBase10:@"bigvermilionsloth"];
```
---

## Requirements

## Installation

hashery.objc is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "hashery.objc"
```

## Author

Tong Xiang, txiang@dosomething.org

## License

hashery.objc is available under the MIT license. See the LICENSE file for more info.
