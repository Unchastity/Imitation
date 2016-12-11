//
//  LoanTitleHeaderView.h
//  zhifu
//
//  Created by Unchastity on 12/10/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanTitleHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) NSString *loansn;
@property (nonatomic, strong) NSString *title;

//-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
//

-(void)setTitle:(NSString *)title;

-(void)setLoansn:(NSString *)loansn;


@end
