//
//  ViewController.m
//  NSOperation
//
//  Created by 王钱钧 on 15/3/20.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"
#import "DownloadManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DownloadManager manager] downloadWithMultiThread];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
