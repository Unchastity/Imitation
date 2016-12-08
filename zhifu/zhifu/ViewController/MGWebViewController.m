//
//  MGWebViewController.m
//  zhifu
//
//  Created by Unchastity on 12/7/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGWebViewController.h"
#import "MGMacro.h"
#import "MGBannersModel.h"

@interface MGWebViewController ()<UIWebViewDelegate>
{
    UIActivityIndicatorView *_networkActivity;
}

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation MGWebViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle: self.bannersModel.title];
    
    [self initNavigationBar];
    
    [self initViews];
}

-(void)initNavigationBar
{
//    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.leftBarButtonItem = leftBtn;
    if (self.bannersModel.is_share.integerValue == 1) {
        UIButton *shareBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(0, 0, 36, 36);
        [shareBtn setImage:[UIImage imageNamed: @"UMS_share_normal_white"] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed: @"UMS_share_tap_white"] forState:UIControlStateSelected];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: shareBtn];
    }

}

-(void)initViews {
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    webView.allowsPictureInPictureMediaPlayback = YES;
    webView.userInteractionEnabled = YES;
    self.webView = webView;
    [self.view addSubview: self.webView];
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: @"http://www.baidu.com"]]];
    //NSString *webUrl = [NSString stringWithFormat:@"%@?parameters=fHxpb3M=", self.bannersModel.href ];
    //HTTP : 必须添加http://
    NSString *webUrl = [NSString stringWithFormat:@"http://%@", self.bannersModel.href];
    NSLog(@"web URL: %@", webUrl);
//    NSString *htmlString = [NSString stringWithContentsOfURL: [NSURL URLWithString: webUrl] encoding:NSUTF8StringEncoding error: NULL ];
//    
//    [self.webView loadHTMLString:htmlString baseURL: [NSURL URLWithString: webUrl]];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: webUrl]]];
    _networkActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _networkActivity.frame = CGRectMake(0, 0, 20, 20);
    _networkActivity.center = self.view.center;
    _networkActivity.hidesWhenStopped = YES;
    [self.view addSubview: _networkActivity];
    [self.view bringSubviewToFront: _networkActivity];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"should start load");
 
    [_networkActivity startAnimating];
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"did star load");
    [_networkActivity startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"did finish load");
    [_networkActivity stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error= %@", error.description);
    [_networkActivity stopAnimating];

}

@end
