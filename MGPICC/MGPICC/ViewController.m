//
//  ViewController.m
//  MGPICC
//
//  Created by Unchastity on 11/29/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Color.h"
#import "MGMacro.h"
#import "SelectCityViewController.h"
#import "ProductCenterViewController.h"

#import "MGScrollImageView.h"
#import "MGWeatherView.h"
#import "MGHomeMenuView.h"
#import "HotProductionHeader.h"
#import "HotProductionView.h"

#import "MenuModel.h"

@interface ViewController ()<MGScrollImageViewDelegate, HotProductionHeaderDelegate, MGHomeMenuViewDelegate, HotProductionViewDelegate>

@property(nonatomic, strong) UIScrollView *contentScrollView;

@property(nonatomic, strong) NSString *loccation;

@property(nonatomic, strong) NSArray *scrollImageArr;

@property(nonatomic, strong) NSArray *homeMenuArr;

@property(nonatomic, strong) NSArray *hotArr;
@end

@implementation ViewController

-(NSString *)loccation
{
    if (!_loccation) {
        _loccation = @"上海";
    }
    return _loccation;
}

-(NSArray *)scrollImageArr {
    
    if (!_scrollImageArr) {
        
    }
    return  _scrollImageArr;
}

-(NSArray *)homeMenuArr {
    if (!_homeMenuArr) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"homeMenu.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile: path];
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:8];
        for (NSInteger i = 0; i < arr.count; ++i) {
            MenuModel *menuMode = [MenuModel menuModelWithDict: arr[i]];
            [tmpArr addObject: menuMode];
        }
        _homeMenuArr = tmpArr;
    }
    return _homeMenuArr;
}

-(NSArray *)hotArr
{
    if (!_hotArr) {
        _hotArr = @[@"home_xionghaizi", @"home_quanqiuyou", @"home_zijiayou",@"home_gerenzijin"];
    }
    return _hotArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    //设置navigationBar的背景色
    [self settingNavigationBarBackgroundColor];
    
    [self settingNaviItem];
    
    [self settingContentScrollView];

}

-(void)viewWillAppear:(BOOL)animated {
    
}

-(void)settingNavigationBarBackgroundColor
{
//    //获取status的frame
//    CGRect statusFrame = [[UIApplication sharedApplication] statusBarFrame];
//    NSLog(@"statusFrame = %@", NSStringFromCGRect(statusFrame));
//    //获取navigationBar的frame
//    CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
//    NSLog(@"navigationBarFrame = %@", NSStringFromCGRect(navigationBarFrame));
//    CGSize size = CGSizeMake(navigationBarFrame.size.width, navigationBarFrame.size.height + statusFrame.size.height);
//    //p2: 横屏/竖屏
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor: navigationBarBackgroundColor withSize: size] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"顶部"] forBarMetrics:UIBarMetricsDefault];
}

-(void)settingNaviItem
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 50, 35);
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn setTitle:self.loccation forState:UIControlStateNormal];
    //location
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 40);
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, -40);
    [leftBtn setImage:[[UIImage imageNamed:@"center_city"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    [leftBtn setBackgroundImage:[[UIImage imageNamed:@"buttonBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtn addTarget:self action:@selector(pushToSelectCityContoller) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.adjustsImageWhenHighlighted = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    //self.navigationItem.titleView
    UIImage *image = [UIImage imageNamed:@"PICC白"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    //[titleImageView setImage: [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [titleImageView setImage: image];
    self.navigationItem.titleView = titleImageView;
}

-(void)pushToSelectCityContoller
{
    SelectCityViewController *selectCityVC = [[SelectCityViewController alloc] init];
    [self.navigationController pushViewController:selectCityVC animated:YES];
}

-(void)settingContentScrollView
{
    self.contentScrollView = [[UIScrollView alloc] init];
    //CGFloat contentScrollViewX = 0;
    //CGFloat contentScrollViewY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat contentScrollViewW = SCREEN_WIDTH;
    CGFloat tabBarH = self.tabBarController.tabBar.frame.size.height;
    CGFloat contentScrollViewH = SCREEN_HEIGHT - tabBarH; // - contentScrollViewY;
    self.contentScrollView.frame = CGRectMake(0, 0, contentScrollViewW, contentScrollViewH);
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    self.contentScrollView.showsVerticalScrollIndicator = YES;
    self.contentScrollView.backgroundColor = viewControllerBackgroundColor;
    
    [self.view addSubview: self.contentScrollView];
    
    [self settingScrollImageSession];
}

-(void)settingScrollImageSession
{
    CGFloat superViewWidth = self.contentScrollView.frame.size.width;
    
    CGFloat scrollImageX = 0;
    CGFloat scrollImageY = 0;
    CGFloat scrollImageW = superViewWidth;
    CGFloat scrollImageH = 160.0;
    CGRect scrollImageFrame = CGRectMake(scrollImageX, scrollImageY, scrollImageW, scrollImageH);
    MGScrollImageView *scrollImageView = [[MGScrollImageView alloc] initWithFrame:scrollImageFrame imageArray:self.scrollImageArr];
    scrollImageView.delegate = self;
    [self.contentScrollView addSubview: scrollImageView];
    
    CGFloat weatherViewX = 0;
    CGFloat weatherViewY = CGRectGetMaxY(scrollImageView.frame);
    CGFloat weatherViewW = superViewWidth;
    CGFloat weatherViewH = 40;
    CGRect weatherViewFrame = CGRectMake(weatherViewX, weatherViewY, weatherViewW, weatherViewH);
    NSLog(@"weather view frame: %@", NSStringFromCGRect(weatherViewFrame));
    MGWeatherView *weatherView = [[MGWeatherView alloc] initWeatherViewWithFrame:weatherViewFrame weather:@""];
    [self.contentScrollView addSubview: weatherView];
    
    CGFloat menuViewW = superViewWidth;
    CGFloat menuViewH = 190;
    CGFloat menuViewX = 0;
    CGFloat menuViewY = CGRectGetMaxY(weatherView.frame) + 1;
    CGRect  menuViewFrame = CGRectMake(menuViewX, menuViewY, menuViewW, menuViewH);
    NSLog(@"menuViewFrame: %@", NSStringFromCGRect(menuViewFrame));
    MGHomeMenuView *homeMenuView = [[MGHomeMenuView alloc] initWithFrame:menuViewFrame];
    homeMenuView.delegate = self;
    homeMenuView.menuArr = self.homeMenuArr;
    [self.contentScrollView addSubview: homeMenuView];
    
    CGFloat hotHeaderX = 0;
    CGFloat hotHeaderY = CGRectGetMaxY(homeMenuView.frame) + 10;
    CGFloat hotHeaderW = superViewWidth;
    CGFloat hotHeaderH = 40;
    HotProductionHeader *hotHeaderView = [[HotProductionHeader alloc] initWithFrame:CGRectMake(hotHeaderX, hotHeaderY, hotHeaderW, hotHeaderH)];
    hotHeaderView.delegate = self;
    [self.contentScrollView addSubview: hotHeaderView];
    //NSLog(@"hot production frame: %@", NSStringFromCGRect(hotView.frame));
    
    CGFloat hotX = 0;
    CGFloat hotY = CGRectGetMaxY(hotHeaderView.frame) + 0.5;
    CGFloat hotW = superViewWidth;
    CGFloat hotH = 181;
    CGRect hotViewFrame = CGRectMake(hotX, hotY, hotW, hotH);
    HotProductionView *hotView = [[HotProductionView alloc] initWithFrame:hotViewFrame];
    hotView.hotArr = self.hotArr;
    hotView.delegate = self;
    [self.contentScrollView addSubview: hotView];
}



#pragma mark - MGScrollImageViewDelegate
-(void)clickScrollImageWithTag:(long)tag {
    
    
}

#pragma mark - MGHomeMenuViewDelegate
-(void)homeMenuClickedWithTag:(long)tag
{
    NSLog(@"home menu click tag: %ld", tag);
    MenuModel *menuMode = self.homeMenuArr[tag - 150];
    NSString *clickMessage = [NSString stringWithFormat:@"点击了'%@'", menuMode.name];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:clickMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction: okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - HotProductionHeaderDelegate
-(void)hotProductionclickedMoreBtn
{
    ProductCenterViewController *productCenterVC = [[ProductCenterViewController alloc] init];
    [self.navigationController pushViewController:productCenterVC animated:YES];
}

#pragma mark - HotProductionViewDelegate
-(void)clickHotProductionViewWithTag:(long)tag
{
    
}

@end
