//
//  ViewController.m
//  CAShapeLayer
//
//  Created by 王钱钧 on 15/3/23.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"
#define LARGE_RADIUS  20
#define SMALL_RADIUS  10

CGFloat RADIANS(CGFloat digree) {
    return digree * M_PI / 180;
}

@interface ViewController ()
{
    UIBezierPath *whiteCircle;
    UIBezierPath *largeCircle;
    UIBezierPath * orangeWedge;
    UIBezierPath *yellowWedge;
    UIBezierPath *greenWedge;
    CADisplayLink *displayLink;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat heigth = CGRectGetHeight(self.view.bounds);
    
    //create path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0, heigth)];
    
    [path addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:CGPointMake(30, heigth/2)];

//    [path addArcWithCenter:CGPointMake(width/2, 0) radius:width/2 startAngle:2*M_PI endAngle:M_PI clockwise:YES];
    
    [path addArcWithCenter:CGPointMake(width/2, 0) radius:width/4 startAngle:M_PI endAngle:2*M_PI clockwise:NO];
    [path addQuadCurveToPoint:CGPointMake(width, heigth) controlPoint:CGPointMake(width-30, heigth/2)];
    
    [path addArcWithCenter:CGPointMake(width/2, heigth) radius:width/4 startAngle:2*M_PI endAngle:M_PI clockwise:NO];
    
    
    
//    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:M_PI clockwise:NO];
//    [path moveToPoint:CGPointMake(150, 125)];
//    [path addLineToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(125, 225)];
//    [path moveToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(175, 225)];
//    [path moveToPoint:CGPointMake(100, 150)];
//    [path addLineToPoint:CGPointMake(200, 150)];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor yellowColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    //add it to our view
    [self.view.layer addSublayer:shapeLayer];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidAppear:(BOOL)animated
{
//    if (displayLink == nil) {
//        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(createPaths)];
//        [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//    }
}


-(void) createPaths {
    largeCircle = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:LARGE_RADIUS startAngle:0 endAngle:RADIANS(360) clockwise:YES];
    whiteCircle = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:SMALL_RADIUS startAngle:0 endAngle:RADIANS(360) clockwise:YES];
    
    orangeWedge = [UIBezierPath bezierPath];
    [orangeWedge moveToPoint:self.view.center];
    
    double startAngle = RADIANS(45);
    double endAngle = RADIANS(135);
    
    [orangeWedge addLineToPoint:CGPointMake(sin(startAngle) + self.view.center.x, cos(startAngle) + self.view.center.y)];
    [orangeWedge addArcWithCenter:self.view.center radius:LARGE_RADIUS startAngle:startAngle endAngle:endAngle clockwise:YES];
    [orangeWedge addLineToPoint:self.view.center];
    
    startAngle = RADIANS(60);
    endAngle = RADIANS(120);
    
    yellowWedge = [UIBezierPath bezierPath];
    [yellowWedge moveToPoint:self.view.center];
    
    [yellowWedge addLineToPoint:CGPointMake(sin(startAngle) + self.view.center.x, cos(startAngle) + self.view.center.y)];
    [yellowWedge addArcWithCenter:self.view.center radius:LARGE_RADIUS startAngle:startAngle endAngle:endAngle clockwise:YES];
    [yellowWedge addLineToPoint:self.view.center];
    
    startAngle = RADIANS(75);
    endAngle = RADIANS(105);
    
    greenWedge = [UIBezierPath bezierPath];
    [greenWedge moveToPoint:self.view.center];
    
    [greenWedge addLineToPoint:CGPointMake(sin(startAngle) + self.view.center.x, cos(startAngle) + self.view.center.y)];
    [greenWedge addArcWithCenter:self.view.center radius:LARGE_RADIUS startAngle:startAngle endAngle:endAngle clockwise:YES];
    [greenWedge addLineToPoint:self.view.center];
}

@end
