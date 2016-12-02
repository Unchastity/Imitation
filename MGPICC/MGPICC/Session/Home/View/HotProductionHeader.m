//
//  HotProductionHeader.m
//  MGPICC
//
//  Created by Unchastity on 11/30/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "HotProductionHeader.h"

@implementation HotProductionHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat lineViewW = 3;
        CGFloat lineViewH = 20;
        CGFloat lineViewX = 5;
        CGFloat lineViewY = (frame.size.height - lineViewH) * 0.5;
        CGRect  lineViewFrame = CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH);
        UIView *lineView = [[UIView alloc] initWithFrame:lineViewFrame];
        lineView.backgroundColor = [UIColor redColor];
        [self addSubview: lineView];
        
        CGFloat labelX = CGRectGetMaxX(lineView.frame) + 3;
        CGFloat labelY = lineViewY;
        CGFloat labelW = 70;
        CGFloat labelH = lineViewH;
        UILabel *hotProductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        [hotProductionLabel setText:@"热门产品"];
        hotProductionLabel.font = [UIFont systemFontOfSize:17];
        [hotProductionLabel setTextColor: [UIColor redColor]];
        [self addSubview: hotProductionLabel];
        
        CGFloat moreBtnW = 60;
        CGFloat moreBtnH = 20;
        CGFloat moreBtnX = frame.size.width - moreBtnW;
        CGFloat moreBtnY = labelY;
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        moreBtn.frame = CGRectMake(moreBtnX, moreBtnY, moreBtnW, moreBtnH);
        moreBtn.adjustsImageWhenHighlighted = NO;
        moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [moreBtn setTitle:@"更多>" forState:UIControlStateNormal];
        [moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(clickMoreBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: moreBtn];
    }
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

-(void)clickMoreBtn
{
    if ([self.delegate respondsToSelector:@selector(hotProductionclickedMoreBtn)]) {
        
        [self.delegate hotProductionclickedMoreBtn];
    }
}

@end
