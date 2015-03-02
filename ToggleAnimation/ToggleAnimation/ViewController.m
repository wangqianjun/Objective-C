//
//  ViewController.m
//  ToggleAnimation
//
//  Created by 王钱钧 on 15/1/26.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UIView *toggleView;
@property (strong, nonatomic) UIButton *button;

@property (strong, nonatomic) UIView *associateSuccessToggleView;
@property (strong, nonatomic) UIView *associateSuccessToggleContentView;
@property (strong, nonatomic) UIImageView *headerImage;
@property (strong, nonatomic) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toggleView = [[UIView alloc]initWithFrame:CGRectMake(0, -30, CGRectGetWidth(self.view.bounds), 30.0f)];
    [self.toggleView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.toggleView];
    
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.bounds), 30.0f)];
    [self.button setTitle:@"Toggle" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    [self layoutAssociateSuccessView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initAssociateSuccessView {
    self.associateSuccessToggleView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 30)];
    [self.associateSuccessToggleView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:self.associateSuccessToggleView];
    self.headerImage = [[UIImageView alloc]init];
    self.label = [[UILabel alloc]init];
    [self.label setFont:[UIFont systemFontOfSize:9.0f]];
    [self.associateSuccessToggleView addSubview:self.headerImage];
    [self.associateSuccessToggleView addSubview:self.label];
}

- (void)layoutAssociateSuccessView {
    UIFont *nameFont = [UIFont boldSystemFontOfSize:9.0f];
    UIFont *midFont = [UIFont systemFontOfSize:9.0f];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:@"Arthur" attributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                     NSFontAttributeName : nameFont}];
    
    NSMutableAttributedString *mid = [[NSMutableAttributedString alloc]initWithString:@"关联了" attributes:@{NSForegroundColorAttributeName : [UIColor grayColor], NSFontAttributeName : midFont}];
    
    NSMutableAttributedString *nickName = [[NSMutableAttributedString alloc]initWithString:@"昵称" attributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : nameFont}];
    
    [name appendAttributedString:mid];
    [name appendAttributedString:nickName];
    
    NSLog(@"name.size.width=%0.1f mid.size.width=%0.1f nickName.size.widt=%0.1f", name.size.width,mid.size.width,nickName.size.width);
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, name.size.width, 30)];
    [textLabel setBackgroundColor:[UIColor redColor]];
    
    [textLabel setAttributedText:name];
    [self.view addSubview:textLabel];
    
}




- (void)click:(id)sender {
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.toggleView.frame;
        frame.origin.y += frame.size.height;
        [self.toggleView setFrame:frame];

    } completion:^(BOOL finished) {
        sleep(2);
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = self.toggleView.frame;
            frame.origin.y -= frame.size.height;
            [self.toggleView setFrame:frame];
        }];
    }];

}







@end
