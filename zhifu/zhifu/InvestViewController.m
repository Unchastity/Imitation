//
//  SecondViewController.m
//  zhifu
//
//  Created by Unchastity on 12/5/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "InvestViewController.h"
#import "MGMacro.h"
#import "UIAlertController+CreateAlertControllerQuickly.h"
#import "MGInviteLoanModel.h"
#import "MGInviteUserLoanModel.h"

#import "LoanInforCell+InviteCell.h"


typedef void(^requestBlock)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);

@interface InvestViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIButton *_selectedFstBtn;
    UIButton *_selectedSndBtn;
    UIView   *_shadowView;
    
    NSMutableArray *_loanArr;
    NSArray *_cateIDArr;
    NSArray *_yearRateArr;
    NSArray *_loanMonthArr;
    
    long _pageNo;
    long _cateid;
    long _yearrate;
    long _loanmonth;
    NSString *_cmdStr;
}

@property (weak, nonatomic) IBOutlet UIView *customContentView;

//first stage
@property (weak, nonatomic) IBOutlet UIView *inviteListContentView;

@property (weak, nonatomic) IBOutlet UIButton *inviteListBtn;

@property (weak, nonatomic) IBOutlet UIView *loanContentView;

@property (weak, nonatomic) IBOutlet UIButton *loanTransferBtn;

//second stage
@property (weak, nonatomic) IBOutlet UIButton *standardClassBtn;

@property (weak, nonatomic) IBOutlet UIButton *yearRateClassBtn;

@property (weak, nonatomic) IBOutlet UIButton *latestTimeBtn;

@property (weak, nonatomic) IBOutlet UITableView *hostTableView;

@property (strong, nonatomic) UITableView *taskTableView;

@property (nonatomic, strong) requestBlock conditionBlock;
@property (nonatomic, strong) requestBlock loanBlock;
@property (nonatomic, strong) requestBlock userLoanBlock;

@end

@implementation InvestViewController

-(requestBlock)conditionBlock
{
    return ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData: data options: 0 error: nil];
            if ([dict[@"errormsg"] isEqualToString: @""]) {
                NSDictionary *dataResultDict = dict[@"dataresult"];
                if (dataResultDict[@"data"] != nil) {
                    NSDictionary *dataDict = dataResultDict[@"data"];
                    _cateIDArr = dataDict[@"cateid"];
                    _yearRateArr = dataDict[@"yearrate"];
                    _loanMonthArr = dataDict[@"loanmonth"];
                }
                //[self.taskTableView reloadData];
            }
        }
    };
}

-(requestBlock)userLoanBlock
{
    return ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData: data options: 0 error: nil];
            if ([dict[@"errormsg"] isEqualToString: @""]) {
                NSDictionary *dataResultDict = dict[@"dataresult"];
                if (dataResultDict[@"loan_data"]) {
                    NSString *pageno = dataResultDict[@"page_no"];
                    NSArray *loanDataArr = dataResultDict[@"loan_data"];
                    for (NSDictionary *modelDict in loanDataArr) {
                        MGInviteUserLoanModel *userLoanModel = [MGInviteUserLoanModel modelWithDict: modelDict];
                        [_loanArr addObject: userLoanModel];
                    }
                    _pageNo = pageno.longLongValue;
                }
            }else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"提示" message: dict[@"errormsg"] preferredStyle: UIAlertControllerStyleAlert];
                UIAlertAction *okaction = [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.hostTableView reloadData];
                    });
                }];
                [alert addAction: okaction];
                [self presentViewController: alert animated: YES completion:^{
                    
                }];
            }
            //主线程更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.hostTableView reloadData];
            });
        }
    };
}

-(requestBlock)loanBlock
{
    return ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData: data options: 0 error: nil];
            if ([dict[@"errormsg"] isEqualToString: @""]) {
                NSDictionary *dataResultDict = dict[@"dataresult"];
                if (dataResultDict[@"loan_data"]) {
                    NSString *pageno = dataResultDict[@"page_no"];
                    NSArray *loanDataArr = dataResultDict[@"loan_data"];
                    for (NSDictionary *modelDict in loanDataArr) {
                        MGInviteLoanModel *loanModel = [MGInviteLoanModel modelWithDict: modelDict];
                        [_loanArr addObject: loanModel];
                    }
                    _pageNo = pageno.longLongValue;
                }
            }else
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"提示" message: dict[@"errormsg"] preferredStyle: UIAlertControllerStyleAlert];
                UIAlertAction *okaction = [UIAlertAction actionWithTitle: @"确认" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self.hostTableView reloadData];
//                    });
                }];
                [alert addAction: okaction];
                [self presentViewController: alert animated: YES completion:^{
                }];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.hostTableView reloadData];
            });
        }
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//
    [self.tabBarItem setTitle: @"投资"];
    [self.tabBarItem setImage: [[UIImage imageNamed: @"tab_touzi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.tabBarItem setSelectedImage: [[UIImage imageNamed: @"tab_touzihover"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]];
    [self settingNavigationBar];
    
    [self initSetting];
    
    [self initData];
    
//    [self sendRequestWithBody: [self conditionRequestBody] requestBlock: self.conditionBlock];
    [self selectInviteType: _selectedFstBtn];

//    [self sendRequestWithBody: [self detailDataRequestBody] requestBlock: self.loanBlock];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat shadowX = 0;
    CGFloat shadowY = CGRectGetMaxY(self.customContentView.frame);
    CGFloat shadowW = self.view.bounds.size.width;
    CGFloat shadowH = self.view.bounds.size.height - shadowY - self.tabBarController.tabBar.frame.size.height;
    CGRect  shadowFrame = CGRectMake(shadowX, shadowY, shadowW, shadowH);
    _shadowView.frame = shadowFrame;
    
    CGRect taskFrame = CGRectMake(0, 0, CGRectGetWidth(_shadowView.frame), CGRectGetHeight(_shadowView.frame));
    self.taskTableView.frame = taskFrame;
}

-(void)settingNavigationBar
{
    [self.navigationItem setTitle: @"投资"];
//icon-pc-s-name
    UIButton *rightBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn setImage: [[UIImage imageNamed: @"icon-pc-s-name"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: rightBtn];
}

-(void)initData
{
    _cateid     = 0;
    _yearrate   = 0;
    _loanmonth  = 0;
    _pageNo     = 1;
    _cmdStr     = @"loan_index";
    
    _loanArr      = [NSMutableArray new];
    _cateIDArr    = [NSArray new];
    _yearRateArr  = [NSArray new];
    _loanMonthArr = [NSArray new];
    
    //default setting
    _selectedFstBtn = self.inviteListBtn;
    _selectedSndBtn = nil;

}

-(void)initSetting
{
    _shadowView = [[UIView alloc] init];
    _shadowView.backgroundColor = [UIColor blackColor];
    _shadowView.alpha = 0.4;
    _shadowView.hidden = YES;
    [self.view addSubview: _shadowView];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(touchShadowView)];
    [_shadowView addGestureRecognizer: ges];
    
//    CGRect taskFrame = CGRectMake(0, 0, CGRectGetWidth(_shadowView.frame), CGRectGetHeight(_shadowView.frame));
//    self.taskTableView = [[UITableView alloc] initWithFrame: taskFrame style: UITableViewStylePlain];
//    self.taskTableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
//    self.taskTableView.backgroundColor = [UIColor whiteColor];
//    [_shadowView addSubview: self.taskTableView];
}

-(void)touchShadowView
{
    NSLog(@"click shadow view");
    [_shadowView setHidden: YES];
    _selectedSndBtn.selected = NO;
    _selectedSndBtn = nil;
}

- (IBAction)selectInviteType:(UIButton *)sender
{
    // UI 变化
    UIView *slectedContentView = [_selectedFstBtn superview];
    [slectedContentView setBackgroundColor: [UIColor whiteColor]];

    _selectedFstBtn.selected = NO;
    _selectedFstBtn = sender;
    _selectedFstBtn.selected = YES;
    
    UIView *contentView = [_selectedFstBtn superview];
    [contentView setBackgroundColor: [UIColor redColor]];
    
    // 数据
    _cmdStr = _selectedFstBtn == self.inviteListBtn ? @"loan_index" : @"user_loan_list";
    _cateid     = 0;
    _yearrate   = 0;
    _loanmonth  = 0;
    _pageNo     = 1;
    
    [_loanArr removeAllObjects];
    [self sendRequestWithBody: [self conditionRequestBody] requestBlock: self.conditionBlock];
    if ([_cmdStr isEqualToString: @"loan_index"])
    {
        [self sendRequestWithBody: [self detailDataRequestBody] requestBlock: self.loanBlock];
    } else
    {
        [self sendRequestWithBody: [self detailDataRequestBody] requestBlock: self.userLoanBlock];
    }
}

- (IBAction)selectClassType:(UIButton *)sender
{
    if (_selectedSndBtn == sender) {
        _selectedSndBtn.selected = NO;
        _selectedSndBtn = nil;
        [_shadowView setHidden: YES];

    }else {
        _selectedSndBtn.selected = NO;
        _selectedSndBtn = sender;
        _selectedSndBtn.selected = YES;
        [_shadowView setHidden: NO];
    }
    [self.taskTableView reloadData];
}

-(void)sendRequestWithBody:(NSString *)bodyStr requestBlock:(requestBlock) block
{
    NSString *urlStr = @"http://service.zhifubank.com/";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: urlStr]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [bodyStr dataUsingEncoding: NSUTF8StringEncoding]];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler: block];
    [task resume];
}

-(NSString *)detailDataRequestBody
{
    return [NSString stringWithFormat: @" _client_=IOS&_cmd_=%@&%@&_sign_=ba97990746e684f9770515b83830f79d&cateid=%ld&loanmonth=%ld&p=%ld&page_num=20&yearrate=%ld", _cmdStr, deviceUUID, _cateid, _loanmonth, _pageNo, _yearrate];
}

-(NSString *)conditionRequestBody
{
    return [NSString stringWithFormat: @"_client_=IOS&_cmd_=%@&_deviceid_=3FA87349-A015-441D-8023-B98B5CEAF206&_sign_=ba97990746e684f9770515b83830f79d&type=condition", _cmdStr];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"_loanArr.count= %lu", (unsigned long)_loanArr.count);
    return _loanArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *loanCellID = @"loanCellID";
    LoanInforCell *cell = [LoanInforCell cellForTableView: tableView reuseIdentifier: loanCellID];

    if ([_cmdStr isEqualToString: @"loan_index"])
    {
        MGInviteLoanModel *loanModel = _loanArr.count != 0 ? _loanArr[indexPath.row] : nil;
        [cell setLoanModel: loanModel];
        return cell;
    }else
    {
        MGInviteUserLoanModel *userLoanModel = _loanArr.count != 0 ? _loanArr[indexPath.row] : nil;
        [cell setUserLoanModel: userLoanModel];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
