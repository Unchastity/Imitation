//
//  MGRegisterViewController.m
//  zhifu
//
//  Created by Unchastity on 12/8/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGRegisterViewController.h"
#import "UIAlertController+CreateAlertControllerQuickly.h"
#import "NSString+CountNumChangeFormat.h"
#import "MGMacro.h"
#import "MGWebViewController.h"

@interface MGRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *telText;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property (weak, nonatomic) IBOutlet UITextField *rePasswordText;

@property (weak, nonatomic) IBOutlet UITextField *verifyText;

@property (weak, nonatomic) IBOutlet UITextField *inviteText;

@property (weak, nonatomic) IBOutlet UIButton *getVrifyBtn;

@property (weak, nonatomic) IBOutlet UIButton *agressProtocolBtn;

@property (weak, nonatomic) IBOutlet UIView *voiceView;

@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (weak, nonatomic) IBOutlet UILabel *voiceLabel;

@end

@implementation MGRegisterViewController
//在interface中设置self.hidesBottomBarWhenPushed
////隐藏tabbar
//-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName: nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.hidesBottomBarWhenPushed = YES;
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    [self.navigationItem setTitle: @"注册"];
    
    self.voiceView.hidden = YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing: YES];
}

+(instancetype)registerViewControllerFromStoryboard
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MGRegisterViewController"];
}

- (IBAction)getVerifyCode:(UIButton *)sender
{
    [self.view endEditing: YES];
    
    NSString *telNum = self.telText.text;
    if (! [NSString isMobileNumber: telNum]) {
        [self displayAlertControllerWithMessage: @"手机格式不正确"];
        return;
    }
    NSString *urlStr = @"http://service.zhifubank.com";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: urlStr]];
    [request setHTTPMethod: @"POST"];
    //@"_client_=IOS&_cmd_=member_reg&_deviceid_=3FA87349-A015-441D-8023-B98B5CEAF206&_sign_=ab03d10c139bf848483aac6bb0253061&mobile=13641784825&newp=get_verifycode&type=get_mobileverify"
    NSString *bodyStr = [NSString stringWithFormat:@"_client_=IOS&_cmd_=member_reg&%@&_sign_=ab03d10c139bf848483aac6bb0253061&mobile=%@&newp=get_verifycode&type=get_mobileverify", deviceUUID, telNum];
    [request setHTTPBody: [bodyStr dataUsingEncoding: NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData: data options:0 error:nil];
            if ([resultDict[@"errormsg"] isEqualToString: @""])
            {
                [self displayAlertControllerWithMessage: resultDict[@"errormsg"]];
            }else
            {
                //[self displayAlertControllerWithMessage: resultDict[@"dataresult"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //必须放在主线程中
                    self.voiceView.hidden = NO;
                    [self.voiceLabel setText:@"若没有收到验证码，请尝试"];
                    self.voiceBtn.hidden = NO;
                    
                    __block int totalCnt = 60;
                    //将button改为custom可解决 闪
                    [NSTimer scheduledTimerWithTimeInterval: 1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
                        if (totalCnt > 0) {
                            --totalCnt;
                            NSString *title = [NSString stringWithFormat:@"%ds后可重发", totalCnt];
                            [self.getVrifyBtn setBackgroundColor: [UIColor grayColor]];
                            [self.getVrifyBtn setTitle: title forState:UIControlStateNormal];
                            self.getVrifyBtn.userInteractionEnabled = NO;
                        }else
                        {
                            NSString *title = @"重新发送";
                            [self.getVrifyBtn setBackgroundColor: [UIColor redColor]];
                            [self.getVrifyBtn setTitle: title forState:UIControlStateNormal];
                            self.getVrifyBtn.userInteractionEnabled = YES;
                            [timer invalidate];
                        }
                    }];
                });
            }
        }
    }];
    [task resume];
}

- (IBAction)getVoiceVerifyCode {
    [self.view endEditing: YES];
    
    NSString *telNum = self.telText.text;
    if (! [NSString isMobileNumber: telNum]) {
        [self displayAlertControllerWithMessage: @"手机格式不正确"];
        return;
    }
    self.voiceBtn.hidden = YES;
    [self.voiceLabel setText: @"请注意接听来电给您播报的验证码"];
    
    NSString *urlStr = @"http://service.zhifubank.com";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: urlStr]];
    [request setHTTPMethod: @"POST"];
    //_client_=IOS&_cmd_=member_reg&_deviceid_=3FA87349-A015-441D-8023-B98B5CEAF206&_sign_=ab03d10c139bf848483aac6bb0253061&mobile=13641784825&newp=get_verifycode&sms_type=2&type=get_mobileverify
    NSString *bodyStr = [NSString stringWithFormat:@"_client_=IOS&_cmd_=member_reg&%@&_sign_=ab03d10c139bf848483aac6bb0253061&mobile=%@&newp=get_verifycode&sms_type=2&type=get_mobileverify", deviceUUID, telNum];
    [request setHTTPBody: [bodyStr dataUsingEncoding: NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request];
    [task resume];
}

- (IBAction)registerNow:(UIButton *)sender
{
    [self.view endEditing: YES];
    
    if (![self.passwordText.text isEqualToString: self.rePasswordText.text]) {
        [self displayAlertControllerWithMessage: @"两次输入的密码不一致，请重新输入"];
    }
    
    //_client_=IOS&_cmd_=member_reg&_deviceid_=3FA87349-A015-441D-8023-B98B5CEAF206&_sign_=ab03d10c139bf848483aac6bb0253061&invitecode=3566&isnew=isnew&mobile=13641784825&openid=&password=jimg340421&qtype=&re_password=jimg340421&type=reg&username=13641784825&verify_code=313525
    NSString *urlStr = @"http://service.zhifubank.com";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: urlStr]];
    [request setHTTPMethod: @"POST"];
    NSString *bodyStr = [NSString stringWithFormat:@"_client_=IOS&_cmd_=member_reg&%@&_sign_=ab03d10c139bf848483aac6bb0253061&invitecode=%@&isnew=isnew&mobile=%@&openid=&password=%@&qtype=&re_password=%@&type=reg&username=%@&verify_code=%@", deviceUUID, self.inviteText.text, self.telText.text, self.passwordText.text, self.rePasswordText.text, self.telText.text, self.verifyText.text];
    [request setHTTPBody: [bodyStr dataUsingEncoding: NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData: data options: 0 error:nil];
            if ([resultDict[@"errormsg"] isEqualToString:@""]) {
                [self displayAlertControllerWithMessage: resultDict[@"errormsg"]];
            }else
            {
                [self displayAlertControllerWithMessage: @"注册成功"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.telText setText: @""];
                    [self.passwordText setText: @""];
                    [self.rePasswordText setText: @""];
                    [self.verifyText setText: @""];
                    [self.inviteText setText: @""];
                    
                    [self.getVrifyBtn setBackgroundColor: [UIColor redColor]];
                    [self.getVrifyBtn setTitle: @"获取验证码" forState: UIControlStateNormal];
                    self.getVrifyBtn.userInteractionEnabled = YES;
                    
                    self.voiceView.hidden = YES;
                });
            }
        }
    }];
    [task resume];
}

- (IBAction)agreeServeProtocol:(UIButton *)sender
{
    [self.view endEditing: YES];
    
    MGWebViewController *webVC = [[MGWebViewController alloc] init];
    webVC.urlStr = @"http://service.zhifu360.com/protocol";
    [self.navigationController pushViewController: webVC animated: YES];
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
