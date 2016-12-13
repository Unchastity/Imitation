//
//  HomeUserLoanInforCell.h
//  zhifu
//
//  Created by Unchastity on 12/13/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "LoanInforCell.h"

@class MGUserLoanModel;
@interface HomeUserLoanInforCell : LoanInforCell

//@property (nonatomic, strong) MGUserLoanModel *userLoanModel;

-(void)setUserLoanModel:(MGUserLoanModel *)userLoanModel;
@end
