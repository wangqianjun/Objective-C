//
//  ViewController.m
//  TestBundle
//
//  Created by 王钱钧 on 15/1/16.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UIView *redView;
@property (strong, nonatomic)  UIImageView *imageView ;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@interface UIImage (YOHO)
+ (UIImage *)patternImageWithColor:(UIColor *)color;
@end

@implementation UIImage (YOHO)
+ (UIImage *)patternImageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1.0f, 1.0f), NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color set];
    CGContextFillRect(context, CGRectMake(0.0f, 0.0f, 1.0f, 1.0f));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMood];
    
    [self setSearch];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initMood {
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"mood.bundle"];
    NSArray *moods = [fm contentsOfDirectoryAtPath:bundlePath error:&error];
    NSString *filePath = [bundlePath stringByAppendingPathComponent:[moods objectAtIndex:0]];
    
    
    NSBundle *moodBoundle = [NSBundle bundleWithPath:bundlePath];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 320, 100)];
//    [self.imageView setImage:[UIImage imageNamed:@"[爱你].png" inBundle:moodBoundle compatibleWithTraitCollection:nil]];
    UIImage *image = [UIImage patternImageWithColor:[UIColor redColor]];
    [self.imageView setImage: image];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tapGR.numberOfTapsRequired = 1;
    [self.imageView setUserInteractionEnabled:YES];
    [self.imageView addGestureRecognizer:tapGR];
    
    //initWithImage:[UIImage imageNamed:@"[爱你].png"]];;
    
    [self.view addSubview:self.imageView];
    
    
    self.redView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, 300, 100)];
    [self.redView setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:self.redView];


}

- (void)setSearch {
    [self.searchBar setImage:[UIImage imageNamed:@"shared_face_icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
//    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"image0"]];// 设置背景图片
//    [self.searchBar setSearchFieldBackgroundImage:[self patternImageWithColor:[UIColor colorWithRed:0.914 green:0.925 blue:0.925 alpha:1.000]] forState:UIControlStateNormal];
//
    [self.searchBar setShowsScopeBar:YES];
    [self.searchBar setReturnKeyType:UIReturnKeyGo];
    [self.searchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"Singer",@"Song",@"Album", nil]];
    [self.searchBar setPlaceholder:@"选择心情                                                                    "];
    UIView *markView = [[UIView alloc] initWithFrame:self.view.bounds];
    [markView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
//    [self.searchBar setInputAccessoryView:markView];
}

- (void)tap:(UITapGestureRecognizer *)recognizer {
    UIImageView *view = (UIImageView *)recognizer.view;
    CGPoint point = [view convertPoint:[recognizer locationInView:view] toView:view];
    NSLog(@"point = %@",NSStringFromCGPoint(point));
    
    [self.searchBar setImage:self.imageView.image forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    
}


@end
