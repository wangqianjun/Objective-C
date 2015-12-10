//
//  ViewController.m
//  NSURLConnection&NSURLSession
//
//  Created by 王钱钧 on 15/12/7.
//  Copyright © 2015年 ASE. All rights reserved.
//

#import "ViewController.h"

#define kdefaultURL  @"http://img12.static.yhbimg.com/yhb-img01/2015/12/03/10/02265f4b20069ad75823de981f4ff662f7.jpg?imageView/0/w/750/h/750"

@interface ViewController ()<NSURLConnectionDelegate>
{
    UIButton *_leftButton;
    UIButton *_rightButton;
    UIImageView *_imageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI
{
    
    _imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [_imageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:_imageView];
    
    _leftButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 200, 200, 44)];
    [_leftButton setTitle:@"Connection" forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(useNSURLConnection) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton setBackgroundColor:[UIColor redColor]];
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_leftButton.frame)+20, 200, 44)];
    [_rightButton setTitle:@"Session" forState:UIControlStateNormal];
    [_rightButton setBackgroundColor:[UIColor redColor]];
    [_rightButton addTarget:self action:@selector(useNSURLSession) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_leftButton];
    [self.view addSubview:_rightButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)useNSURLConnection
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kdefaultURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3];
    
    request.HTTPMethod = @"POST";
    
    [request setValue:@"Arthur" forHTTPHeaderField:@"HeaderF"];
    
    NSString *httpBody = [[NSString alloc]initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    
    NSLog(@"httpBody = %@",httpBody);
    
    NSLog(@"HTTPMethod = %@", request.HTTPMethod);
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (connectionError) {
            NSLog(@"connection error :\n %@", [connectionError localizedDescription]);
        } else {
//            NSLog(@"response data:\n%@",data);
            [_imageView setImage:[UIImage imageWithData:data]];

        }
    }];
}

- (void)useNSURLSession
{
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kdefaultURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3];
//    NSURLSession *session = [NSURLSession sharedSession];
}

#pragma mark - NSURLConnectionDelegate

// 机密存储
- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    return YES;
}

// 鉴权查询（NSURLAuthenticationChallenge)
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
}

@end
