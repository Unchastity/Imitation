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

@interface SelectCityViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 
 */
@property(nonatomic, strong) UITableView        *tableView;

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
    
    [self initView];
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

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
    
    UITextField *searchText = [[UITextField alloc] init];
    CGFloat searchX = 10;
    searchText.frame = CGRectMake( searchX, searchX, SCREEN_WIDTH - searchX * 2, 30);
    searchText.borderStyle = UITextBorderStyleRoundedRect;
    searchText.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"search_icon"]];
    leftImageView.frame = CGRectMake(0, 0, 40, 25);
    searchText.leftView = leftImageView;
    searchText.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchText.placeholder = @"请输入城市的名称/拼音/首字母";
    [self.view addSubview: searchText];
    
    CGRect locationCityLabelFrame = CGRectMake(searchX, CGRectGetMaxY(searchText.frame) + 10, 80, 40);
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
    [self.view addSubview: tableView];
    
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            MGCityCell *cell = [MGCityCell cellWithTableView:tableView withCityFrameModel: self.historyCityFrameModel];
            return cell;
            break;
        }
        case 1:
        {
            CityFrameModel *hotCity = [CityFrameModel cityFrameModelWithArray: self.hotCityArr];
            MGCityCell *cell = [MGCityCell cellWithTableView:tableView withCityFrameModel: hotCity];
            return cell;
            break;
        }
        case 2:
        {
            return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
            break;
        }
        default:
        {
            CityFrameModel *citiesModel = self.citiesFrameModelArr[indexPath.section - 3];
            MGCityCell *cell = [MGCityCell cellWithTableView:tableView withCityFrameModel: citiesModel];
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
            return 0;
            break;
        }
        default:
        {
            NSInteger section = indexPath.section;
            CityFrameModel *citiesModel = self.citiesFrameModelArr[section - 3];
            NSLog(@"section= %ld ; initial: %@ ;height= %f", (long)section, self.initialArr[section - 3], citiesModel.cellsHeight);
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

@end
