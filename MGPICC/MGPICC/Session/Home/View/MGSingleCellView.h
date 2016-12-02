//
//  MGSingleCellView.h
//  MGPICC
//
//  Created by Unchastity on 12/2/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGSingleCellViewDelegate <NSObject>

@optional
-(void)clickBtnWithTag:(NSInteger)tag;

@end

@interface MGSingleCellView : UIView

@property(nonatomic, weak) id<MGSingleCellViewDelegate> delegate;

-(instancetype)initSingeCellWithFrame:(CGRect)frame withArrar:(NSArray *)arr;
@end
