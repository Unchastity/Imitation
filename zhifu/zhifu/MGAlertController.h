//
//  MGAlertController.h
//  zhifu
//
//  Created by Unchastity on 12/9/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_CLASS_DEPRECATED_IOS(2_0, 10_0, "UIAlertController+CreateAlertControllerQuickly.h instead")
@interface MGAlertController : UIAlertController

+(UIAlertController *)createAlertControllerWithTitle:(NSString *)title
                                             message:(NSString *)msg
                                      preferredStyle:(UIAlertControllerStyle)preferredStyle;

@end
