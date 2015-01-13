//
//  ViewController.m
//  ProgrammaticallyAutoLayout
//
//  Created by 王钱钧 on 14/12/30.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *redView;
@property (strong, nonatomic) UIView *yellowView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
//    [self example_1];
    [self example_6];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initViews {
    self.redView = [UIView new];
    [self.redView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.redView setBackgroundColor:[UIColor colorWithRed:0.95 green:0.47 blue:0.48 alpha:1.0]];
    
    self.yellowView = [UIView new];
    self.yellowView.translatesAutoresizingMaskIntoConstraints = NO;
    self.yellowView.backgroundColor = [UIColor colorWithRed:1.00 green:0.83 blue:0.58 alpha:1.0];
    
    [self.view addSubview:self.redView];
    [self.view addSubview:self.yellowView];
}

- (void)example_1 {
    NSDictionary *viewsDictionary = @{@"redView":self.redView};
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[redView(100)]" options:0 metrics:nil views:viewsDictionary];
    NSArray *constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[redView(100)]" options:0 metrics:nil views:viewsDictionary];
    [self.redView addConstraints:constraint_H];
    [self.redView addConstraints:constraint_V];
    
    CGFloat marginTop = 30.0f;
    CGFloat marginLeft = 30.0f;
    NSArray *constraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[redView]", marginTop] options:0 metrics:nil views:viewsDictionary];
    NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[redView]",marginLeft] options:0 metrics:nil views:viewsDictionary];
    
    [self.view addConstraints:constraint_POS_V];
    [self.view addConstraints:constraint_POS_H];

    
}

- (void)example_2 {
    NSDictionary *viewsDictionary = @{@"redView":self.redView,
                                     @"yellowView":self.yellowView
                                     };
    // 1. Define the views Sizes
    NSArray *red_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[redView(100)]" options:0 metrics:nil views:viewsDictionary];
    NSArray *red_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[redView(100)]" options:0 metrics:nil views:viewsDictionary];
    [self.redView addConstraints:red_constraint_H];
    [self.redView addConstraints:red_constraint_V];
    
    NSArray *yellow_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[yellowView(100)]" options:0 metrics:nil views:viewsDictionary];
    NSArray *yellow_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[yellowView(200)]" options:0 metrics:nil views:viewsDictionary];
    [self.yellowView addConstraints:yellow_constraint_H];
    [self.yellowView addConstraints:yellow_constraint_V];
    
    // 2. Define the views Positions
    NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[redView]-40-[yellowView]" options:0 metrics:nil views:viewsDictionary];
    NSArray *constraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[redView]-30-[yellowView]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint_POS_V];
    [self.view addConstraints:constraint_POS_H];
    
}

- (void)example_3 {
    NSDictionary *viewsDictionary = @{@"redView":self.redView,
                                      @"yellowView":self.yellowView
                                      };
    
    NSArray *red_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[redView(100)]" options:0 metrics:nil views:viewsDictionary];
    NSArray *red_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[redView(100)]" options:0 metrics:nil views:viewsDictionary];
    [self.redView addConstraints:red_constraint_H];
    [self.redView addConstraints:red_constraint_V];
    
    NSArray *yellow_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[yellowView(100)]" options:0 metrics:nil views:viewsDictionary];
    NSArray *yellow_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[yellowView(200)]" options:0 metrics:nil views:viewsDictionary];
    [self.yellowView addConstraints:yellow_constraint_H];
    [self.yellowView addConstraints:yellow_constraint_V];
    
    NSArray *constraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[redView]" options:0 metrics:nil views:viewsDictionary];
    NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[redView]-10-[yellowView]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint_POS_V];
    [self.view addConstraints:constraint_POS_H];
    
    
}

// Example 4: Simple constraints with visual format using metrics
- (void)example_4 {
    // 1. Create a dictionary of views and metrics
    NSDictionary *viewsDictionary = @{@"redView":self.redView, @"yellowView":self.yellowView};
    NSDictionary *metrics = @{@"redWidth": @100,
                              @"redHeight": @100,
                              @"yellowHeight": @150,
                              @"yellowWidth": @100,
                              @"topMargin" : @120,
                              @"leftMargin" :@20,
                              @"viewSapcing" :@10
                              };
    NSArray *red_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[redView(redWidth)]" options:0 metrics:metrics views:viewsDictionary];
    NSArray *red_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[redView(redHeight)]" options:0 metrics:metrics views:viewsDictionary];
    [self.redView addConstraints:red_constraint_H];
    [self.redView addConstraints:red_constraint_V];
    
    NSArray *yellow_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[yellowView(yellowWidth)]" options:0 metrics:metrics views:viewsDictionary];
    NSArray *yellow_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[yellowView(yellowHeight)]" options:0 metrics:metrics views:viewsDictionary];
    [self.yellowView addConstraints:yellow_constraint_V];
    [self.yellowView addConstraints:yellow_constraint_H];
    
    NSArray *constraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topMargin-[redView]" options:0 metrics:metrics views:viewsDictionary];
    NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[redView]-20-|" options:0 metrics:metrics views:viewsDictionary]; //@"H:|-leftMargin-[redView]-viewSapcing-[yellowView]"
    [self.view addConstraints:constraint_POS_H];
    [self.view addConstraints:constraint_POS_V];
}

#pragma mark - automatically the size
- (void)example_5 {
    NSDictionary *viewsDictionary = @{@"redView": self.redView};
    NSDictionary *metrics = @{@"vSpacing": @30, @"hSpacing": @10};
    
    //  Define the view Position and automatically the Size
    NSArray *constraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-vSpacing-[redView]-vSpacing-|" options:0 metrics:metrics views:viewsDictionary];
    NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-hSpacing-[redView]-hSpacing-|" options:0 metrics:metrics views:viewsDictionary];
    [self.view addConstraints:constraint_POS_V];
    [self.view addConstraints:constraint_POS_H];
}

- (void)example_6 {
    NSDictionary *viewsDictionary = @{@"redView": self.redView};
    NSDictionary *metrics = @{@"vSpacing": @30, @"hSpacing": @10};
    
    //  Define the view Position and automatically the Size (for the redView)
    NSArray *constraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-vSpacing-[redView]-vSpacing-|" options:0 metrics:metrics views:viewsDictionary];
    NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-hSpacing-[redView]-hSpacing-|" options:0 metrics:metrics views:viewsDictionary];
    [self.view addConstraints:constraint_POS_H];
    [self.view addConstraints:constraint_POS_V];
    
    // Define sizes thanks to relations with another view (yellowView in relation with redView)
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.yellowView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.yellowView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0.0]];
    
    //Define position thanks to relations with another view (yellowView in relation with redView)
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.yellowView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.yellowView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    
}

@end
