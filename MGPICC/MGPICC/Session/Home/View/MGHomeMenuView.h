//
//  MGHomeMenuView.h
//  MGPICC
//
//  Created by Unchastity on 11/30/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGHomeMenuViewDelegate <NSObject>

@optional
-(void)homeMenuClickedWithTag:(long)tag;

@end

@interface MGHomeMenuView : UIView

@property(nonatomic, strong) id<MGHomeMenuViewDelegate> delegate;

@property(nonatomic, strong) NSArray *menuArr;

-(MGHomeMenuView *)initWithFrame:(CGRect)frame;

@end
