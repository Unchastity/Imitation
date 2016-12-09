//
//  UIAlertController+CreateAlertControllerQuickly.m
//  zhifu
//
//  Created by Unchastity on 12/9/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "UIAlertController+CreateAlertControllerQuickly.h"

@implementation UIAlertController (CreateAlertControllerQuickly)

+(UIAlertController *)createAlertControllerWithTitle:(NSString *)title
                                             message:(NSString *)msg
                                      preferredStyle:(UIAlertControllerStyle)preferredStyle
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: title
                                                                             message: msg
                                                                      preferredStyle: preferredStyle];
    UIAlertAction *action = [UIAlertAction actionWithTitle: @"确认"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                   }];
    [alertController addAction: action];
    
    return alertController;
}


@end
