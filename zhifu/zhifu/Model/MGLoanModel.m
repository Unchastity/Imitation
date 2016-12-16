//
//  MGLoanModel.m
//  zhifu
//
//  Created by Unchastity on 12/6/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGLoanModel.h"

@implementation MGLoanModel


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
    
    NSLog(@"LoanModel undefinekey: %@", key);
    if ([key isEqualToString: @"id"])
    {
        self.ID = value;
    }
}
@end
