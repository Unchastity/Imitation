//
//  MGKeyChain.m
//  zhifu
//
//  Created by Unchastity on 12/6/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGKeyChain.h"
#import <Security/Security.h>

static NSString * const KEY_PASSWORD = @"com.company.app.password";
static NSString * const KEY_USERNAME = @"com.company.app.password";
static NSString * const KEY_USERNAME_PASSWORD = @"com.company.app.usernamepassword";

@implementation MGKeyChain

+(NSMutableDictionary *)getKeyChainQuery:(NSString *)service
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword, (id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock, (id)kSecAttrAccessible ,nil];
}

+(void)save:(NSString *)service data:(id)data
{
    NSMutableDictionary *keyChainQuery = [self getKeyChainQuery: service];
    
    SecItemDelete((CFDictionaryRef)keyChainQuery);
    
    [keyChainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    
    SecItemAdd((CFDictionaryRef)keyChainQuery, NULL);
}

+(id)load:(NSString *)service
{
    id ret = nil;
    NSMutableDictionary *keyChainQuery = [self getKeyChainQuery: service];
    
    [keyChainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    
    [keyChainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    
    CFDataRef keyData = NULL;
    
    if (SecItemCopyMatching((CFDictionaryRef)keyChainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
            
        } @catch (NSException *exception) {
            NSLog(@"Unarchiver of %@ failed: %@", service, exception);
            
        } @finally {
            
        }
    }
    if (keyData) {
        CFRelease(keyData);
    }
}

+(void)deleteKeyData:(NSString *)service
{
    NSMutableDictionary *keyChainQuery = [self getKeyChainQuery: service];
    
    SecItemDelete((CFDictionaryRef)keyChainQuery);
}

@end
