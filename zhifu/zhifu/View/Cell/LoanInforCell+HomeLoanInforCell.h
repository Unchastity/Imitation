//
//  LoanInforCell+HomeLoanInforCell.h
//  zhifu
//
//  Created by Unchastity on 12/13/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "LoanInforCell.h"
@class MGLoanModel, MGUserLoanModel;
@interface LoanInforCell (HomeLoanInforCell)

@property (nonatomic, strong) MGLoanModel *loanModel;

@property (nonatomic, strong) MGUserLoanModel *userLoanModel;

//-(void)setUserLoanModel:(MGUserLoanModel *)userLoanModel;
//
//-(void)setLoanModel:(MGLoanModel *)loanModel;
//

-(void)setLoanModel:(MGLoanModel *)loanModel;
-(void)setUserLoanModel:(MGUserLoanModel *)userLoanModel;
@end
