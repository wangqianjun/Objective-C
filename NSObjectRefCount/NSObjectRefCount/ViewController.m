//
//  ViewController.m
//  NSObjectRefCount
//
//  Created by 王钱钧 on 15/11/5.
//  Copyright © 2015年 王钱钧. All rights reserved.
//

#import "ViewController.h"
#import <CoreFoundation/CoreFoundation.h>

struct FooStuct {
    NSMutableArray *arr;
};

int resultFunc(int count)
{
    return count;
}

@interface ViewController ()
@property (assign, nonatomic) id __weak obj;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.obj = [[NSObject alloc]init];
//    
//    NSLog(@"retain count = %lu", [self.obj retainCount]);
//    
//    self.obj = nil;
//    [self.obj dealloc];
//    
//    NSLog(@"retain count = %lu", [self.obj retainCount]);
//    NSLog(@"obj = %p", self.obj);

//    [self autoReleasePool];
    

    [self weakVar];
//        [self strongVar];

//    [self unsafeUnretained];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)autoReleasePool
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    

    @autoreleasepool {
        for (int i = 0; i<10; i++) {
            
            id obj = [[[NSObject alloc]init] autorelease];
            
            NSLog(@"retain count = %lu", [obj retainCount]);
            
            //    [pool addObject:obj];
            
            
            NSLog(@"retain count = %lu", [obj retainCount]);
            
            
            NSLog(@"obj = %p", obj);
            
            
            [arr addObject:obj];
            
//            obj = nil;
            [obj release];
                    NSLog(@"retain count = %lu", [obj retainCount]);
            
        }
    }
    

    
//    NSLog(@"arr = %@", arr);
}

- (void)strongVar
{
    id __strong obj0 = [[NSObject alloc]init];
    id __strong obj1 = [[NSObject alloc]init];
    id __strong obj2 = nil;
    
    obj0 = obj1;
    obj2 = obj0;
    
    obj1 = nil;
    obj0 = nil;
    obj2 = nil;
    
}

- (void)weakVar
{
//    id __strong obj = [[NSObject alloc]init];
//    
//   __weak id weakObj = obj;
//    
////    self.obj = weakObj;
//    obj = nil;
//    
//    NSLog(@"weak obj = %@", weakObj);
    
    id  __strong obj = [[NSObject alloc]init];
    _objc_autoreleasePoolPrint();
    id __weak o = obj;
    NSLog(@"count: %d",_objc_rootRetainCount(obj));
    NSLog(@"class=%@",[o class]);
    NSLog(@"count: %d",_objc_rootRetainCount(obj));
    _objc_autoreleasePoolPrint();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)unsafeUnretained
{
    id __unsafe_unretained obj1 = nil;
    
    if (YES) {
        id __strong obj0 = [[NSObject alloc]init];
        obj1 = obj0;
        NSLog(@"a :%@", obj1);
    }
    
    NSLog(@"b :%@",obj1);
}

- (void)autoreleasing
{
    __autoreleasing
}

- (void)performOperationWithError:(NSError * __autoreleasing *)error
{
    *error = [[NSError alloc]initWithDomain:@"error domain" code:0 userInfo:@{}];
    
}

- (void)voidPtr
{
    id obj = [[NSObject alloc]init];
    
    void *ptr = obj;
}

- (void)bridging
{

}

- (void)ptr
{
    int (*funcptr)(int) = &resultFunc;
    
    int result = (*funcptr)(10);
    
    
}

int * ptrFunc(int x, int y)
{
    int result = 0;
    return &result;
}

@end
