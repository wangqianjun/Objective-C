//
//  ViewController.m
//  RuntimeMessage
//
//  Created by 王钱钧 on 16/3/22.
//  Copyright © 2016年 ASE. All rights reserved.
//

#import "ViewController.h"
#import "Message.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Message *msg = [[Message alloc]init];
//    [Message sendMessage:@"hello, doris"];
    [msg sendMessage:@"hello, arthur"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
