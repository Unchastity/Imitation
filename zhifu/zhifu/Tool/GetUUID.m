//
//  GetUUID.m
//  zhifu
//
//  Created by Unchastity on 12/6/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "GetUUID.h"
#import "MGKeyChain.h"

static NSString * const KEY_PASSWORD = @"com.company.app.password";
static NSString * const KEY_USERNAME = @"com.company.app.password";
static NSString * const KEY_USERNAME_PASSWORD = @"com.company.app.usernamepassword";

@implementation GetUUID

+(NSString *)getUUID
{
    NSString *strUUID = (NSString *)[MGKeyChain load: @"com.company.app.usernamepassword"];
    
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidRef));
        
        [MGKeyChain save: KEY_USERNAME_PASSWORD data: strUUID];
    }
    
    return strUUID;
}

@end
