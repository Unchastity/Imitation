//
//  NSString+CountNumChangeFormat.m
//  zhifu
//
//  Created by Unchastity on 12/7/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "NSString+CountNumChangeFormat.h"

@implementation NSString (CountNumChangeFormat)

+(instancetype)changeFormatToEnglish:(NSString *)string
{
    if ([string isEqualToString: @""] || string == nil) {
        return string;
    }
    //分为整数部分和小数部分
    NSArray *numArr = [string componentsSeparatedByString:@"."];
    //整数部分
    NSMutableString *integerPart =[NSMutableString stringWithString: numArr[0]];
    //整数部分的长度
    NSInteger cntInt = integerPart.length;
    
    NSMutableArray *newIntArr = [NSMutableArray new];
    NSInteger i = cntInt;
    while (i > 3) {
        i -= 3;
        NSString *tmpStr = [integerPart substringWithRange:NSMakeRange( i, 3)];
        [newIntArr insertObject:tmpStr atIndex:0];
        [integerPart deleteCharactersInRange:NSMakeRange( i, 3)];
    }
    [newIntArr insertObject:integerPart atIndex:0];
    NSString *newIntStr = [newIntArr componentsJoinedByString:@","];
    NSString *pointPart = numArr[1];
    
    NSString *newStr = [newIntStr stringByAppendingString:@"."];
    newStr = [newStr stringByAppendingString:pointPart];
    
    return newStr;
}
@end
