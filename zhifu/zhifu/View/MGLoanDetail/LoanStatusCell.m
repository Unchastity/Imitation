//
//  LoanStatusCell.m
//  zhifu
//
//  Created by Unchastity on 12/12/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "LoanStatusCell.h"

@implementation LoanStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
//    if (self) {
//        
//    }
//}

-(void)setLoanModel:(MGLoanModel *)loanModel
{
    _loanModel = loanModel;
    
    
}

-(void)setUserLoanModel:(MGUserLoanModel *)userLoanModel
{
    _userLoanModel = userLoanModel;
}

@end
