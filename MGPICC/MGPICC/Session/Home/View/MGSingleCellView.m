//
//  MGSingleCellView.m
//  MGPICC
//
//  Created by Unchastity on 12/2/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGSingleCellView.h"

@implementation MGSingleCellView

-(instancetype)initSingeCellWithFrame:(CGRect)frame withArrar:(NSArray *)arr
{
    self = [super initWithFrame: frame];
    if (self) {
        CGFloat spacing = 1;
        CGFloat btnWidth = (frame.size.width - 2 * 10 - 3 * 1) * 0.25;
        CGFloat btnHeight = 30;
        for (NSInteger i = 0; i < 4; ++i) {
            CGFloat btnX = (btnWidth + spacing) * i + 10;
            CGFloat btnY = 0;
            CGRect  frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = 200 + i;
            btn.frame = frame;
            if (i < arr.count)
            {
               [btn setTitle:arr[i] forState:UIControlStateNormal];
            }
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.adjustsImageWhenHighlighted = NO;
            btn.backgroundColor = [UIColor whiteColor];
            [btn addTarget:self action:@selector(clickBtnWithTag:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview: btn];
        }
    }
    return self;
}

-(void)clickBtnWithTag:(NSInteger)tag
{
    NSInteger index = tag - 200;
    if ([self.delegate respondsToSelector:@selector(clickBtnWithTag:)]) {
        [self.delegate clickBtnWithTag: index];
    }
}

@end
