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

//校验手机号码
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    mobileNum = [mobileNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobileNum.length < 11) {
        return NO;
    }
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", MOBILE];
    BOOL isMobile = [regextestMobile evaluateWithObject: mobileNum];
    
    NSPredicate *regextestCM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    BOOL isCM = [regextestCM evaluateWithObject: mobileNum];
    
    NSPredicate *regextestCU = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", CU];
    BOOL isCU = [regextestCU evaluateWithObject: mobileNum];
    
    NSPredicate *regextestCT = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", CT];
    BOOL isCT = [regextestCT evaluateWithObject: mobileNum];
    
    if (isMobile || isCM || isCU || isCT)
    {
        return YES;
    }else
    {
        return NO;
    }
}

@end
