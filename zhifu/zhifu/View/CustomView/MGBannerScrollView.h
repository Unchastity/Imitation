//
//  MGBannerScrollView.h
//  zhifu
//
//  Created by Unchastity on 12/6/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGBannersModel;

@protocol MGBannerScrollViewDelegate <NSObject>

@optional
-(void)clickBannerWithBannerModel:(MGBannersModel *)bannerModel;

@end

@interface MGBannerScrollView : UIView

@property (weak, nonatomic) id<MGBannerScrollViewDelegate> delegate;

@property (nonatomic, strong) NSArray *bannersArr;

-(instancetype)initWithFrame:(CGRect)frame withBannersArr:(NSArray *)bannersArr;

-(void)setBannersArr:(NSArray *)bannersArr;
@end
