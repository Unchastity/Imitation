//
//  MGKeyChain.h
//  zhifu
//
//  Created by Unchastity on 12/6/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGKeyChain : NSObject

+(void)save:(NSString *)service data:(id)data;

+(id)load:(NSString *)service;

+(void)deleteKeyData:(NSString *)service;

@end
