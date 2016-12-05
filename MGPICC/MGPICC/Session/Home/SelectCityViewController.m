//
//  SelectCityViewController.m
//  MGPICC
//
//  Created by Unchastity on 11/30/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "SelectCityViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CityFrameModel.h"
#import "MGMacro.h"

#import "MGCityCell.h"
#import "MGInitialCell.h"

@interface SelectCityViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, MGMGInitialCellDelegate, MGCityCellDelegate, UISearchBarDelegate>

/**
 
 */
@property(nonatomic, strong) UITableView        *tableView;

@property(nonatomic, strong) UISearchBar        *searchBar;

@property(nonatomic, strong) UITableView        *searchTableView;

@property(nonatomic, strong) UIButton           *moveToTopBtn;

@property(nonatomic, strong) NSDictionary       *allCityDict;

@property(nonatomic, strong) NSArray            *initialArr;

@property(nonatomic, strong) NSArray            *citiesFrameModelArr;

@property(nonatomic, strong) NSArray            *hotCityArr;

@property(nonatomic, strong) NSMutableArray     *historyCityArr;

@property(nonatomic, strong) CityFrameModel     *historyCityFrameModel;

@property(nonatomic, copy)   NSString           *locationCity;


@end

@implementation SelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"顶部"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setTitle: @"选择城市"];
    
    self.view.backgroundColor = viewControllerBackgroundColor;
    
//    [self addTapges];
    
    [self initView];
    
    _moveToTopBtn.hidden = YES;
    
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

//-(void)addTapges
//{
//    UIGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTopView)];
//    [self.view addGestureRecognizer: tapGes];
//}

-(NSDictionary *)allCityDict
{
    if (!_allCityDict) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"citydict.plist" ofType:nil];
        NSDictionary *cityDict = [NSDictionary dictionaryWithContentsOfFile: path];
        _allCityDict = cityDict;
    }
    return _allCityDict;
}

-(NSArray *)initialArr
{
    if (!_initialArr) {
        _initialArr = [[self.allCityDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return obj2 < obj1;
        }];
    }
    return _initialArr;
}

-(NSArray *)citiesFrameModelArr
{
    if (!_citiesFrameModelArr) {
        NSMutableArray *tmpArr = [NSMutableArray new];
        for (NSString *intial in self.initialArr) {
            NSArray *citiesArr = [self.allCityDict objectForKey: intial];
            CityFrameModel *cityFrameModel = [CityFrameModel cityFrameModelWithArray: citiesArr];
            [tmpArr addObject: cityFrameModel];
        }
        _citiesFrameModelArr = tmpArr;
    }
    return _citiesFrameModelArr;
}

-(NSArray *)hotCityArr
{
    if (!_hotCityArr) {
        _hotCityArr = @[@"北京", @"天津", @"上海", @"重庆", @"成都", @"郑州"];
    }
    return _hotCityArr;
}

-(NSMutableArray *)historyCityArr
{
    if (!_historyCityArr) {
        _historyCityArr = [NSMutableArray arrayWithContentsOfFile: MGSelectedHistoryCityPath];
        if (_historyCityArr == nil) {
            _historyCityArr = [[NSMutableArray alloc] initWithObjects:@"北京", @"天津", @"上海", @"重庆", nil];
        }
        NSArray *arr = [_historyCityArr subarrayWithRange:NSMakeRange(0, 4)];
        _historyCityArr = [NSMutableArray arrayWithArray:arr];
    }
    return _historyCityArr;
}

-(CityFrameModel *)historyCityFrameModel
{
    if (!_historyCityFrameModel) {
        
        _historyCityFrameModel = [CityFrameModel cityFrameModelWithArray: self.historyCityArr];
    }
    return _historyCityFrameModel;
}

-(void)initView
{
//    UITextField *searchText = [[UITextField alloc] init];
//    CGFloat searchX = 10;
//    searchText.frame = CGRectMake( searchX, searchX, SCREEN_WIDTH - searchX * 2, 30);
//    searchText.borderStyle = UITextBorderStyleRoundedRect;
//    searchText.leftViewMode = UITextFieldViewModeAlways;
//    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"search_icon"]];
//    leftImageView.frame = CGRectMake(0, 0, 45, 25);
//    searchText.leftView = leftImageView;
//    searchText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    searchText.placeholder = @"请输入城市的名称/拼音/首字母";
//    [self.view addSubview: searchText];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    CGFloat searchX = 10;
    CGFloat searchY = 10;
    CGFloat searchW = SCREEN_WIDTH - 2 * searchX;
    CGFloat searchH = 40;
    searchBar.frame = CGRectMake(searchX, searchY, searchW, searchH);
    searchBar.placeholder = @"请输入城市的名称/拼音/首字母";
    searchBar.barStyle = UISearchBarStyleDefault;
    //[searchBar setBackgroundImage:[UIImage imageNamed:@"cell_bg"] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
    self.searchBar = searchBar;
    [self.view addSubview: searchBar];
    
    
    CGRect locationCityLabelFrame = CGRectMake(searchX, CGRectGetMaxY(searchBar.frame) + 10, 80, 40);
    UILabel *locationCityLabel = [[UILabel alloc] initWithFrame: locationCityLabelFrame];
    [locationCityLabel setText: @"定位城市:"];
    [self.view addSubview: locationCityLabel];
    UIButton *currentLocationBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    CGFloat currentX = CGRectGetMaxX(locationCityLabel.frame) + 5;
    CGFloat currentY = locationCityLabel.frame.origin.y;
    currentLocationBtn.frame = CGRectMake(currentX, currentY, 200, 40);
    [currentLocationBtn setTitle:@"上海" forState:UIControlStateNormal];
    [currentLocationBtn setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
    currentLocationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview: currentLocationBtn];
    
    CGFloat tableViewY = CGRectGetMaxY(locationCityLabel.frame) + 5;
    CGRect frame = CGRectMake( 0, tableViewY, SCREEN_WIDTH, SCREEN_HEIGHT - tableViewY);
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = viewControllerBackgroundColor;
    tableView.scrollEnabled = YES;
    //tableView.scrollsToTop = YES;
    self.tableView = tableView;
    [self.view addSubview: tableView];
    
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn.frame = CGRectMake(SCREEN_WIDTH - 100,SCREEN_HEIGHT - 200, 80, 80);
    [topBtn setImage:[UIImage imageNamed:@"pa_back_top"] forState:UIControlStateNormal];
    [topBtn addTarget:self action:@selector(clickMoveToTopBtn) forControlEvents:UIControlEventTouchUpInside];
    _moveToTopBtn = topBtn;
    [self.view addSubview: topBtn];
    [self.view bringSubviewToFront: topBtn];
}

-(void)clickMoveToTopBtn
{
    [self.tableView setContentOffset: CGPointMake(0, 0) animated:YES];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.initialArr.count + 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
//注意重用，会导致cell混乱
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            MGCityCell *cell = [MGCityCell cellWithTableView:tableView indexPath:indexPath withCityFrameModel: self.historyCityFrameModel];
            cell.delegate = self;
            return cell;
            break;
        }
        case 1:
        {
            CityFrameModel *hotCity = [CityFrameModel cityFrameModelWithArray: self.hotCityArr];
            MGCityCell *cell = [MGCityCell cellWithTableView:tableView indexPath:indexPath withCityFrameModel: hotCity];
            cell.delegate = self;
            return cell;
            break;
        }
        case 2:
        {
            MGInitialCell *cell = [MGInitialCell cellWithTableView:tableView indexPath:indexPath withArray:self.initialArr];
            cell.delegate = self;
            return cell;
            break;
        }
        default:
        {
            CityFrameModel *citiesModel = self.citiesFrameModelArr[indexPath.section - 3];
            MGCityCell *cell = [MGCityCell cellWithTableView:tableView indexPath:indexPath withCityFrameModel: citiesModel];
            cell.delegate = self;
            return cell;
            break;
        }
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return self.historyCityFrameModel.cellsHeight;
            break;
            
        case 1:
        {
            CityFrameModel *hotCity = [CityFrameModel cityFrameModelWithArray: self.hotCityArr];
            return hotCity.cellsHeight;
            break;
        }
        case 2:
        {
            return 130;
            break;
        }
        default:
        {
            NSInteger section = indexPath.section;
            CityFrameModel *citiesModel = self.citiesFrameModelArr[section - 3];
            //NSLog(@"section= %ld ; initial: %@ ;height= %f", (long)section, self.initialArr[section - 3], citiesModel.cellsHeight);
            return citiesModel.cellsHeight;
            break;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  40;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *titleArr = @[@"历史访问城市", @"热门城市", @"全部城市"];
    NSArray *headerTitleArr = [titleArr arrayByAddingObjectsFromArray: self.initialArr];
    if (section < 3) {
        return [self labelWithTitle:headerTitleArr[section] model:NSTextAlignmentLeft];
    }else
    {
        return [self labelWithTitle:headerTitleArr[section] model:NSTextAlignmentCenter];
    }
}

-(UILabel *)labelWithTitle:(NSString *)title model:(NSTextAlignment) textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [label setText: title];
    label.textAlignment = textAlignment;
    label.backgroundColor = viewControllerBackgroundColor;
    label.textColor = [UIColor blackColor];
    
    return label;
}

#pragma mark - MGMGInitialCellDelegate
-(void)clickInitialBtn:(NSString *)initial
{
    NSLog(@"click initial: %@", initial);
    NSInteger index = [self.initialArr indexOfObject: initial];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index + 3];
    
    //NSIndexPath *fromIndexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    [self.tableView scrollToRowAtIndexPath: indexPath atScrollPosition: UITableViewScrollPositionTop animated: YES];
//    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - MGCityCellDelegate
-(void)selectCity:(NSString *)cityName
{
    NSLog(@"select city: %@", cityName);
    
    if ([self.delegate respondsToSelector:@selector(changeLocation:)]) {
        [self.delegate changeLocation: cityName];
    }
    
    NSUInteger index = [self.historyCityArr indexOfObject:cityName];
    if (index < 4)
    {
        [self.historyCityArr removeObject:cityName];
    }else
    {
        [self.historyCityArr removeLastObject];
    }
    [self.historyCityArr insertObject:cityName atIndex:0];
    [self.historyCityArr writeToFile:MGSelectedHistoryCityPath atomically:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 返回top
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"will begin");
    if (self.tableView.tracking) {
        [self tapTopView];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //[self tapTopView];
    
    _moveToTopBtn.hidden = NO;
}
//减速停止
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"end decelerating");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        _moveToTopBtn.hidden = YES;
    });
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //[self addTapges];
    
    NSLog(@"end dragging");
    //滚动停止时decelerate = NO
    if (!decelerate) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            _moveToTopBtn.hidden = YES;
        });
    }
}

#pragma mark - UISearchBarDelegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = YES;
    //self.navigationController.navigationBar.hidden = YES;
    
    [UIView animateWithDuration:1.0f animations:^{
        
        self.view.transform = CGAffineTransformMakeTranslation(0, -self.navigationController.navigationBar.frame.size.height);
        CGRect customFrame = self.navigationController.navigationBar.frame;
        CGFloat offsetY = -customFrame.size.height;
        self.navigationController.navigationBar.frame = CGRectMake(customFrame.origin.x, offsetY, customFrame.size.width, customFrame.size.height);
    }];
    
    return YES;
}

-(void)tapTopView
{
    self.searchBar.showsCancelButton = NO;
    [self.view endEditing: YES];
    
    [UIView animateWithDuration:1.0f animations:^{
        
        self.view.transform = CGAffineTransformIdentity;
        CGRect customFrame = self.navigationController.navigationBar.frame;
        CGFloat offsetY = [UIApplication sharedApplication].statusBarFrame.size.height;
        self.navigationController.navigationBar.frame = CGRectMake(customFrame.origin.x, offsetY, customFrame.size.width, customFrame.size.height);
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch view");
    [self tapTopView];
}

@end
