//
//  ViewController.m
//  Fundation_NSValue
//
//  Created by 王钱钧 on 15/3/4.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    CGRect r1 = CGRectMake(0, 0, 320, 10);
    CGRect r2 = CGRectMake(10, 20, 320, 10);
    
    CGRect r = CGRectUnion(r1, r2);
    
    NSLog(@"r = %@", NSStringFromCGRect(r));
    
    if (CGRectIntersectsRect(r1, r)) {
        NSLog(@"r1 intersects r");
    }
    
    if (CGRectIntersectsRect(r2, r)) {
         NSLog(@"r2 intersects r");
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
