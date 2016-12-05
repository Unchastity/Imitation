//
//  MGSingleCellView.h
//  MGPICC
//
//  Created by Unchastity on 12/2/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGMGInitialCellDelegate <NSObject>

@optional
-(void)clickInitialBtn:(NSString *)initial;

@end

@interface MGInitialCell : UITableViewCell

@property(nonatomic, weak) id<MGMGInitialCellDelegate> delegate;

+(instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath withArray:(NSArray *)arr;

//-(instancetype)initSingeCellWithFrame:(CGRect)frame withArray:(NSArray *)arr;

@end
