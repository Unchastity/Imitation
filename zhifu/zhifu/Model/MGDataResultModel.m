//
//  MGDataResultModel.m
//  zhifu
//
//  Created by Unchastity on 12/6/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGDataResultModel.h"

@implementation MGDataResultModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString: @"new_loan"]) {
        self.newloan = value;
    }

    //NSLog(@"MGDataResultModel undefinekey: %@", key);
}

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

@end
