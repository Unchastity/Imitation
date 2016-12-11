//
//  MGDetailTableViewController.m
//  zhifu
//
//  Created by Unchastity on 12/10/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGDetailTableViewController.h"
#import "MGLoanModel.h"
#import "MGUserLoanModel.h"

#import "LoanTitleHeaderView.h"
@interface MGDetailTableViewController ()

@end

@implementation MGDetailTableViewController

+(instancetype)viewControllerFromStoryboard
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier: @"MGDetailTableViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
      static NSString *cellID = @"cellID";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellID forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellID];
//    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellID];
    return cell;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    
//}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70.0;
}
//在系统的headerView中添加自定义的heraderView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        static NSString *titleHeaderViewID = @"titleHeaderViewID";
        LoanTitleHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier: titleHeaderViewID];
        if (!headerView) {
            headerView = [[LoanTitleHeaderView alloc] initWithReuseIdentifier: titleHeaderViewID];
        }
        if (self.loanModel != nil) {
            headerView.title = self.loanModel.title;
            headerView.loansn = self.loanModel.loansn;
        }else if (self.userLoanModel != nil){
            headerView.title = self.userLoanModel.title;
            headerView.title = self.userLoanModel.loansn;
        }
        return headerView;
        
    }
    return nil;
//    static NSString *titleHeaderViewID = @"titleHeaderViewID";
//    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier: titleHeaderViewID];
//    if (!headerView) {
//        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier: titleHeaderViewID];
//        if (section == 0) {
//            
//        }
//    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.tableView reloadData];
}
@end
