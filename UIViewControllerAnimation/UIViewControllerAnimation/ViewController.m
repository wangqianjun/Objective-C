//
//  ViewController.m
//  UIViewControllerAnimation
//
//  Created by 王钱钧 on 15/4/3.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"
#import "ASENavigationController.h"

@interface ViewController ()<UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.delegate = self;
    
//    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePop:)];
//    [self.view addGestureRecognizer:panGR];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
