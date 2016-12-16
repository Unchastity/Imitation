//
//  MGDetailTableViewController.m
//  zhifu
//
//  Created by Unchastity on 12/10/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGDetailTableViewController.h"
#import "MGMacro.h"

#import "MGDetailLoanModel.h"
#import "MGDetailUserLoanModel.h"

#import "LoanTitleHeaderView.h"
#import "LoanInforCell+HomeLoanInforCell.h"

@interface MGDetailTableViewController ()
{
    NSArray *_loanStatusListArr;
    NSArray *_loanStatusImageList;
    UIActivityIndicatorView *_activityIndicator;
}

@property (nonatomic, strong) MGDetailLoanModel       *loanModel;
@property (nonatomic, strong) MGDetailUserLoanModel   *userLoanModel;

@property (nonatomic, strong) NSMutableArray *statusArr;
@end

@implementation MGDetailTableViewController

+(instancetype)viewControllerFromStoryboard
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier: @"MGDetailTableViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle: @"投资详情"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self initData];
    
    if (self.isLoanSection) {
        [self sendLoanRequest];
    }else {
        [self sendUserLoanRequest];
    }
}

-(void)initData
{
    _loanStatusListArr = @[@"发标时间", @"当前状态", @"已投金额", @"可投金额", @"最低投标金额", @"让利金额"];
    _loanStatusImageList = @[@"icon_t_time", @"icon_t_startTime", @"icon_t_money_red", @"icon_t_money_green", @"icon_t_money_red", @"icon_t_money_decress"];
    
//    _loanModel = [[MGDetailLoanModel alloc] init];
//    _userLoanModel = [[MGDetailUserLoanModel alloc] init];
}

-(void)sendLoanRequest
{
    NSString *urlStr = @"http://service.zhifubank.com/";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: urlStr]];
    [request setHTTPMethod: @"POST"];
    NSString *badyStr = [NSString stringWithFormat: @"_client_=IOS&_cmd_=loan_detail&%@&_sign_=c261aae92a1fd3d26c4e9b79e00a2f4a&page_type=&sn=%@",deviceUUID, self.loanSN];
    [request setHTTPBody: [badyStr dataUsingEncoding: NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData: data options: 0 error: 0];
            NSDictionary *dataResultDict = dict[@"dataresult"];
            
            _loanModel = [MGDetailLoanModel modelWithDict: dataResultDict[@"loan_info"]];
            [self.tableView reloadData];
        }
    }];
    [task resume];
}

-(void)sendUserLoanRequest
{
    NSString *urlStr = @"http://service.zhifubank.com/";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: urlStr]];
    [request setHTTPMethod: @"POST"];
    NSString *badyStr = [NSString stringWithFormat: @"_client_=IOS&_cmd_=user_loan_info&%@&_sign_=8b4160e65402f45fea4054e8a752f4d9&loansn=%@&page_type=&user_loansn=%@",deviceUUID, self.loanSN, self.user_loanSN];
    [request setHTTPBody: [badyStr dataUsingEncoding: NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData: data options: 0 error: 0];
            NSDictionary *dataResultDict = dict[@"dataresult"];
            
            _userLoanModel = [MGDetailUserLoanModel modelWithDict: dataResultDict[@"loan_info"]];
            [self.tableView reloadData];
        }
    }];
    [task resume];
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
         LoanInforCell *cell = [LoanInforCell cellForTableView: tableView reuseIdentifier: loanCellID];
        if (_isLoanSection)
        {
            cell.loanModel = self.loanModel;
            cell.isDetailCell = YES;
            return cell;
        }else
        {
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
        if (self.isLoanSection) {
            headerView.title = self.loanModel.title;
            headerView.loansn = self.loanModel.loansn;
        }else if (self.userLoanModel != nil){
            headerView.title = self.userLoanModel.title;
            headerView.loansn = self.userLoanModel.loansn;
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
//    if (self.loanModel != nil || self.userLoanModel != nil) {
    NSString *tmpStartTime = self.isLoanSection ?  self.loanModel.lssuingtime : self.userLoanModel.starttime;
    NSString *startTime = tmpStartTime != nil ? tmpStartTime : @" ";
    
    long tmpRatio = self.isLoanSection ? self.loanModel.ratio : self.userLoanModel.ratio;
    long ratio = tmpRatio != 0 ? tmpRatio : 0;
    
    NSString *currentStatus;
    if (ratio == 100) {
        currentStatus = @"已完成";
    }else if (ratio == 0){
        currentStatus = @"0";
    }else {
        currentStatus = [NSString stringWithFormat: @"%ld%%", ratio];
    }
    NSString *tmpMoney = self.isLoanSection ? self.loanModel.loanmoney : self.userLoanModel.loanmoney;
    NSString *invitedMoney = tmpMoney != nil ? tmpMoney : @"0.00";
//        long userLoanB = self.userLoanModel.tendermoney.integerValue - self.userLoanModel.loanmoney.integerValue;
//        long loanB = self.loanModel.tendermoney.integerValue - self.loanModel.loanmoney.integerValue;
//        NSString *balance = [NSString stringWithFormat: @"%ld", self.loanModel == nil ? userLoanB : loanB];
    NSString *balance = @"0.00元";
    NSString *lowestMoney = @"0.00元";
    NSString *profile = [NSString stringWithFormat: @"%@元", self.userLoanModel.overflow_money];
    _statusArr = [NSMutableArray arrayWithObjects: startTime, currentStatus, invitedMoney, balance, lowestMoney, profile, nil];
//    }
    return _statusArr;
}

@end

