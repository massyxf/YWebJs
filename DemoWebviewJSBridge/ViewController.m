//
//  ViewController.m
//  DemoWebviewJSBridge
//
//  Created by yxf on 2017/8/16.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "ViewController.h"
//#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>

@interface ViewController ()

/** web*/
@property(nonatomic,weak)UIWebView *webview;

/** bridge*/
@property(nonatomic,strong)WebViewJavascriptBridge *bidge;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor redColor];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileUrl];
    [webview loadRequest:request];
    [self.view addSubview:webview];
    _webview = webview;
    
    _bidge = [WebViewJavascriptBridge bridgeForWebView:webview];
    
    // 接收网页发过来的消息
    [_bidge registerHandler:@"test_webview" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSLog(@"%@",data);
        
        //消息处理之后，网页的回调
        responseCallback(data);
        
    }];
    
    //给网页发送消息
    [_bidge callHandler:@"test_webview" data:@{@"client":@"data"} responseCallback:^(id responseData) {
        NSLog(@"%@",responseData);
    }];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
