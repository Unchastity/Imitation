//
//  MGDetailTableViewController.h
//  zhifu
//
//  Created by Unchastity on 12/10/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGLoanModel, MGUserLoanModel;

@interface MGDetailTableViewController : UITableViewController

@property (nonatomic, strong) MGLoanModel       *loanModel;
@property (nonatomic, strong) MGUserLoanModel   *userLoanModel;


+(instancetype)viewControllerFromStoryboard;

@end
