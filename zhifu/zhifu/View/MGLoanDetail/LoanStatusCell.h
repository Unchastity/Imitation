//
//  LoanStatusCell.h
//  zhifu
//
//  Created by Unchastity on 12/12/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGLoanModel, MGUserLoanModel;

@interface LoanStatusCell : UITableViewCell

@property (nonatomic, strong) MGLoanModel *loanModel;

@property (nonatomic, strong) MGUserLoanModel *userLoanModel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
