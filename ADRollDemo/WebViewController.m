//
//  WebViewController.m
//  ADRollDemo
//
//  Created by hztuen on 17/3/16.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "WebViewController.h"
#import "UIColor+ColorHelper.h"

#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width

@interface WebViewController () <UIWebViewDelegate,UIScrollViewDelegate>
{
    UIWebView                    *_webView;
    NSURL                        *_url;
    NSMutableURLRequest          *_request;
}

@end

@implementation WebViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (id)initWithUrl:(NSString *)url title:(NSString *)title
{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        _url = [NSURL URLWithString:url];
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        [_webView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        _webView.backgroundColor = [UIColor colorWithHexString:@"eeeeee" alpha:1.0];
        _webView.delegate = self;
        [_webView setScalesPageToFit:YES];
        _webView.scrollView.delegate = self;
        _webView.scrollView.canCancelContentTouches = YES;
        _webView.scrollView.delaysContentTouches = NO;
        _request = [NSMutableURLRequest requestWithURL:_url];
        [_webView loadRequest:_request];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNaviBarLeftBtn];
    [self createUI];
}

- (void)setUpNaviBarLeftBtn
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"left-icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 27, 27);
    
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(gotoNaviBarLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
}

- (void)gotoNaviBarLeftBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createUI
{
    _webView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64);
    [self.view addSubview:_webView];
}


#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
