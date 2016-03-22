//
//  ViewController.m
//  SwizzledAOP
//
//  Created by 王钱钧 on 15/9/11.
//  Copyright (c) 2015年 王钱钧. All rights reserved.
//

#import "ViewController.h"
#import "Aspects.h"

static void __attribute__((constructor)) initialize(void)
{
    
}


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadView
{
    [super loadView];
     NSLog(@"%s",__func__);
    
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
 
    
    NSLog(@"%s",__func__);
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
 
    NSLog(@"%s",__func__);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);

    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
    
//    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:view];
    
//    [self.view setBackgroundColor:[UIColor redColor]];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

