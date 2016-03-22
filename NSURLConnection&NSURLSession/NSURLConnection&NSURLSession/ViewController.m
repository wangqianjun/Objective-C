//
//  ViewController.m
//  NSURLConnection&NSURLSession
//
//  Created by 王钱钧 on 15/12/7.
//  Copyright © 2015年 ASE. All rights reserved.
//

#import "ViewController.h"

#define kdefaultURL  @"http://img12.static.yhbimg.com/yhb-img01/2015/12/03/10/02265f4b20069ad75823de981f4ff662f7.jpg?imageView/0/w/750/h/750"


@interface ViewController ()<NSURLConnectionDelegate, NSStreamDelegate>
{
    UIButton *_leftButton;
    UIButton *_rightButton;
    UIImageView *_imageView;
    
    NSMutableData *_data;
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


/*
 
 1.从数据源创建和初始化一个NSInputStream实例
 2.将输入流对象配置到一个run loop，open the stream
 3. 通过流对象的delegate函数处理事件
 4. 当所有数据读完，进行流对象的内存处理
 
 */

- (void)setupIOStreamForFile:(NSString *)filePath
{
    NSInputStream *inputStream = [[NSInputStream alloc]initWithFileAtPath:filePath];
    inputStream.delegate = self;
    [inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    //打开流后，我们可以使用streamStatus属性查看流的状态，用hasBytesAvailable属性检测是否有可读的数据，用streamError来查看流处理过程中产生的错误。
}

//可以给流对象指定一个代理对象。如果没有指定，则流对象作为自己的代理
#pragma mark - NSStreamDelegate
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    NSLog(@"streamStatus = %lud",(unsigned long)aStream.streamStatus);
    NSLog(@"eventCode = %lud",(unsigned long)eventCode);
    
    
    
    switch (eventCode) {
            
            //可以读
        case NSStreamEventHasBytesAvailable:
        {
            if (!_data) {
                _data = [NSMutableData data];
            }
            
            uint8_t buf[1024];
            NSInteger len = 0;
            len = [(NSInputStream *)aStream read:buf maxLength:1024];  // 读取数据
            if (len) {
                [_data appendBytes:(const void *)buf length:len];
            } else {
                NSLog(@"no buffer!");
            }
        }
            break;
            
            //可以写
            case NSStreamEventHasSpaceAvailable:
        {
            
        }
            break;
            
            default:
            break;
    }
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
