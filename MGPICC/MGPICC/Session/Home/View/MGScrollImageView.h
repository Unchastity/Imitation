//
//  MGScrollImageView.h
//  MGPICC
//
//  Created by Unchastity on 11/30/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGScrollImageViewDelegate <NSObject>

@optional

/**
 代理方法，选择scroll image时，跳转

 @param tag <#tag description#>
 */
-(void)clickScrollImageWithTag:(long)tag;

@end

@interface MGScrollImageView : UIView

@property(nonatomic, weak) id <MGScrollImageViewDelegate>delegate;

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIPageControl *pageControl;
@property(nonatomic, strong) NSArray *imageArr;

-(void)setImageArr:(NSArray *)imageArr;

-(MGScrollImageView *)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArr;
@end
