//
//  DSOHashery.h
//  hashery
//
//  Created by Tong Xiang on 5/20/15.
//  Copyright (c) 2015 DoSomething.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSOHashery : NSObject
{
    NSInteger _maxIntegerValueOfHash;
    NSArray *_words;
    NSInteger _codeLength;
    NSInteger _base;
}

- (BOOL)setWordArrayLists:(NSArray*)wordArrayLists;

- (NSInteger)getMaxIntegerValueOfHash;

- (NSString *)encodeBase10ToUniqueString:(NSInteger)val;

- (NSInteger)decodeUniqueStringToBase10:(NSString*)val;

+ (id)sharedHashery;

@end