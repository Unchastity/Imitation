//
//  MGInviteUserLoanModel.m
//  zhifu
//
//  Created by Unchastity on 12/16/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGInviteUserLoanModel.h"

@implementation MGInviteUserLoanModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary: dict];
    }
    return self;
}

+(instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict: dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"MGInviteUserLoanModel undefine key= %@", key);
    if ([key isEqualToString: @"id"]) {
        self.ID = value;
    }
}

@end
