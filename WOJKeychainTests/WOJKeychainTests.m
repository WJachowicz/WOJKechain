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
    afterEach(^{
        [WOJKeychain deleteSecureObjectForKey:key];
    });
    context(@"saving", ^{
        it(@"should return YES when saved successfully", ^{
            NSString *secureObject = @"value";
            BOOL result = [WOJKeychain saveSecureObject:secureObject forKey:key];
            [[theValue(result) should] beYes];

        });
        it(@"should delete old value of object under the key", ^{
            [[WOJKeychain should] receive:@selector(deleteSecureObjectForKey:) withArguments:key];
            NSString *secureObject = @"value";
            [WOJKeychain saveSecureObject:secureObject forKey:key];
        });
    });
    context(@"saving and loading", ^{
        it(@"should save and load NSString object ", ^{
            NSString *secureObject = @"value";
            [WOJKeychain saveSecureObject:secureObject forKey:key];
            NSString *loadedObject = [WOJKeychain loadSecureObjectForKey:key];
            [[loadedObject should] equal:secureObject];
        });
        it(@"should save and load NSNumber object ", ^{
            NSNumber *secureObject = @10;
            [WOJKeychain saveSecureObject:secureObject forKey:key];
            NSString *loadedObject = [WOJKeychain loadSecureObjectForKey:key];
            [[loadedObject should] equal:secureObject];
        });
        it(@"should save and load NSArray object ", ^{
            NSArray *secureObject = @[@10,@11];
            [WOJKeychain saveSecureObject:secureObject forKey:key];
            NSString *loadedObject = [WOJKeychain loadSecureObjectForKey:key];
            [[loadedObject should] equal:secureObject];
        });
    });
    context(@"when deleting object", ^{
        it(@"should not be any value under the key", ^{
            NSString *secureObject = @"value";
            [WOJKeychain saveSecureObject:secureObject forKey:key];
            [WOJKeychain deleteSecureObjectForKey:key];
            NSString *loadedObject = [WOJKeychain loadSecureObjectForKey:key];
            [[loadedObject should] beNil];
        });
    });
});

SPEC_END
