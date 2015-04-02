//
//  ViewController.m
//  AffineTransform
//
//  Created by 王钱钧 on 15/4/2.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIView *redView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
//    [self singleTrasform];
//    [self mixTrasform];
    [self transform3D];


    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initViews
{
    redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    redView.backgroundColor = [UIColor redColor];
    redView.center = self.view.center;
    [self.view addSubview:redView];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mrak - 2D变幻

- (void)singleTrasform
{
    CGAffineTransform transfrom = CGAffineTransformMakeRotation(M_PI_4);
    redView.layer.affineTransform = transfrom;
}

- (void)mixTrasform
{
    CGAffineTransform transform = CGAffineTransformIdentity; //scale by 50%
    transform = CGAffineTransformScale(transform, 0.5, 0.5); //rotate by 30 degrees
    transform = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0); //translate by 200 points
    transform = CGAffineTransformTranslate(transform, 200, 0);
    
    redView.transform = transform;
}

/*
 CGAffineTransformMakeRotation(CGFloat angle)
 CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
 CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
 */


#pragma mark - 3D变幻
/*
 CATransform3DMakeRotation(CGFloat angle, CGFloat x, CGFloat y, CGFloat z)
 CATransform3DMakeScale(CGFloat sx, CGFloat sy, CGFloat sz)
 CATransform3DMakeTranslation(Gloat tx, CGFloat ty, CGFloat tz)
 */
- (void)transform3D
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 =  10.0 / 500.0; // 设置透视投影
//    transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    
    UIImage *flower = [UIImage imageNamed:@"test"];
    redView.layer.contents = (__bridge id)flower.CGImage;
    redView.layer.transform = transform;
}

@end
