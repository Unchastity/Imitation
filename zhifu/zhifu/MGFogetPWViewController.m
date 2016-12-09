//
//  MGFogetPWViewController.m
//  zhifu
//
//  Created by Unchastity on 12/9/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGFogetPWViewController.h"
#import "NSString+CountNumChangeFormat.h"
#import "UIAlertController+CreateAlertControllerQuickly.h"
#import "MGMacro.h"

@interface MGFogetPWViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mobileNumText;

@property (weak, nonatomic) IBOutlet UITextField *verifyCodeText;

@property (weak, nonatomic) IBOutlet UIButton *getVerifyBtn;
@end

@implementation MGFogetPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mobileNumText.leftViewMode = UITextFieldViewModeAlways;
    UIView *view1 = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 40, 40)];
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"icon-in-phone"]];
    leftImageView.frame = CGRectMake(5, 5, 30, 30);
    [view1 addSubview: leftImageView];
    self.mobileNumText.leftView = view1;
    
    self.verifyCodeText.leftViewMode = UITextFieldViewModeAlways;
    UIView *view2 = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 40, 40)];
    UIImageView *leftImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"icon-in-auth"]];
    leftImage.frame = CGRectMake(5, 5, 30, 30);
    [view2 addSubview: leftImage];
    self.verifyCodeText.leftView = view2;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing: YES];
}

+(instancetype)getViewControllerFromStoryboard
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier: @"MGFogetPWViewController"];
}

- (IBAction)getVerifyCode:(UIButton *)sender {
    [self.view endEditing: YES];
    
    NSString *mobileNum = self.mobileNumText.text;
    if (![NSString isMobileNumber: mobileNum]) {
        [self displayAlertControllerWithMessage: @"手机号码格式不正确"];
        return;
    }
    
    NSString *urlStr = @"http://service.zhifubank.com/";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: urlStr]];
    [request setHTTPMethod: @"POST"];
    //_client_=IOS&_cmd_=recover_pwd&_deviceid_=3FA87349-A015-441D-8023-B98B5CEAF206&_sign_=821f89bbd49ba657976b723c3c0a8ef9&mobile=13641784825&newp=get_verifycode&type=get_mobileverify
    NSString *bodyStr = [NSString stringWithFormat:@"_client_=IOS&_cmd_=recover_pwd&%@&_sign_=821f89bbd49ba657976b723c3c0a8ef9&mobile=%@&newp=get_verifycode&type=get_mobileverify", deviceUUID, mobileNum];
    [request setHTTPBody: [bodyStr dataUsingEncoding: NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData: data options: 0 error: nil];
            if (![resultDict[@"errormsg"] isEqualToString: @""]) {
                
                [self displayAlertControllerWithMessage: @"errormsg"];
            }else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    __block int totalCnt = 60;
                    [NSTimer scheduledTimerWithTimeInterval: 1.0 repeats: YES block:^(NSTimer * _Nonnull timer) {
                        if (totalCnt > 0) {
                            --totalCnt;
                            NSString *title = [NSString stringWithFormat: @"%ds后可重发", totalCnt];
                            [self.getVerifyBtn setBackgroundColor: [UIColor grayColor]];
                            [self.getVerifyBtn setTitle: title forState:UIControlStateNormal];
                            self.getVerifyBtn.userInteractionEnabled = NO;
                        }else
                        {
                            NSString *title = @"重新发送";
                            [self.getVerifyBtn setBackgroundColor: [UIColor redColor]];
                            [self.getVerifyBtn setTitle: title forState:UIControlStateNormal];
                            self.getVerifyBtn.userInteractionEnabled = YES;
                            [timer invalidate];
                        }
                    }];
                });
            }
        }
    }];
    [task resume];
}

- (IBAction)sendNewPasswordToMobile:(UIButton *)sender {
    [self.view endEditing: YES];
    
    NSString *mobileNum = self.mobileNumText.text;
    if (![NSString isMobileNumber: mobileNum]) {
        [self displayAlertControllerWithMessage: @"手机号码格式不正确"];
        return;
    }
    
    if ([self.verifyCodeText.text isEqualToString: @""]) {
        [self displayAlertControllerWithMessage: @"请输入短信验证码"];
        return;
    }
    
    NSString *urlStr = @"http://service.zhifubank.com/";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: urlStr]];
    [request setHTTPMethod: @"POST"];
    //_client_=IOS&_cmd_=recover_pwd&_deviceid_=3FA87349-A015-441D-8023-B98B5CEAF206&_sign_=821f89bbd49ba657976b723c3c0a8ef9&mobile=13641784825&type=recover&verify_code=594928
    NSString *bodyStr = [NSString stringWithFormat:@"_client_=IOS&_cmd_=recover_pwd&%@&_sign_=821f89bbd49ba657976b723c3c0a8ef9&mobile=%@&type=recover&verify_code=%@", deviceUUID, mobileNum, self.verifyCodeText.text];
    [request setHTTPBody: [bodyStr dataUsingEncoding: NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData: data options: 0 error: nil];
            if (![resultDict[@"errormsg"] isEqualToString: @""]) {
                
                [self displayAlertControllerWithMessage: resultDict[@"errormsg"]];
            }else
            {
                [self displayAlertControllerWithMessage: resultDict[@"dataresult"]];
            }
        }
    }];
    [task resume];
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
