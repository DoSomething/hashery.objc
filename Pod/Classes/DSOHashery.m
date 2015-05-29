//
//  DSOHashery.m
//  hashery
//
//  Created by Tong Xiang on 5/20/15.
//  Copyright (c) 2015 DoSomething.org. All rights reserved.
//

#import "DSOHashery.h"

/**
 * Convert integers to string representation.
 *
 * Caveats / Limitations
 *  - the number of words to use in a code is dictated by the number of arrays
 * provided. If three word arrays are provided, the code will be three words long.
 *  - word arrays provided must be the same length 
 *  - the maximum number of digits able to be represented: [array count] ^ (number of arrays)
 *
 */

@implementation DSOHashery

/**
 * Returns the singleton instance of DSOHashery.
 *
 * @return NSInteger
 */
+ (id)sharedHashery {
    // Defines static variable hashery which is initialized only once.
    static DSOHashery *hashery = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hashery = [[self alloc] init];
    });
    return hashery;
}

/**
 * Sets the arrays of words used for producing the hash.
 *
 * @return BOOL
 */
- (BOOL)setWordArrayLists:(NSArray *)wordArrayLists
{
    if (!wordArrayLists || !wordArrayLists.count) {
        NSAssert(NO, @"setWordArrayLists must be passed a valid array of arrays containing hash words.");
    }
    
    NSInteger testSize = 0;
    
    for (int i = 0; i < wordArrayLists.count; i++) {
        NSArray *arrayIndex = [wordArrayLists objectAtIndex:i];
        if (i == 0) {
            testSize = arrayIndex.count;
            if (testSize == 0) {
                NSAssert(NO, @"setWordArrayLists must be passed a valid array of arrays containing hash words.");
            }
        }
        else if (testSize != arrayIndex.count) {
            NSAssert(NO, @"setWordArrayLists must be passed an array of arrays of equal length.");
        }
    }
    
    _words = wordArrayLists;
    _codeLength = _words.count;
    
    _base = [[_words objectAtIndex:0] count];
    
    NSInteger base = _base;
    for (int i = 1; i < _words.count; i++) {
        base *= _base;
    }
    _maxIntegerValueOfHash = base - 1;
    NSLog(@"_maxIntegerValueOfHash: %zd", _maxIntegerValueOfHash);
    return YES;
}

/**
 * Returns max possible value that can be decoded given the nested list of words provided.
 *
 * @return NSInteger
 */
- (NSInteger)getMaxIntegerValueOfHash
{
    NSLog(@"_maxIntegerValueOfHash within getMaxIntegerValueOfHash: %zd", _maxIntegerValueOfHash);
    return _maxIntegerValueOfHash;
}

/**
 * Encode a base-10 number to a unique string representation.
 *
 * @param val NSInteger to encode
 * @return NSString
 */
- (NSString *)encodeBase10ToUniqueString:(NSInteger)val
{
    if (val > _maxIntegerValueOfHash) {
        NSAssert(false, @"encodeBase10ToUniqueString must be passed an integer less than the max integer value possible by the hash.");
    }
    
    NSMutableArray *baseConverted = [self convertBase10IntegerToArrayContainingNewBaseNumbers:val];
    NSString *result = [self convertArrayOfBaseNumbersToWordString:baseConverted];
    NSLog(@"main function returns: %@", result);
    return result;
}

/**
 * This is the first step in the process of converting a number to its String representation. The
 * number gets converted from base-10 to base-N, where N is the length of an item in mWords.
 *
 * For example, if mWords[0] is an array of length 40, then we're converting to base-40.
 *
 * This then gives us an array of integers where the length of the resulting array is equal to
 * the length of mWords.
 *
 * @param val Base-10 number to convert
 * @return NSMutableArray representation of the base-N conversion
 */
- (NSMutableArray *)convertBase10IntegerToArrayContainingNewBaseNumbers:(NSInteger)val
{
    NSMutableArray *result = [[NSMutableArray alloc] init]; // creating result array
    NSInteger quotient = val; //
    while (quotient != 0) {
        NSInteger dividend = quotient;
        quotient = dividend  / _base; // does not yield a decimal, instead rounds down to the nearest integer.
        NSInteger remainder = dividend % _base;
        [result insertObject: [NSNumber numberWithInteger:remainder] atIndex:0]; // inserting number at beginning of array.
    }
    return result;
}

/**
 * This is the second step of the conversion. Maps the integer values of the base-N conversion
 * to corresponding strings in the mWords array of arrays.
 *
 * @param vals ArrayList representation of the base-N converted number
 * @return String
 */
- (NSString *)convertArrayOfBaseNumbersToWordString:(NSMutableArray *)vals
{
    NSString *result = [[NSString alloc] init]; //inits result string
    NSInteger valuePosition = [vals count] - 1; // index of base number array we're going to convert to a string, starting from the end
    for (NSInteger i = _codeLength - 1; i >= 0; i--) {
        NSInteger val = 0; // the value of a specific
        if (valuePosition >= 0) {
            val = [[vals objectAtIndex:valuePosition] integerValue];
            valuePosition--;
        }
        
        NSMutableArray *words = [_words objectAtIndex:i]; // finding the right array from _words, that array of arrays
        result = [(NSString *)[words objectAtIndex:val] stringByAppendingString:result]; // finding the word at at the 'val' index in "words".
    }
    return result;
}


/**
 * Decode a string to its original base-10 number.
 *
 * @param val NSString to decode
 * @return NSInteger On success, returns the decoded number. On failure, returns -1.
 */
- (NSInteger)decodeUniqueStringToBase10:(NSString *)val
{
    NSMutableArray *baseN = [[NSMutableArray alloc] init];
    
    NSInteger matchesFound = 0;
    
    NSString *encoded = val;
    
    while ([encoded length] > 0) {
        BOOL matchFound = NO;
        
        // If text still remains and all word arrays have been gone through, then it's invalid.
        if (matchesFound >= [_words count]) {
            return -1;
        }
        
        NSMutableArray *words = [_words objectAtIndex:matchesFound];
        for (NSInteger i = 0; i < [words count] && !matchFound; i++) {
            NSString *word = [words objectAtIndex:i];
            if ([encoded rangeOfString:word].location == 0) { // Looping through the word list to see if that word is present within encoded. If it's at index 0, that word is first.
                matchFound = YES;
                [baseN addObject:@(i)]; // Converting i, a native value, to an object, and adding it to baseN
                matchesFound++; // Increment to move on to next _words item
                
                encoded = [encoded stringByReplacingCharactersInRange:[encoded rangeOfString:word] withString:@""]; // Remove substring of word from encoded string
            }
        }
        
        // If no match is found on any of the word checks, we have an invalid code.
        if (!matchFound) {
            return -1;
        }
    }
    
    // Sanity check that length of baseN is same as _words
    
    if ([baseN count] != [_words count]) {
        return -1;
    }
    
    // The result of the previous step is a base-N representation of the original base-10 number.
    // Now we convert back to base-10.
    
    NSInteger result = 0;
    for (NSInteger i = 0; i < [baseN count]; i++) {
        NSInteger n = [baseN[i] integerValue];
        NSInteger power = [baseN count] - 1 - i;
        
        result += n * pow(_base, power);
    }
    





    return result;
}

@end
