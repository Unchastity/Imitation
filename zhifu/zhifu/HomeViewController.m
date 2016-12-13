//
//  FirstViewController.m
//  zhifu
//
//  Created by Unchastity on 12/5/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

/*
 
 1.每次下拉刷新内存都会增加
    1.1 可能是reload时，cell没有重用
        我的cell时nib文件，cell的identifier没有设置，导致没有重用
    1.1->通过修改nib文件cell的identifier，调试发现cell以重用，担内存仍然在增加，不过增加量下降，可能是tableView的headView
    1.2 测试发现，bannerView每次消失在出现时，都会再次重建，并增加内存，增加量前后一致
    1.2->实现bannerView的优化
           1）MGBannerScrollView 继承 UITableViewHeaderFooterView
            重写initWithReuseIdentifier，添加控件，注意次数headerView或footerView的contentView的frame 为0
           2）自定义view，将view添加到系统的headerVIew或footerView上
 
 */

#import "HomeViewController.h"
#import "MGMacro.h"
#import "CreateBarBtnItem.h"

#import "MGDataResultModel.h"
#import "MGBannersModel.h"
#import "MGLoanModel.h"
#import "MGUserLoanModel.h"

#import "MGBannerScrollView.h"
#import "MGWebViewController.h"
#import "MGRegisterViewController.h"
#import "MGLoginViewController.h"
#import "MGBaseNavigationController.h"
#import "MGDetailTableViewController.h"

#import "UserInfoCell.h"
#import "HomeLoanInforCell.h"
#import "HomeUserLoanInforCell.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, MGBannerScrollViewDelegate, UserInfoCellDelegate>
{
    UIActivityIndicatorView *_networkActivityView;
    BOOL _isTop;
}
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@property (nonatomic, strong) MGDataResultModel *dataResultModel;

/**
 标语
 */
@property (nonatomic, strong) NSArray *bannersArr;


/**
 新手加息
 */
@property (nonatomic, strong) MGLoanModel    *loanNewModel;

/**
 投资列表
 */
@property (nonatomic, strong) NSArray *goingLoansArr;

/**
 债券列表
 */
@property (nonatomic, strong) NSArray *userLoansArr;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        
    [self.tabBarItem setTitle: @"首页"];
    [self.tabBarItem setImage: [[UIImage imageNamed: @"tab_home"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]];
    [self.tabBarItem setSelectedImage: [[UIImage imageNamed: @"tab_homehover"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]];
    
    [self initArray];
    
    [self initNaviBar];
    
    [self initTableView];
    
    //启动动画加载刷新
    [UIView animateWithDuration: 2.0 animations:^{
        
        self.homeTableView.transform = CGAffineTransformMakeTranslation(0, 50);
        
        [self sendRequest];
    }];
}

-(void)initArray
{
    _dataResultModel = [[MGDataResultModel alloc] init];
    _loanNewModel = [[MGLoanModel alloc] init];
    _bannersArr = [NSMutableArray new];
    _goingLoansArr = [NSMutableArray new];
    _userLoansArr = [NSMutableArray new];
}

-(void)initNaviBar
{
    UIBarButtonItem *rightBtn = [CreateBarBtnItem createBarBtnItemWithTitle: @"登录"
                                                                      image: @""
                                                                      frame: CGRectMake(0, 0, 50, 25)
                                                            titleEdgeInsets: UIEdgeInsetsZero
                                                            imageEdgeInsets: UIEdgeInsetsZero
                                                                     Target: self
                                                                     select: @selector(loginNow)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
}

-(void)loginNow
{
    MGLoginViewController *loginVC = [MGLoginViewController getViewController];
    MGBaseNavigationController *navi = [[MGBaseNavigationController alloc] initWithRootViewController: loginVC];
    [self presentViewController: navi animated: YES completion:nil];
    
    
}


-(void)initTableView {
    
    _networkActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    _networkActivityView.frame = CGRectMake( 0, 0, 30, 30);
    _networkActivityView.center = self.view.center;
    _networkActivityView.hidesWhenStopped = YES;
    [self.view addSubview: _networkActivityView];
    [self.view bringSubviewToFront: _networkActivityView];
    
    CGRect tableViewFrame = CGRectMake(0, NavigationBarY, SCREEN_WIDTH, SCREEN_HEIGHT);
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    self.homeTableView = tableView;
    [self.view addSubview: tableView];
    
}

-(void)sendRequest
{
    [_networkActivityView startAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
    
    NSString *urlStr = @"http://service.zhifubank.com/";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlStr] cachePolicy: 0 timeoutInterval:5.0];
    [request setHTTPMethod: @"POST"];
    
//    NSString *deviceHeight = [NSString stringWithFormat:@"device_height=%0.1f", SCREEN_HEIGHT];
//    NSString *deviceUUID = [NSString stringWithFormat:@"_deviceid_=%@", [[UIDevice currentDevice] identifierForVendor].UUIDString];
//    NSString *deviceSysVer =[NSString stringWithFormat:@"20%@", [[UIDevice currentDevice] systemVersion]];
//    NSString *deviceType = [NSString stringWithFormat:@"device_os=%@%%", [[UIDevice currentDevice] systemName]];
//    NSString *deviceWidth = [NSString stringWithFormat:@"device_width=%0.1f", SCREEN_WIDTH];
//    NSString *deviceOS = [deviceType stringByAppendingString: deviceSysVer];
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
            {
                NSMutableArray *tmpBannersArr = [NSMutableArray new];
                for (NSDictionary *bannerDict in self.dataResultModel.banners) {
                    MGBannersModel *bannerModel = [MGBannersModel modelWithDict: bannerDict];
                    [tmpBannersArr addObject: bannerModel];
                }
                self.bannersArr = [NSArray arrayWithArray: tmpBannersArr];
            }
            //新手加息
            self.loanNewModel = [MGLoanModel modelWithDict: self.dataResultModel.newloan];
            
            {
                NSMutableArray *tmpGoingArr = [NSMutableArray new];
                for (NSDictionary *dict in self.dataResultModel.going_loan) {
                    MGLoanModel *loanModel = [MGLoanModel modelWithDict: dict];
                    [tmpGoingArr addObject: loanModel];
                }
                self.goingLoansArr = [NSArray arrayWithArray: tmpGoingArr];
            }
            {
                NSMutableArray *tmpUserLoanArr = [NSMutableArray new];
                for (NSDictionary *dict in self.dataResultModel.user_loan) {
                    MGUserLoanModel *userLoanModel = [MGUserLoanModel modelWithDict: dict];
                    [tmpUserLoanArr addObject: userLoanModel];
                }
                self.userLoansArr = [NSMutableArray arrayWithArray: tmpUserLoanArr];
            }
            
            [_networkActivityView stopAnimating];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
            
            [self.homeTableView reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration: 2.0 animations:^{
                    self.homeTableView.transform = CGAffineTransformIdentity;
                }];
            });
        }else
        {
            
        }
    }];
    [task resume];
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
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }else if (section == 1)
    {
        if (self.dataResultModel.newloan == nil)
        {
            return self.goingLoansArr.count;
        }else
        {
            return 1 + self.goingLoansArr.count;
        }
    }else
    {
        return self.userLoansArr.count;
    }
}
//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        NSString *totalLend = [self.dataResultModel valueForKeyPath: @"total_lend"];
        UserInfoCell *cell = [UserInfoCell cellForTableView:tableView withTotalLend: totalLend];
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 1)
    {
        static NSString *loanCellID = @"loanCellID";
        HomeLoanInforCell *cell = (HomeLoanInforCell *)[HomeLoanInforCell cellForTableView: tableView reuseIdentifier: loanCellID];
        if (self.dataResultModel.newloan != nil && indexPath.row == 0) {
            [cell setLoanModel: self.loanNewModel];
        }else
        {
            [cell setLoanModel: self.goingLoansArr[indexPath.row - 1]];
        }
        return cell;
    }else
    {
        static NSString *userLoanCellID = @"loanCellID";
        HomeUserLoanInforCell *cell = (HomeUserLoanInforCell *)[HomeUserLoanInforCell cellForTableView: tableView reuseIdentifier: userLoanCellID];
        cell.userLoanModel = self.userLoansArr[indexPath.row];
        return cell;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return @"投资列表";
    }else if (section == 2)
    {
        return @"债权列表";
    }else{
        return nil;
    }
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==1)
    {
        NSLog(@"select section= %ld, row= %ld",(long)indexPath.section, (long)indexPath.row);
        MGDetailTableViewController *detailVC = [MGDetailTableViewController viewControllerFromStoryboard];
        if (self.loanNewModel != nil) {
            if (indexPath.row == 0) {
                detailVC.loanModel = self.loanNewModel;
            }else {
                detailVC.loanModel = self.goingLoansArr[indexPath.row - 1];
            }
        }else
        {
            detailVC.loanModel = self.goingLoansArr[indexPath.row];
        }
        detailVC.isLoanSection = YES;
        [self.navigationController pushViewController: detailVC animated:YES];
    }else if (indexPath.section == 2)
    {
        NSLog(@"select section= %ld, row= %ld",(long)indexPath.section, (long)indexPath.row);
        MGDetailTableViewController *detailVC = [MGDetailTableViewController viewControllerFromStoryboard];
        detailVC.userLoanModel = self.userLoansArr[indexPath.row];
        detailVC.isLoanSection = NO;
        [self.navigationController pushViewController: detailVC animated:YES];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    /*
    static NSString *bannerViewID = @"bannerViewID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier: bannerViewID];
    if (!headerView) {
        
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier: bannerViewID];
        if (section == 0) {
            CGFloat imageViewH = SCREEN_WIDTH * 7 / 15;
            CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, imageViewH);
            MGBannerScrollView * bannerView = [[MGBannerScrollView alloc] initWithFrame: frame withBannersArr: self.bannersArr];
            [bannerView setBannersArr: self.bannersArr];
            bannerView.delegate = self;
            
            [headerView addSubview: bannerView];
            [headerView bringSubviewToFront: bannerView];
        }
    }
    return headerView;
     */
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
    return 101;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return SCREEN_WIDTH * 7 / 15;;
    }else
    {
        return 15.0;
    }
}

#pragma mark - UserInfoCellDelegate
-(void)clickRegisterNowBtn
{
    NSLog(@"clickRegisterNowBtn");
    MGRegisterViewController *registerVC = [MGRegisterViewController registerViewControllerFromStoryboard];
    [self.navigationController pushViewController: registerVC animated:YES];
}

#pragma mark - refresh
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    CGPoint offset = self.homeTableView.contentOffset;
    if (offset.x == 0 && offset.y == 0) {
        _isTop = YES;
    }else {
        _isTop = NO;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //下拉刷新，下拉大与50时刷新
    CGPoint offset = self.homeTableView.contentOffset;
    if (_isTop && offset.y < -50.0) {
        [self sendRequest];
        _isTop = NO;
    }
}

@end
