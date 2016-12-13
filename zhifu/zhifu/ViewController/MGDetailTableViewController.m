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
#import "HomeLoanInforCell.h"
#import "HomeUserLoanInforCell.h"
@interface MGDetailTableViewController ()
{
    NSArray *_loanStatusListArr;
    NSArray *_loanStatusImageList;
}
@property (nonatomic, strong) NSMutableArray *statusArr;
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
    [self.navigationItem setTitle: @"投资详情"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _loanStatusListArr = @[@"发标时间", @"当前状态", @"已投金额", @"可投金额", @"最低投标金额", @"让利金额"];
    _loanStatusImageList = @[@"icon_t_time", @"icon_t_startTime", @"icon_t_money_red", @"icon_t_money_green", @"icon_t_money_red", @"icon_t_money_decress"];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
    {
        return 1;
    }else if (section == 1)
    {
        return  self.loanModel == nil ? 6 : 5;
    }else
    {
        
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0)
    {
        static NSString *loanCellID = @"loanCellID";
        if (_isLoanSection)
        {
            HomeLoanInforCell *cell = [HomeLoanInforCell cellForTableView: tableView reuseIdentifier: loanCellID];
            cell.loanModel = self.loanModel;
            cell.isDetailCell = YES;
            return cell;
        }else
        {
            HomeUserLoanInforCell *cell = [HomeUserLoanInforCell cellForTableView: tableView reuseIdentifier: loanCellID];
            cell.userLoanModel = self.userLoanModel;
            cell.isDetailCell = YES;
            return cell;
        }
    } else if (indexPath.section == 1)
    {
        static NSString *loanStatusCellID = @"loanStatusCellID";
        UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier: loanStatusCellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: loanStatusCellID];
        }
        UIImage *image = [UIImage imageNamed: _loanStatusImageList[indexPath.row]];
        [cell.imageView setImage: image];
        [cell.textLabel setText: _loanStatusListArr[indexPath.row]];
        [cell.detailTextLabel setText: self.statusArr[indexPath.row]];
        return cell;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: @"cellID"];
    [cell.textLabel setText: @"45678"];
    [cell.detailTextLabel setText: @"dfghjk"];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 100.0;
    }else if (indexPath.section == 1)
    {
        return 50.0;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 70.0;
    }else {
        return 5.0;
    }
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
//            [headerView addSubview: customHeaderView];
//        }
//    }
//     return headerView;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.tableView reloadData];
}

-(NSMutableArray *)statusArr
{
    if (!_statusArr) {
        NSString *startTime = self.loanModel == nil ? self.userLoanModel.starttime : self.loanModel.lssuingtime;
        long ratio = self.loanModel == nil ? self.userLoanModel.ratio : self.loanModel.ratio;
        NSString *currentStatus;
        if (ratio == 100) {
            currentStatus = @"已完成";
        }else {
            currentStatus = [NSString stringWithFormat: @"%ld%%", ratio];
        }
        NSString *invitedMoney = self.loanModel == nil ? self.userLoanModel.loanmoney : self.loanModel.loanmoney;
//        long userLoanB = self.userLoanModel.tendermoney.integerValue - self.userLoanModel.loanmoney.integerValue;
//        long loanB = self.loanModel.tendermoney.integerValue - self.loanModel.loanmoney.integerValue;
//        NSString *balance = [NSString stringWithFormat: @"%ld", self.loanModel == nil ? userLoanB : loanB];
        NSString *balance = @"0.00元";
        NSString *lowestMoney = @"0.00元";
        NSString *profile = [NSString stringWithFormat: @"%@元", self.userLoanModel.overflow_money];
        _statusArr = [NSMutableArray arrayWithObjects: startTime, currentStatus, invitedMoney, balance, lowestMoney, profile, nil];
    }
    return _statusArr;
}

@end
