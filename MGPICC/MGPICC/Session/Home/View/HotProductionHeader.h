//
//  HotProductionHeader.h
//  MGPICC
//
//  Created by Unchastity on 11/30/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HotProductionHeaderDelegate <NSObject>

@optional
-(void)hotProductionclickedMoreBtn;

@end

@interface HotProductionHeader : UIView

@property(nonatomic, weak) id<HotProductionHeaderDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame;

@end
