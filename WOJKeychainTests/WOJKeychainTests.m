//
//  WOJKeychainTests.m
//  WOJKeychainTests
//
//  Created by Wojciech Jachowicz on 01.02.2014.
//  Copyright (c) 2014 Wojciech Jachowicz. All rights reserved.
//

#import "WOJKeychain.h"

#import "Kiwi.h"

SPEC_BEGIN(WOJKeychainTests)

describe(@"WOJKeychainTests", ^{
    NSString *key = @"key";
    context(@"saving and loading NSString", ^{
        it(@"should save and load NSString object ", ^{
            NSString *secureObject = @"value";
            BOOL result = [WOJKeychain saveSecureObject:secureObject forKey:key];
            NSString *loadedObject = [WOJKeychain loadSecureObjectForKey:key];
            [[theValue(result) should] beTrue];
            [[loadedObject should] equal:secureObject];
        });
        it(@"should save and load NSNumber object ", ^{
            NSNumber *secureObject = @10;
            BOOL result = [WOJKeychain saveSecureObject:secureObject forKey:key];
            NSString *loadedObject = [WOJKeychain loadSecureObjectForKey:key];
            [[theValue(result) should] beTrue];
            [[loadedObject should] equal:secureObject];
        });
        it(@"should save and load NSArray object ", ^{
            NSArray *secureObject = @[@10,@11];
            BOOL result = [WOJKeychain saveSecureObject:secureObject forKey:key];
            NSString *loadedObject = [WOJKeychain loadSecureObjectForKey:key];
            [[theValue(result) should] beTrue];
            [[loadedObject should] equal:secureObject];
        });
    });
});

SPEC_END
