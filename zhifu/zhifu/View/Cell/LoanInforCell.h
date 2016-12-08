//
//  LoanInforCell.h
//  zhifu
//
//  Created by Unchastity on 12/7/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGLoanModel, MGUserLoanModel;
@interface LoanInforCell : UITableViewCell

@property (nonatomic, strong) MGLoanModel *loanModel;

@property (nonatomic, strong) MGUserLoanModel *userLoanModel;

-(void)setLoanModel:(MGLoanModel *)loanModel;

-(void)setUserLoanModel:(MGUserLoanModel *)userLoanModel;

+(instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

@end
