//
//  ViewController.m
//  NSProxy
//
//  Created by 王钱钧 on 15/3/5.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"
#import "MyProxy.h"
#import "RealSubject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyProxy *myProxy = [MyProxy alloc];
    RealSubject *realSub = [[RealSubject alloc]init];
    [myProxy transformToObject:realSub];
    [myProxy fun];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
