//
//  ASENavigationController.m
//  UIViewControllerAnimation
//
//  Created by 王钱钧 on 15/4/3.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ASENavigationController.h"
#import "ASENavigationInteractiveTransition.h"

@interface ASENavigationController ()<UIGestureRecognizerDelegate>
@property (strong, nonatomic)ASENavigationInteractiveTransition *navTransition;
@end

@implementation ASENavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]init];
    panRecognizer.delegate = self;
    panRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:panRecognizer];
    
    self.navTransition = [[ASENavigationInteractiveTransition alloc]initWihtController:self];
    [panRecognizer addTarget:self.navTransition action:@selector(handleControllerPop:)];
 
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    /**
     *  这里有两个不允许手势执行， 1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    
   return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

@end
