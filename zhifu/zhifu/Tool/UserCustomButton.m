//
//  UserCustomButton.m
//  zhifu
//
//  Created by Unchastity on 12/17/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "UserCustomButton.h"

@implementation UserCustomButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect: rect];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat width = CGRectGetWidth(contentRect);
    CGFloat height = 20;
    CGFloat x = 0;
    CGFloat y = 74;
    return CGRectMake(x, y, width, height);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat width = 57;
    CGFloat height = 57;
    CGFloat x = (contentRect.size.width - width) * 0.5;
    CGFloat y = 12;
    return CGRectMake(x, y, width, height);
}
@end
