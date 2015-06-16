//
//  ViewController.m
//  OC-Template
//
//  Created by 王钱钧 on 15/6/16.
//  Copyright (c) 2015年 YOHO！. All rights reserved.
//

#import "ViewController.h"
#import "Stack.h"

//http://blog.sunnyxx.com/2015/06/12/objc-new-features-in-2015/

@interface ViewController ()
@property (nonatomic, strong) Stack *stack;
@property (nonatomic, strong) Stack<NSString *> *stringStack;
@property (nonatomic, strong) Stack<NSMutableString *> *mutlStringStack;
@property (nonatomic, strong) Stack<id<NSCopying>> *copingStack;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stringStack = [[Stack alloc]init];
    [self.stringStack pushObject:@"first"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//协变性和逆变性
- (void)foo {
    
    //不指定泛型类型的 Stack 可以和任意泛型类型转化
    self.stack = self.stringStack;
    self.stack = self.mutlStringStack;
    
    //但指定了泛型类型后，两个不同类型间是不可以强转的
    self.stringStack = self.stack;
    self.stringStack = self.mutlStringStack;
    

    //假如你希望主动控制转化关系，就需要使用泛型的协变性和逆变性修饰符了：
    /*
     __covariant - 协变性，子类型可以强转到父类型（里氏替换原则）
     __contravariant - 逆变性，父类型可以强转到子类型（WTF?）
     */
    
}
@end
