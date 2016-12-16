//
//  MGUserLoanModel.m
//  zhifu
//
//  Created by Unchastity on 12/6/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGUserLoanModel.h"

@implementation MGUserLoanModel

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
    NSLog(@"UserLoanModel undefined key = %@", key);
    
}

@end
