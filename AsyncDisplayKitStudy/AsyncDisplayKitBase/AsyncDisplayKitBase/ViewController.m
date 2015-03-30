//
//  ViewController.m
//  AsyncDisplayKitBase
//
//  Created by 王钱钧 on 15/3/26.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>

/*
 注意设置链接器（Other linker flags）添加 -l"Pods-AsyncDisplayKit"
 */

#import <AsyncDisplayKit/AsyncDisplayKit.h>

#import <AsyncDisplayKit/ASTextNode.h>

void f(void) __attribute__((availability(macosx,introduced=10.4,deprecated=10.6,obsoleted=10.7)));

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:13.0f],
                            NSForegroundColorAttributeName:[UIColor redColor]
                            };
    
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"hello async kit" attributes:attrs];
    
    ASTextNode *textNode = [[ASTextNode alloc]init];

    
    textNode.attributedString = attrStr;
    
// size all the things
    CGRect b = self.view.bounds; // convenience
    CGSize size = [textNode measure:CGSizeMake(b.size.width, FLT_MAX)];
    CGPoint origin = CGPointMake(roundf( (b.size.width - size.width) / 2.0f ),
                                 roundf( (b.size.height - size.height) / 2.0f ));
    textNode.frame = (CGRect){ origin, size };
    

  [self.view addSubview:textNode.view];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
