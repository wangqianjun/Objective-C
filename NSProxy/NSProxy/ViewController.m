//
//  ViewController.m
//  NSProxy
//
//  Created by  on 15/3/5.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"
#import "AppProxy.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 多代理
    [[AppProxy sharedProxy] doLoginThing];
    [[AppProxy sharedProxy] doMessageThing];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
