//
//  UserInfoCell.h
//  zhifu
//
//  Created by Unchastity on 12/7/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserInfoCellDelegate <NSObject>

@optional
-(void)clickRegisterNowBtn;

@end


@interface UserInfoCell : UITableViewCell

@property (weak, nonatomic) id<UserInfoCellDelegate> delegate;

//@property(nonatomic, copy)   NSString  *totalLendStr;

+(instancetype)cellForTableView:(UITableView *)tableView withTotalLend:(NSString *)totalLend;

@end
