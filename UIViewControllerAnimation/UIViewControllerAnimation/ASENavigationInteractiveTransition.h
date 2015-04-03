//
//  ASENavigationInteractiveTransition.h
//  UIViewControllerAnimation
//
//  Created by 王钱钧 on 15/4/3.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

/**
 *  专门处理交互对象
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ASENavigationInteractiveTransition : NSObject<UINavigationControllerDelegate>

- (instancetype)initWihtController:(UIViewController *)vc;

- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer;

- (UIPercentDrivenInteractiveTransition *)interactivePopTransition;

@end
