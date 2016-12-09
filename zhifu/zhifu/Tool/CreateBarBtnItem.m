//
//  CreateBarBtnItem.m
//  zhifu
//
//  Created by Unchastity on 12/8/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

//factory class

#import "CreateBarBtnItem.h"

@implementation CreateBarBtnItem

+(UIBarButtonItem *)createBarBtnItemWithTitle:(NSString *)title
                                   image:(NSString *)image
                                   frame:(CGRect)frame
                         titleEdgeInsets:(UIEdgeInsets)titleInsets
                         imageEdgeInsets:(UIEdgeInsets)imageInsets
                                  Target:(id)target
                                  select:(SEL)action
{
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = frame;
    button.titleEdgeInsets = titleInsets;
    button.imageEdgeInsets = imageInsets;
    [button setTitle: title forState: UIControlStateNormal];
    [button setImage:[[UIImage imageNamed: image] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button addTarget: target action:action forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView: button];
    
    return barBtnItem;
}

@end
