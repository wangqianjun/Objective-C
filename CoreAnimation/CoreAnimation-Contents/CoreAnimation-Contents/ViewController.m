//
//  ViewController.m
//  CoreAnimation-Contents
//
//  Created by 王钱钧 on 15/3/18.
//  Copyright (c) 2015年 王钱钧. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *layerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)initViews
{
    self.layerView = [[UIView alloc]init];
    self.layerView.frame = CGRectInset(self.view.bounds, 40, 80);
    self.layerView.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"test"];
    
    //我们利用CALayer在一个普通的UIView中显示了一张图片。这不是一个UIImageView，它不是我们通常用来展示图片的方法。通过直接操作图层，我们使用了一些新的函数，使得UIView更加有趣了。
    self.layerView.layer.contents = (__bridge id)(image.CGImage);
    
    //设置适应性
    //和view的contentMode类似，CALayer拥有contentsGravity属性
    self.layerView.layer.contentsGravity = kCAGravityCenter;
    
    
    //当用代码的方式来处理寄宿图的时候，一定要记住要手动的设置图层的contentsScale属性，否则，你的图片在Retina设备上就显示得不正确啦。
    
    NSLog(@"image.scale = %f, mainScreen.scale = %f", image.scale, [[UIScreen mainScreen] scale]);
    self.layerView.layer.contentsScale = [[UIScreen mainScreen] scale];
    
    
#pragma mark - masksToBounds
    
    self.layerView.layer.masksToBounds = YES;

#pragma mark -contentsRect
    
    /*
     CALayer的contentsRect属性允许我们在图层边框里显示寄宿图的一个子域。这涉及到图片是如何显示和拉伸的，所以要比contentsGravity灵活多了
     和bounds，frame不同，contentsRect不是按点来计算的，它使用了单位坐标，单位坐标指定在0到1之间，是一个相对值（像素和点就是绝对值）。所以他们是相对与寄宿图的尺寸的
     */
    self.layerView.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
    
    [self.view addSubview:self.layerView];
    
    [self.view setBackgroundColor:[UIColor grayColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
