//
//  WOJKeychain.h
//  WOJKeychain
//
//  Created by Wojciech Jachowicz on 27.01.2014.
//  Copyright (c) 2014 Wojciech Jachowicz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOJKeychain : NSObject

/**
 *  A method for saving secure item in keychain.
 *
 *  @param object An object to be saved in keychain.
 *  @param key    A search key which will be used for retrieving secure item.
 *
 *  @return BOOL value indicating whether the item was saved succefully or not.
 */
+ (BOOL) saveSecureObject:(id) object forKey:(NSString *)key;

/**
 *  A method for load secure item from keychain.
 *
 *  @param key A search key for retrieving secure item.
 *
 *  @return Secure object or nil if the item was not found with provided key.
 */
+ (id) loadSecureObjectForKey:(NSString *)key;

/**
 *  A method for deleting secure item from keychain under provided key.
 *
 *  @param key A search key for retrieving secure item.
 *
 *  @return BOOL value indicating whether the item was deleted or not.
 */
+ (BOOL) deleteSecureObjectForKey:(NSString *)key;
@end
