//
//  CustomButton.m
//  zhifu
//
//  Created by Unchastity on 12/9/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //不自定义绘制frame;
    [super drawRect: rect];
    //设置title 居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

//button的size为 （60， 80）
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake( 0, 60, CGRectGetWidth(contentRect), 20.0);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake( 5, 0, 50.0, 50.0);
}


@end
