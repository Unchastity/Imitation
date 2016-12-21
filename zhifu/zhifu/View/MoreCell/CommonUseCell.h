//
//  CommonUseCell.h
//  zhifu
//
//  Created by Unchastity on 12/21/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommonUseCellDelegate <NSObject>

@optional
-(void)clickCommonUseBtnWithTag:(long)tag;

@end

@interface CommonUseCell : UITableViewCell

@property (weak, nonatomic) id<CommonUseCellDelegate> delegate;


+(instancetype)cellForMoreTableView:(UITableView *)table reuseIdentifier:(NSString *)identifier;
@end
