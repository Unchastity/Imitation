//
//  NSString+CountNumChangeFormat.h
//  zhifu
//
//  Created by Unchastity on 12/7/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CountNumChangeFormat)

+(instancetype)changeFormatToEnglish:(NSString *)string;

+(BOOL)isMobileNumber:(NSString *)mobileNum;
@end
