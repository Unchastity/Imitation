//
//  CommonUseCell.m
//  zhifu
//
//  Created by Unchastity on 12/21/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "CommonUseCell.h"
#import "UserCustomButton.h"

@interface CommonUseCell ()



@end

@implementation CommonUseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellForMoreTableView:(UITableView *)table reuseIdentifier:(NSString *)identifier
{
    CommonUseCell *cell = [table dequeueReusableCellWithIdentifier: identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed: @"CommonUseCell" owner: nil options: nil] lastObject];
    }
    return cell;
}

- (IBAction)clickCommonUseBtn:(UserCustomButton *)sender {
    
    long tag = sender.tag;
    if ([self.delegate respondsToSelector:@selector(clickCommonUseBtnWithTag:)])
    {
        [self.delegate clickCommonUseBtnWithTag: tag];
    }
}


@end
