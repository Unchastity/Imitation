//
//  HomeLoanInforCell.h
//  zhifu
//
//  Created by Unchastity on 12/13/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "LoanInforCell.h"

@class MGLoanModel;
@interface HomeLoanInforCell : LoanInforCell

@property (nonatomic, strong) MGLoanModel *loanModel;

-(void)setLoanModel:(MGLoanModel *)LoanModel;
@end
