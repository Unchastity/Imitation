//
//  UIAlertController+CreateAlertControllerQuickly.h
//  zhifu
//
//  Created by Unchastity on 12/9/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (CreateAlertControllerQuickly)

+(UIAlertController *)createAlertControllerWithTitle:(NSString *)title
                                             message:(NSString *)msg
                                      preferredStyle:(UIAlertControllerStyle)preferredStyle;
@end
