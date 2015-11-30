//
//  ViewController.m
//  UIButtonDemo
//
//  Created by 王钱钧 on 15/11/30.
//  Copyright © 2015年 ASE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UIButton *myButton;
@end

@implementation ViewController

- (UIButton *)myButton
{
    if (!_myButton) {
        _myButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 86, 44)];
//        [_myButton setImage: forState:];
        [_myButton setBackgroundImage:[UIImage imageNamed:@"btn_small_red_n"] forState:UIControlStateNormal];
        [_myButton setBackgroundImage:[UIImage imageNamed:@"btn_small_red_d"] forState:UIControlStateDisabled];
        [_myButton setBackgroundImage:[UIImage imageNamed:@"btn_small_red_s"] forState:UIControlStateHighlighted];
        
        [_myButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _myButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initButton];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)initButton
{
    [self.view addSubview:self.myButton];
}

- (void)clickAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.enabled = !btn.enabled;
    

//    btn.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"highlighted = %d",self.myButton.highlighted);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"highlighted = %d",self.myButton.highlighted);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"highlighted = %d",self.myButton.highlighted);
}

@end
