//
//  WOJKeychain.m
//  WOJKeychain
//
//  Created by Wojciech Jachowicz on 27.01.2014.
//  Copyright (c) 2014 Wojciech Jachowicz. All rights reserved.
//

#import "WOJKeychain.h"
@import Security;

@interface WOJKeychain ()

/**
 *  Method for creating dictionary containing a secure item class specification.
 *
 *  @param key NSString representing item search key.
 *
 *  @return Dictionary with secure item search specification.
 */
+ (NSMutableDictionary *) secureQueryForKey:(NSString *)key;

@end

@implementation WOJKeychain

+ (BOOL)saveSecureObject:(id)object forKey:(NSString *)key
{
    
    NSData *valueData = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSMutableDictionary * secureQuery = [self secureQueryForKey:key];
    [secureQuery setObject:valueData forKey:(__bridge id)kSecValueData];
    
    CFTypeRef result = NULL;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)secureQuery, &result);
    
    if (status == errSecSuccess){
        return YES;
    } else {
        return NO;
    }
}

+ (id)loadSecureObjectForKey:(NSString *)key
{
    NSMutableDictionary *secureQuery = [self secureQueryForKey:key];
    [secureQuery setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [secureQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef cfData = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)secureQuery, (CFTypeRef *)&cfData);
    if (status == errSecSuccess) {
        id secureObject = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)cfData];
        CFRelease(cfData);
        return secureObject;
    } else{
        if (cfData) {
            CFRelease(cfData);
        }
        return nil;
    }
}

+ (BOOL)deleteSecureObjectForKey:(NSString *)key
{
    return NO;
}

#pragma mark - private

+ (NSMutableDictionary *)secureQueryForKey:(NSString *)key
{
    NSString *service = [[NSBundle mainBundle] bundleIdentifier];
    if (!service) {
        service = key;
    }
    return [NSMutableDictionary dictionaryWithObjects:@[(__bridge id)kSecClassGenericPassword, service, key] forKeys:@[(__bridge id)kSecClass, (__bridge id)kSecAttrService, (__bridge id)kSecAttrAccount]];
}

@end
