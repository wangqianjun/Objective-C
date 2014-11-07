//
//  ViewController.m
//  GetterAndSetter
//
//  Created by 王钱钧 on 14/10/24.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSString *str3;
}

@property (strong, nonatomic) NSString *str4;
@end

@implementation ViewController

- (void)setStr1:(NSString *)str1
{
//    self.str1 = str1;
    _str1 = str1;
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *tempStr = self.str1;
    self.str1 = @"changed";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
