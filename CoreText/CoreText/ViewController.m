//
//  ViewController.m
//  CoreText
//
//  Created by 王钱钧 on 15/1/13.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"
#import "ASETextView.h"

@interface ViewController ()

@property (strong, nonatomic)ASETextView *aSeTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aSeTextView = [[ASETextView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview: self.aSeTextView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
