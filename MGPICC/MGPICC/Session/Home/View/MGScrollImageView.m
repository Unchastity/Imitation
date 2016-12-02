//
//  MGScrollImageView.m
//  MGPICC
//
//  Created by Unchastity on 11/30/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGScrollImageView.h"
#import "MGMacro.h"

@interface MGScrollImageView ()<UIScrollViewDelegate>
{
    NSTimer *_timer;
    NSInteger _numberOfPage;
}
@end

@implementation MGScrollImageView

-(MGScrollImageView *)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _numberOfPage = imageArr.count;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _numberOfPage, frame.size.height);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.backgroundColor = [UIColor orangeColor];
        for (NSInteger i = 0; i < _numberOfPage; ++i) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, frame.size.height);
            imageView.tag = 100 + i;
            imageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickScrollImage:)];
            [imageView addGestureRecognizer:tapGes];
            
            [self.scrollView addSubview: imageView];
        }
        [self addSubview: self.scrollView];
    
        
        if (_numberOfPage > 0) {
            self.pageControl = [[UIPageControl alloc] init];
            CGFloat widthOnePage = 12.0;
            CGFloat pageW = widthOnePage * _numberOfPage;
            CGFloat pageH = 30;
            CGFloat pageX = (SCREEN_WIDTH - pageW) * 0.5;
            CGFloat pageY = frame.size.height - 40;
            self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
            self.pageControl.numberOfPages = _numberOfPage;
            self.pageControl.currentPage = 0;
            [self addSubview: self.pageControl];
            
            [self addTimer];
        }
        
    }
    return self;
}

-(void)setImageArr:(NSArray *)imageArr
{
    
}

-(void)clickScrollImage:(UITapGestureRecognizer *)sender
{
    long index = (long)sender.view.tag;
    NSLog(@"clickScrollImage: %ld", index);
    if ([self.delegate respondsToSelector:@selector(clickScrollImageWithTag:)]) {
        [self.delegate clickScrollImageWithTag:index];
    }
}

-(void)addTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        NSInteger page = self.pageControl.currentPage;
        page = page == (_numberOfPage -1) ? 0 : ++page;
        
        CGFloat scrollX = page * self.scrollView.frame.size.width;
        self.scrollView.contentOffset = CGPointMake(scrollX, 0);
    }];
    _timer = timer;
}
-(void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollW = self.scrollView.frame.size.width;
    CGFloat x = self.scrollView.contentOffset.x;
    NSInteger page = (x + scrollW * 0.5) / scrollW;
    self.pageControl.currentPage = page;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

-(void)dealloc
{
    [self removeTimer];
}

@end
