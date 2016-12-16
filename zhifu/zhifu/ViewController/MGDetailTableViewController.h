//
//  MGDetailTableViewController.h
//  zhifu
//
//  Created by Unchastity on 12/10/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MGDetailTableViewController : UITableViewController

@property (nonatomic, assign) BOOL isLoanSection;

@property (nonatomic, copy)   NSString *loanSN;
@property (nonatomic, copy)   NSString *user_loanSN;

+(instancetype)viewControllerFromStoryboard;

@end
