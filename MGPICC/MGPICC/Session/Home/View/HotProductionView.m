//
//  HotProductionView.m
//  MGPICC
//
//  Created by Unchastity on 11/30/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "HotProductionView.h"

@implementation HotProductionView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        
        CGFloat productionViewW = frame.size.width / 2;
        CGFloat productionViewH = frame.size.height / 2;
        for (NSInteger i = 0; i < 4; ++i) {
            
            CGFloat imageX = i % 2 * productionViewW;
            CGFloat imageY = i / 2 * productionViewH;
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(imageX, imageY, productionViewW - 0.5, productionViewH - 0.5);
            imageView.tag = 160 + i;
            [self addSubview: imageView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
            [imageView addGestureRecognizer: tap];
        }
    }
    
    return self;
}

-(void)setHotArr:(NSArray *)hotArr
{
    _hotArr = hotArr;
    for (NSInteger i = 0; i < 4; ++i) {
        
        UIImage *image = [UIImage imageNamed:hotArr[i]];
        UIImageView *imageView = (UIImageView *)[self viewWithTag: 160 + i];
        [imageView setImage: image];
    }
}

-(void)tapImage:(UITapGestureRecognizer *)sender
{
    long tag = (long)sender.view.tag;
    if ([self.delegate respondsToSelector:@selector(clickHotProductionViewWithTag:)]) {
        [self.delegate clickHotProductionViewWithTag: tag];
    }
    
}

@end
