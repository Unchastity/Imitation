//
//  MoreViewController.m
//  zhifu
//
//  Created by Unchastity on 12/5/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MoreViewController.h"
#import "CommonUseCell.h"

/*
 tableView的wrapperView的height小于tableView，
 在navigationController下，tableview的y值为0，tableView的第一个cell才能置顶
 
 */

@interface MoreViewController ()<UITableViewDelegate, UITableViewDataSource, CommonUseCellDelegate>
{
    NSArray *_titleArr;
    NSArray *_titleImageArr;
}

@property (weak, nonatomic) IBOutlet UITableView *moreTableView;


@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBarItem setTitle: @"更多"];
    [self.tabBarItem setImage: [[UIImage imageNamed: @"tab_more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.tabBarItem setSelectedImage: [[UIImage imageNamed: @"tab_morehover"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]];
    
    [self.navigationItem setTitle: @"更多内容"];
    
//    self.view.backgroundColor = [UIColor grayColor];
    [self initData];
    
    [self initView];
}

-(void)initData
{
    _titleArr = @[@"关于智富360", @"常见问题", @"当前版本", @"意见反馈", @"客服热线", @"我的二维码", @"设置"];
    _titleImageArr = @[@"icon-more-info", @"icon-more-question", @"icon-more-info", @"icon-more-feedback", @"icon-more-custom-phone", @"icon_dimension", @"icon-more-set"];
}

-(void)initView
{
    self.moreTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  8;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *commonID = @"CommonUseCell";
        CommonUseCell *cell = [CommonUseCell cellForMoreTableView: tableView reuseIdentifier: commonID];
        cell.delegate = self;
        return cell;
    }else
    {
        static NSString *moreID = @"moreID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: moreID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1
                                          reuseIdentifier: moreID];
        }
        //避免cell重用 UITableViewCellSelectionStyleNone
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        if (indexPath.section == 3) {
            UILabel *serviceTelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
            [serviceTelLabel setText: @"2.4.5"];
            serviceTelLabel.textAlignment = NSTextAlignmentRight;
            /*
            accessoryView的frame的width和heigh有效，x和y无效，当heigh大与cell得height时，accessory以cell的height为标准，右边届固定，width变化引起accessory的x变化
            */
            cell.accessoryView = serviceTelLabel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.section == 5)
        {
            [cell.detailTextLabel setText: @"400-86-360-86"];
            [cell.detailTextLabel setTextColor: [UIColor blueColor]];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [cell.textLabel setText: _titleArr[indexPath.section - 1]];
        [cell.imageView setImage: [UIImage imageNamed: _titleImageArr[indexPath.section - 1]]];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 106.9;
    }else {
        return 40.0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog( @"select %ld", indexPath.section);
    switch (indexPath.section) {
        case 1:
            
            break;
        case 2:
            
            break;
        case 4:
            
            break;
            
        case 5:
            
            break;
            
        case 6:
            break;
        
        case 7:
            
            break;
        default:
            break;
    }
}

#pragma mark - CommonUseCellDelegate
-(void)clickCommonUseBtnWithTag:(long)tag
{
    NSLog(@"click Common Use Btn With Tag=%ld", tag);
    
    
}

@end
