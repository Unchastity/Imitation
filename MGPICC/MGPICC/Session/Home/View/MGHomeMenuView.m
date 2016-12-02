//
//  MGHomeMenuView.m
//  MGPICC
//
//  Created by Unchastity on 11/30/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGHomeMenuView.h"

#import "MenuModel.h"

@implementation MGHomeMenuView

-(MGHomeMenuView *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat menuW = frame.size.width / 4;
        CGFloat menuH = frame.size.height / 2;
        for (NSInteger i = 0; i < 8; ++i) {
            UIView *menuView = [[UIView alloc] init];
            CGFloat menuX = i % 4 * menuW;
            CGFloat menuY = i / 4 * menuH;
            menuView.frame = CGRectMake(menuX, menuY, menuW, menuH);
            menuView.tag = 150 + i;
            menuView.backgroundColor = [UIColor whiteColor];
            
            UIImageView *menuImageView = [[UIImageView alloc] init];
            CGFloat menuImageW = 60.0;
            CGFloat menuImageH = 60.0;
            CGFloat menuImageX = (menuW - menuImageW) * 0.5;
            CGFloat menuImageY = 5;
            menuImageView.frame = CGRectMake(menuImageX, menuImageY, menuImageW, menuImageH);
            [menuView addSubview: menuImageView];
            
            UILabel *menuLabel = [[UILabel alloc] init];
            CGFloat menuLabelW = menuW;
            CGFloat menuLabelH = 15;
            CGFloat menuLabelX = 0;
            CGFloat menuLabelY = CGRectGetMaxY(menuImageView.frame) + 5;
            menuLabel.frame = CGRectMake(menuLabelX, menuLabelY, menuLabelW, menuLabelH);
            menuLabel.textAlignment = NSTextAlignmentCenter;
            [menuView addSubview: menuLabel];
            
            [self addSubview: menuView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHomeMenu:)];
            [menuView addGestureRecognizer:tap];
        }
    }
    return self;
}

-(void)setMenuArr:(NSArray *)menuArr
{
    _menuArr = menuArr;
    
    for (NSInteger i = 0; i < 8; ++i) {
        
        MenuModel *menuModel = menuArr[i];
        UIImage *image = [UIImage imageNamed: menuModel.iconName];
        UIView *menuView = [self viewWithTag: 150 + i];
        for (UIView *view in menuView.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [(UIImageView*)view setImage:image];
            }
            if ([view isKindOfClass:[UILabel class]]) {
                //NSLog(@"menuModel name = %@", menuModel.name);
                [(UILabel *)view setText: menuModel.name];
            }
        }
    }
    
}

-(void)clickHomeMenu:(UITapGestureRecognizer *)sender
{
    long tag = sender.view.tag;
    if ([self.delegate respondsToSelector:@selector(homeMenuClickedWithTag:)]) {
        [self.delegate homeMenuClickedWithTag: tag];
    }
}


@end
