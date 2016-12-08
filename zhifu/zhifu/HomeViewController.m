//
//  FirstViewController.m
//  zhifu
//
//  Created by Unchastity on 12/5/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "HomeViewController.h"
#import "MGMacro.h"
#import "MGDataResultModel.h"
#import "MGBannersModel.h"
#import "MGLoanModel.h"
#import "MGUserLoanModel.h"

#import "MGBannerScrollView.h"
#import "MGWebViewController.h"
#import "UserInfoCell.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, MGBannerScrollViewDelegate, UserInfoCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@property (nonatomic, strong) MGDataResultModel *dataResultModel;

/**
 标语
 */
@property (nonatomic, strong) NSMutableArray *bannersArr;


/**
 新手加息
 */
@property (nonatomic, strong) MGLoanModel    *loanNewModel;

/**
 投资列表
 */
@property (nonatomic, strong) NSMutableArray *goingLoansArr;

/**
 债券列表
 */
@property (nonatomic, strong) NSMutableArray *userLoansArr;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        
    [self.tabBarItem setTitle: @"首页"];
    [self.tabBarItem setImage: [[UIImage imageNamed: @"tab_home"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]];
    [self.tabBarItem setSelectedImage: [[UIImage imageNamed: @"tab_homehover"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]];
    
    [self initArray];
    
    [self initTableView];
    
    [self sendRequest];
}

-(void)initArray
{
    _dataResultModel = [[MGDataResultModel alloc] init];
    _loanNewModel = [[MGLoanModel alloc] init];
    _bannersArr = [NSMutableArray new];
    _goingLoansArr = [NSMutableArray new];
    _userLoansArr = [NSMutableArray new];
}

-(void)sendRequest
{
    NSString *urlStr = @"http://service.zhifubank.com/";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlStr]];
    [request setHTTPMethod: @"POST"];
    
    NSString *deviceHeight = [NSString stringWithFormat:@"device_height=%0.1f", SCREEN_HEIGHT];
    NSString *deviceUUID = [NSString stringWithFormat:@"_deviceid_=%@", [[UIDevice currentDevice] identifierForVendor].UUIDString];
    NSString *deviceSysVer =[NSString stringWithFormat:@"20%@", [[UIDevice currentDevice] systemVersion]];
    NSString *deviceType = [NSString stringWithFormat:@"device_os=%@%%", [[UIDevice currentDevice] systemName]];
    NSString *deviceWidth = [NSString stringWithFormat:@"device_width=%0.1f", SCREEN_WIDTH];
    NSString *deviceOS = [deviceType stringByAppendingString: deviceSysVer];
    NSString *bodyStr = [NSString stringWithFormat:@"_client_=IOS&_cmd_=init&%@&_sign_=51ed374edd68818a377328e2dddca0c4&_token_=&%@&%@&%@&version=2.4.5", deviceUUID, deviceHeight, deviceOS, deviceWidth];
    NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody: bodyData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *dataResultDict = dict[@"dataresult"];
            MGDataResultModel *dataResultModel = [MGDataResultModel modelWithDict: dataResultDict];
            self.dataResultModel = dataResultModel;
            
            for (NSDictionary *bannerDict in self.dataResultModel.banners) {
                MGBannersModel *bannerModel = [MGBannersModel modelWithDict: bannerDict];
                [self.bannersArr addObject: bannerModel];
            }
            //新手加息
            self.loanNewModel = [MGLoanModel modelWithDict: self.dataResultModel.newloan];
            
            for (NSDictionary *dict in self.dataResultModel.going_loan) {
                MGLoanModel *loanModel = [MGLoanModel modelWithDict: dict];
                [self.goingLoansArr addObject: loanModel];
            }
            
            for (NSDictionary *dict in self.dataResultModel.user_loan) {
                MGUserLoanModel *userLoanModel = [MGUserLoanModel modelWithDict: dict];
                [self.userLoansArr addObject: userLoanModel];
            }
            
            [self.homeTableView reloadData];
        }else
        {
            
        }
    }];
    [task resume];
}

-(void)initTableView {
    
    CGRect tableViewFrame = CGRectMake(0, NavigationBarY, SCREEN_WIDTH, SCREEN_HEIGHT);
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    self.homeTableView = tableView;
    [self.view addSubview: tableView];
    
}

#pragma mark - MGBannerScrollViewDelegate
-(void)clickBannerWithBannerModel:(MGBannersModel *)bannerModel
{
    NSLog(@"bannerModel title = %@", bannerModel.title);
    MGWebViewController *webVC = [[MGWebViewController alloc] init];
    webVC.bannersModel = bannerModel;
    [self.navigationController pushViewController: webVC animated: YES];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        NSString *totalLend = [self.dataResultModel valueForKeyPath: @"total_lend"];
        UserInfoCell *cell = [UserInfoCell cellForTableView:tableView withTotalLend: totalLend];
        cell.delegate = self;
        return cell;
    }else
    {
        return nil;

    }
}

#pragma mark - UITableViewDelegate

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        CGFloat imageViewH = SCREEN_WIDTH * 7 / 15;
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, imageViewH);
        MGBannerScrollView * bannerView = [[MGBannerScrollView alloc] initWithFrame: frame withBannersArr: self.bannersArr];
        [bannerView setBannersArr: self.bannersArr];
        bannerView.delegate = self;
        return bannerView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SCREEN_WIDTH * 7 / 15;;
}

#pragma mark - UserInfoCellDelegate
-(void)clickRegisterNowBtn
{
    NSLog(@"clickRegisterNowBtn");
}

@end
