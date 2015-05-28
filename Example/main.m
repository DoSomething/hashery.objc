//
//  main.m
//  hashery
//
//  Created by Tong Xiang on 5/20/15.
//  Copyright (c) 2015 DoSomething.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DSOHashery/DSOHashery.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Testing the functionality of the hashery.
        
        NSArray *wordArray = @[
            @[@"big", @"tall", @"short", @"husky"],
            @[@"orange", @"grey", @"purple", @"vermillion"],
            @[@"monkey", @"sloth", @"giraffe", @"dolphin"]
        ];
        
        DSOHashery *hashery = [DSOHashery sharedHashery];
        
        [hashery setWordArrayLists:wordArray];
        
        [hashery getMaxIntegerValueOfHash];
        
        [hashery encodeBase10ToUniqueString:31];
        
        [hashery decodeUniqueStringToBase10:@"tallvermilliondolphin"];
    }
    return 0;
}