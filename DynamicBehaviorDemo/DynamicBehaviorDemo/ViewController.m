//
//  ViewController.m
//  DynamicBehaviorDemo
//
//  Created by 王钱钧 on 14/11/6.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollisionBehaviorDelegate>
{
    UIDynamicAnimator *_animator;
    UIGravityBehavior *_gravity;
    UIDynamicBehavior *_coustomBehavior;
    UIDynamicItemBehavior *_itemBehavior;
    UICollisionBehavior *_collision;
    
    UIView *_square;
    UIView *_barrier;
    
    BOOL _firstContact;
}



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initBehavior];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)initView
{
    _square = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _square.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_square];
    
    _barrier = [[UIView alloc]initWithFrame:CGRectMake(0, 300, 130, 20)];
    _barrier.backgroundColor = [UIColor redColor];
    [self.view addSubview:_barrier];
}

     
- (void)initBehavior {
    
    _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc]initWithItems:@[_square]];

    // 设置重力加速度方向
    _gravity.gravityDirection = CGVectorMake(0, 1);
    
    // 设置碰撞检测
    _collision = [[UICollisionBehavior alloc] initWithItems:@[_square]];
//    _collision = [[UICollisionBehavior alloc] initWithItems:@[_square, _barrier]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    
    CGPoint rightEdge = CGPointMake(CGRectGetMinX(_barrier.frame) + CGRectGetWidth(_barrier.frame), CGRectGetMinY(_barrier.frame));
    [_collision addBoundaryWithIdentifier:@"barrier" fromPoint:_barrier.frame.origin toPoint:rightEdge];
    _collision.action = ^{
//        NSLog(@"%@, %@",
//              NSStringFromCGAffineTransform(_square.transform),
//              NSStringFromCGPoint(_square.center));
    };
    
    _collision.collisionDelegate = self;
    
    
    _itemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:@[_square]];
    _itemBehavior.elasticity = 1; // 弹力
    _itemBehavior.density = 100; // 密度
    

    [_animator addBehavior:_gravity];
    [_animator addBehavior:_collision];
    [_animator addBehavior:_itemBehavior];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollisionBehaviorDelegate
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    NSLog(@"Boundary contact occurred - %@", identifier);
    UIView *view = (UIView *)item;
    [view setBackgroundColor:[UIColor yellowColor]];
    [UIView animateWithDuration:0.3 animations:^{
        [view setBackgroundColor:[UIColor grayColor]];
    }];
    
    if (!_firstContact) {
        _firstContact = YES;
        UIView *square = [[UIView alloc] initWithFrame:CGRectMake(30, 0, 100, 100)];
        square.backgroundColor = [UIColor grayColor];
        [self.view addSubview:square];
        
        [_collision addItem:square];
        [_gravity addItem:square];
        
        UIAttachmentBehavior* attach = [[UIAttachmentBehavior alloc] initWithItem:view
                                                                   attachedToItem:square];
        [_animator addBehavior:attach];
    }
}
@end
