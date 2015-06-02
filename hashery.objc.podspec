Pod::Spec.new do |s|
  s.name             = "hashery.objc"
  s.version          = "0.1.0"
  s.summary          = "A library which converts numbers into human-readable word combinations."
  s.description      = <<-DESC
                  
#### Use Cases 
Useful for generating easy-to-remember unique passcodes. 

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
                       DESC
  s.homepage         = "https://github.com/DoSomething/hashery.objc"
  s.license          = 'MIT'
  s.author           = { "Tong Xiang" => "tong.xiang2@gmail.com" }
  s.source           = { :git => "https://github.com/DoSomething/hashery.objc.git", :tag => "0.1.0" }
  # s.social_media_url = 'https://twitter.com/tong_xiang'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'hashery.objc' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end