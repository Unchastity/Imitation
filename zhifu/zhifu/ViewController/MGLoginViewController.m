//
//  MGLoginViewController.m
//  zhifu
//
//  Created by Unchastity on 12/8/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGLoginViewController.h"
#import "CreateBarBtnItem.h"
#import "CustomButton.h"
#import "MGRegisterViewController.h"
#import "UIAlertController+CreateAlertControllerQuickly.h"
#import "MGMacro.h"

@interface MGLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userIDText;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property (weak, nonatomic) IBOutlet UIButton *rememberUserIDBtn;

- (IBAction)rememberUserID:(UIButton *)sender;

- (IBAction)forgetPassword:(UIButton *)sender;

- (IBAction)loginNow:(UIButton *)sender;

- (IBAction)registerNow;

- (IBAction)loginWithOthers:(CustomButton *)sender;

@end

@implementation MGLoginViewController

+(instancetype)getViewController
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier: @"MGLoginViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavigationBar];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [self.userIDText setText: [userDefaults valueForKey:@"userID"]];
    NSNumber *isSelect = [userDefaults valueForKey: @"isRememberBtnSelected"];
    self.rememberUserIDBtn.selected = isSelect.boolValue;
}

-(void)viewWillAppear:(BOOL)animated {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (self.rememberUserIDBtn.selected && self.userIDText.text.length > 0)
    {
        [userDefaults setObject: self.userIDText.text forKey: @"userID"];
    }
}

-(void)initNavigationBar
{
    [self.navigationItem setTitle: @"登录"];
    
    UIBarButtonItem *leftBtn = [CreateBarBtnItem createBarBtnItemWithTitle: @"取消"
                                                                     image:@""
                                                                     frame:CGRectMake(0, 0, 50, 25)
                                                           titleEdgeInsets:UIEdgeInsetsZero
                                                           imageEdgeInsets:UIEdgeInsetsZero
                                                                    Target:self
                                                                    select:@selector(cancelLogin)];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

-(void)cancelLogin
{
    [self dismissViewControllerAnimated: YES completion:^{
    }];
}

- (IBAction)rememberUserID:(UIButton *)sender {
    
    sender.selected =  !sender.selected;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (sender.selected)
    {
        [userDefaults setObject: self.userIDText.text forKey: @"userID"];
        [userDefaults setObject: @1 forKey: @"isRememberBtnSelected"];
    }else
    {
        [userDefaults setObject: @0 forKey: @"isRememberBtnSelected"];
        if ([self.userIDText.text isEqualToString: [userDefaults objectForKey:@"userID"]]) {
            [userDefaults setObject: @"" forKey: @"userID"];
        }
    }
}

- (IBAction)forgetPassword:(UIButton *)sender {
    
    
}

- (IBAction)loginNow:(UIButton *)sender {
    
    [self.view endEditing: YES];
    
    if (self.userIDText.text.length == 0) {
        [self displayAlertControllerWithMessage: @"用户名不能为空"];
        return;
    }
    if (self.passwordText.text.length == 0) {
        [self displayAlertControllerWithMessage: @"密码不能为空"];
    }
    
    NSString *urlStr = @"http://service.zhifubank.com";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: urlStr]];
    [request setHTTPMethod: @"POST"];
    
    //_client_=IOS&_cmd_=member_login&_deviceid_=3FA87349-A015-441D-8023-B98B5CEAF206&_sign_=11bf342cd0f8a38e3472ca8528fdd8da&isnew=isnew&password=sghhh&username=drth
    NSString *bodyStr = [NSString stringWithFormat:@"_client_=IOS&_cmd_=member_login&%@&_sign_=11bf342cd0f8a38e3472ca8528fdd8da&isnew=isnew&password=%@&username=%@",deviceUUID, self.passwordText.text, self.userIDText.text];
    [request setHTTPBody: [bodyStr dataUsingEncoding: NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            
            NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData: data options: 0 error:nil];
            if (![resultDict[@"errormsg"] isEqualToString: @""]) {
                [self displayAlertControllerWithMessage: resultDict[@"errormsg"]];
            }else
            {
                //传值
                
                [self dismissViewControllerAnimated: YES completion:^{
                    
                }];
            }
        }
    }];
    [task resume];
}

- (IBAction)registerNow {
    
    MGRegisterViewController *registerVC = [MGRegisterViewController registerViewControllerFromStoryboard];
    [self.navigationController pushViewController: registerVC animated: YES];
}

- (IBAction)loginWithOthers:(CustomButton *)sender {
    
}

-(void)displayAlertControllerWithMessage:(NSString *)msg
{
    UIAlertController *alertController = [UIAlertController createAlertControllerWithTitle: @"提示"
                                                                                   message: msg
                                                                            preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController: alertController animated:YES completion:^{
        
    }];
}


@end
