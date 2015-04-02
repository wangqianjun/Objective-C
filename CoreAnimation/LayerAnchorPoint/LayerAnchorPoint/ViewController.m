//
//  ViewController.m
//  LayerAnchorPoint
//
//  Created by 王钱钧 on 15/4/1.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

/*
 http://wonderffee.github.io/blog/2013/10/13/understand-anchorpoint-and-position/
 
 position是layer中的anchorPoint点在superLayer中的位置坐标
 position点是相对suerLayer的，anchorPoint点是相对layer的
 两者是相对不同的坐标空间的一个重合点。
 
 1、position是layer中的anchorPoint在superLayer中的位置坐标。
 2、互不影响原则：单独修改position与anchorPoint中任何一个属性都不影响另一个属性。
 3、frame、position与anchorPoint有以下关系：

 frame.origin.x = position.x - anchorPoint.x * bounds.size.width；
 frame.origin.y = position.y - anchorPoint.y * bounds.size.height；
 
 
 */

#import "ViewController.h"

@interface ViewController ()
{

    CALayer *blueLayer;
    
    UIView *sprite1;
    UIView *sprite2;
    UIView *sprite3;
    
    NSMutableArray *digitViews;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self prepareImage];
}

- (void)initViews {
 
    [self.view setBackgroundColor:[UIColor grayColor]];
    sprite1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 100, 100, 100)];
    sprite2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sprite1.frame) + 10, CGRectGetMinY(sprite1.frame), 100, 100)];
    
    sprite3 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sprite2.frame) + 10, CGRectGetMinY(sprite1.frame), 100, 100)];
    
    
    [sprite1 setBackgroundColor:[UIColor whiteColor]];
    [sprite2 setBackgroundColor:[UIColor whiteColor]];
    [sprite3 setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:sprite1];
    [self.view addSubview:sprite2];
    [self.view addSubview:sprite3];
    
    UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    UIView *greenView = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    
    blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(0, 200, 100, 100);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:blueLayer];
    
    redView.backgroundColor = [UIColor redColor];
    greenView.backgroundColor = [UIColor greenColor];
    
    redView.layer.zPosition = 1.0f;
    //    redView.layer.anchorPointZ = 1.0f;
    
    [self.view addSubview:redView];
    
    [self.view addSubview:greenView];

    //    redView.layer.anchorPoint = CGPointMake(0, 0);
    //    redView.layer.position = CGPointMake(100, 100);

    //    NSLog(@"anchor point = %@", NSStringFromCGPoint(redView.layer.anchorPoint));
    // Do any additional setup after loading the view, typically from a nib.

    [self initDigitViews];
    [self initButtons];
}

- (void)initDigitViews {
    digitViews = [NSMutableArray array];
    UIImage *digits = [UIImage imageNamed:@"time"];
    for (int i = 0; i<6; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(40*i, 400, 30, 50)];
        
        view.backgroundColor = [UIColor clearColor];
        view.layer.contents = (__bridge id)digits.CGImage;
        view.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.0);
        view.layer.contentsGravity = kCAGravityResizeAspect;
        
        [digitViews addObject:view];
        [self.view addSubview:view];
    }
    
    //start timer
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    //set initial clock time
    [self tick];
}

- (void)initButtons
{
    UIButton *button1 = [self customButton];
    button1.center = self.view.center;
    
    button1.alpha = 0.5;
    
    [self.view addSubview: button1];
    
    
}

- (void)tick
{
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    
    //set hours
    [self setDigit:components.hour / 10 forView:digitViews[0]];
    [self setDigit:components.hour % 10 forView:digitViews[1]];
    
    //set minutes
    [self setDigit:components.minute / 10 forView:digitViews[2]];
    [self setDigit:components.minute % 10 forView:digitViews[3]];
    
    //set seconds
    [self setDigit:components.second / 10 forView:digitViews[4]];
    [self setDigit:components.second % 10 forView:digitViews[5]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDigit:(NSInteger)digit forView:(UIView *)view
{
    //adjust contentsRect to select correct digit
    view.layer.contentsRect = CGRectMake(digit * 0.1, 0, 0.1, 1.0);
}

//CALayer并不关心任何响应链事件，所以不能直接处理触摸事件或者手势
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    
    CALayer *layer = [blueLayer hitTest:point];
//    point = [blueLayer convertPoint:point fromLayer:self.view.layer];
//    
//    // containsPoint 根据点击位置判断
//    if ([blueLayer containsPoint:point]) {
//        [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer"
//                                    message:nil
//                                   delegate:nil
//                          cancelButtonTitle:@"OK"
//                          otherButtonTitles:nil] show];
//    }
    
    // hitTest 返回被点击的图层
    
    if (layer == blueLayer) {
        [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}



- (void)prepareImage {
    UIImage *image = [UIImage imageNamed:@"test"];
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 0.3, 1) toLayer:sprite1.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0.3, 0, 0.6, 1) toLayer:sprite2.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0.6, 0, 1, 1) toLayer:sprite3.layer];
    
    
}


#pragma mark -加载一张大图，然后进行裁剪，这样就防止平凡的读写磁盘造成性能问题
- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer
{
    layer.contents = (__bridge id)image.CGImage;
    
    // scale content to fit
    layer.contentsGravity = kCAGravityResizeAspect;

    // 裁剪图片
    // set contentRect
    layer.contentsRect = rect;
}


#pragma mark - 过滤拉伸
/*
 
 http://zsisme.gitbooks.io/ios-/content/chapter4/scaling-filters.html
 
 CALayer为此提供了三种拉伸过滤方法:
 
 kCAFilterLinear 双线性滤波算法
 kCAFilterNearest
 kCAFilterTrilinear 三线性滤波算法
 */


#pragma mark - 组透明
/*
 当你显示一个50%透明度的图层时，图层的每个像素都会一般显示自己的颜色，另一半显示图层下面的颜色。这是正常的透明度的表现。但是如果图层包含一个同样显示50%透明的子图层时，你所看到的视图，50%来自子视图，25%来了图层本身的颜色，另外的25%则来自背景色。
 
 CALayer的一个叫做shouldRasterize属性
 */
- (UIButton *)customButton
{
    CGRect frame = CGRectMake(0, 0, 150, 50);
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 10;
    
    button.layer.shouldRasterize = YES;
    button.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // add label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
//    label.backgroundColor = [UIColor redColor];
    label.text = @"Hello world";
    label.textAlignment = NSTextAlignmentCenter;
    
    [button addSubview:label];

    return button;
}

@end
