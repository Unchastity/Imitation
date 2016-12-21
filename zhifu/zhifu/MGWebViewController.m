//
//  MGWebViewController.m
//  zhifu
//
//  Created by Unchastity on 12/21/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGWebViewController.h"
#import "MGMacro.h"

@interface MGWebViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
}

@end

@implementation MGWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle: self.title];
}

-(void)initWebView
{
    _webView = [[UIWebView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _webView.delegate = self;
    
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

@end
