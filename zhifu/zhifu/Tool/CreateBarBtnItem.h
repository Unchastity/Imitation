//
//  CreateBarBtnItem.h
//  zhifu
//
//  Created by Unchastity on 12/8/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateBarBtnItem : UIBarButtonItem

+(UIBarButtonItem *)createBarBtnItemWithTitle:(NSString *)title
                                   image:(NSString *)image
                                   frame:(CGRect)frame
                         titleEdgeInsets:(UIEdgeInsets)titleInsets
                         imageEdgeInsets:(UIEdgeInsets)imageInsets
                                  Target:(id)target
                                  select:(SEL)action;


@end
