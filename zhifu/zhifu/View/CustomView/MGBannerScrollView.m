//
//  MGBannerScrollView.m
//  zhifu
//
//  Created by Unchastity on 12/6/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGBannerScrollView.h"
#import "MGMacro.h"
#import "MGBannersModel.h"

@interface MGBannerScrollView ()<UIScrollViewDelegate>
{
    NSTimer *_timer;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation MGBannerScrollView

-(instancetype)initWithFrame:(CGRect)frame withBannersArr:(NSArray *)bannersArr
{
    self = [super initWithFrame: frame];
    if (self) {
        
        NSInteger cnt = bannersArr.count;
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame: frame];
        scrollView.contentSize = CGSizeMake(frame.size.width * cnt, frame.size.height) ;
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        
        for (NSInteger i = 0; i < cnt; ++i) {
            UIImageView *imageView = [[UIImageView alloc] init];
            CGFloat w = frame.size.width;
            CGFloat h = frame.size.height;
            CGFloat x = i * w;
            CGFloat y = 0;
            imageView.frame = CGRectMake(x, y, w, h);
            imageView.tag = i + 10;
            imageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBannerView:)];
            [imageView addGestureRecognizer: tapGes];
            
            [scrollView addSubview: imageView];
        }
        self.scrollView = scrollView;
        [self addSubview: self.scrollView];
        
        self.pageControl = [[UIPageControl alloc] init];
        CGFloat pageW = 13 * cnt;
        CGFloat pageH = 37;
        CGFloat pageX = (frame.size.width - pageW) * 0.5;
        CGFloat pageY = frame.size.height - 40;
        self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
        self.pageControl.numberOfPages = cnt;
        self.pageControl.currentPage = 0;
        self.pageControl.hidesForSinglePage = YES;
        self.pageControl.defersCurrentPageDisplay = YES;
        [self.pageControl updateCurrentPageDisplay];
        [self addSubview: self.pageControl];

        //[self addTimer];
    }
    return self;
}

-(void)clickBannerView:(UITapGestureRecognizer *)ges
{
    NSInteger tag = ges.view.tag;
    if ([self.delegate respondsToSelector:@selector(clickBannerWithBannerModel:)]) {
        [self.delegate clickBannerWithBannerModel: self.bannersArr[tag - 10]];
    }
}

-(void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (self.pageControl.currentPage == self.pageControl.numberOfPages - 1) {
            self.pageControl.currentPage = 0;
        }else
        {
            self.pageControl.currentPage++;
        }
        
        CGFloat offSetX = self.scrollView.bounds.size.width * self.pageControl.currentPage;
        self.scrollView.contentOffset = CGPointMake( offSetX, 0);
    }];
}

-(void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}

-(void)setBannersArr:(NSArray *)bannersArr
{
    _bannersArr = bannersArr;
    
    for (NSInteger i = 0; i < bannersArr.count; ++i)
    {
        MGBannersModel *bannerModel = bannersArr[i];
        
        UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag: 10 + i];
        NSString *imageUrl = bannerModel.image;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: imageUrl] cachePolicy:0 timeoutInterval:10.0f];
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *image = [UIImage imageWithData: data];
                    //NSLog(@"image size = %@", NSStringFromCGSize(image.size));
                    [imageView setImage: image];
                });
            }
        }];
        [task resume];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addTimer];
    });
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollW = self.scrollView.bounds.size.width;
    CGFloat x = self.scrollView.contentOffset.x;
    NSInteger page = (x + scrollW * 0.5) / scrollW;
    self.pageControl.currentPage = page;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}
@end
