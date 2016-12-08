//
//  MGBannersModel.m
//  zhifu
//
//  Created by Unchastity on 12/6/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGBannersModel.h"

@implementation MGBannersModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary: dict];
    }
    return  self;
}

+(instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict: dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"MGBannersModel undefineKey: %@", key);
}
@end
