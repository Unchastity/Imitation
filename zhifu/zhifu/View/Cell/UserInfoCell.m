//
//  UserInfoCell.m
//  zhifu
//
//  Created by Unchastity on 12/7/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "UserInfoCell.h"
#import "NSString+CountNumChangeFormat.h"
@interface UserInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *totalLend;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@end

@implementation UserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellForTableView:(UITableView *)tableView withTotalLend:(NSString *)totalLend
{
    static NSString *cellId = @"UserInforCell";
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *newTotalLend = [NSString changeFormatToEnglish: totalLend];
    newTotalLend = [newTotalLend stringByAppendingString:@"元"];
    [cell.totalLend setText: newTotalLend];
    return cell;
}

- (IBAction)clickRegisterNowBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickRegisterNowBtn)]) {
        [self.delegate clickRegisterNowBtn];
    }
}

@end
