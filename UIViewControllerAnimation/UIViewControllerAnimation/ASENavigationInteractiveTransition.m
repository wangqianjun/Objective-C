//
//  ASENavigationInteractiveTransition.m
//  UIViewControllerAnimation
//
//  Created by 王钱钧 on 15/4/3.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ASENavigationInteractiveTransition.h"
#import "ASEViewControllerAnimationPOP.h"

@interface ASENavigationInteractiveTransition ()
@property (weak, nonatomic)UINavigationController *navVC;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation ASENavigationInteractiveTransition

- (instancetype)initWihtController:(UIViewController *)vc
{
    self = [super init];
    if (self) {
        self.navVC = (UINavigationController *)vc;
        self.navVC.delegate = self;
    }
    
    return self;
}

/**
 *  我们把用户的每次pan手势操作作为一次pop动画的执行
 */

- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer
{
//    CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
//
//    
//    // 稳定进度区间 0.0（未完成）~1.0（完成）
//    progress = MIN(1.0, MAX(0.0, progress));
//    
//    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        // 手势开始
//        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
//        
//        /**
//         *  告诉控制器开始执行动画
//         */
//        [self.navVC popViewControllerAnimated:YES];
//    } else if(recognizer.state == UIGestureRecognizerStateChanged) {
//        
//        /**
//         *  更新手势完成的进度
//         */
//        [self.interactivePopTransition updateInteractiveTransition:progress];
//    } else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
//        
//        /**
//         *  手势结束时如果进度大于一半，那么就完成pop的操作，否则重新来过
//         */
//        if (progress>0.5) {
//            [self.interactivePopTransition finishInteractiveTransition];
//        } else {
//            [self.interactivePopTransition cancelInteractiveTransition];
//        }
//        
//        self.interactivePopTransition = nil;
//    }
    
    /**
     *  interactivePopTransition就是我们说的方法2返回的对象，我们需要更新它的进度来控制Pop动画的流程，我们用手指在视图中的位置与视图宽度比例作为它的进度。
     */
    CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
    /**
     *  稳定进度区间，让它在0.0（未完成）～1.0（已完成）之间
     */
    progress = MIN(1.0, MAX(0.0, progress));
    
    NSLog(@"progress = %f", progress);

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        /**
         *  手势开始，新建一个监控对象
         */
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        /**
         *  告诉控制器开始执行pop的动画
         */
        [self.navVC popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        /**
         *  更新手势的完成进度
         */
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        /**
         *  手势结束时如果进度大于一半，那么就完成pop操作，否则重新来过。
         */
        if (progress > 0.5) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
    }

    
}

//- (UIPercentDrivenInteractiveTransition *)interactionPopTransition
//{
//    return self.interactionPopTransition;
//}


#pragma mark - UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return [[ASEViewControllerAnimationPOP alloc]init];
    }
    
    return nil;
}


/*
 苹果让我们返回一个交互的对象，用来实时管理控制器之间转场动画的完成度，通过它我们可以让控制器的转场动画与用户交互
 */
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    //苹果让我们返回一个交互的对象，用来实时管理控制器之间转场动画的完成度，通过它我们可以让控制器的转场动画与用户交互
    if ([animationController isKindOfClass:[ASEViewControllerAnimationPOP class]]) {
        return self.interactivePopTransition;
    } else {
        return nil;
    }
}

@end
