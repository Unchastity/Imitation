//
//  HotProductionView.h
//  MGPICC
//
//  Created by Unchastity on 11/30/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HotProductionViewDelegate <NSObject>

@optional
-(void)clickHotProductionViewWithTag:(long)tag;

@end

@interface HotProductionView : UIView

@property(nonatomic, weak) id<HotProductionViewDelegate> delegate;

@property(nonatomic, strong) NSArray *hotArr;

-(instancetype)initWithFrame:(CGRect)frame;

@end
