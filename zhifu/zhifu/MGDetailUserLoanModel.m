//
//  MGDetailUserLoanModel.m
//  zhifu
//
//  Created by Unchastity on 12/13/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGDetailUserLoanModel.h"

@implementation MGDetailUserLoanModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"MGDetailUserLoanModel undefined key=%@", key);
    
    if ([key isEqualToString: @"id"]) {
        self.ID = value;
    }
}

@end
