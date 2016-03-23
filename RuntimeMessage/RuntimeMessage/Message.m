//
//  Message.m
//  RuntimeMessage
//
//  Created by 王钱钧 on 16/3/22.
//  Copyright © 2016年 ASE. All rights reserved.
//

#import "Message.h"
#import <objc/runtime.h>
#import "FakeMessage.h"

static void dynamicMethodIMP(id self, SEL _cmd) {
    NSLog(@"dynamic-> \n self: %@ \n SEL: %s", self, _cmd);
}

@implementation Message

+ (BOOL)resolveClassMethod:(SEL)sel
{
    NSLog(@"%s", __func__);
    
    return [super resolveClassMethod:sel];
}


/*
 结合NSObject文档可以知道，_objc_msgForward消息转发做了如下几件事：
 1.调用resolveInstanceMethod:方法，允许用户在此时为该Class动态添加实现。如果有实现了，则调用并返回。如果仍没实现，继续下面的动作。
 */

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"%s", __func__);
    
//    if (sel == @selector(sendMessage:)) {
//        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "");
//    }
    
    return [super resolveInstanceMethod:sel];
}

/*
 2.调用forwardingTargetForSelector:方法，尝试找到一个能响应该消息的对象。如果获取到，则直接转发给它。如果返回了nil，继续下面的动作。
 */

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSLog(@"%s", __func__);
    
    
    // 可以把消息转发给另一个对象
//    return [[FakeMessage alloc]init];
    
    return nil;
}


/*
3. 调用methodSignatureForSelector:方法，尝试获得一个方法签名。如果获取不到，则直接调用doesNotRecognizeSelector抛出异常。
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSLog(@"%s", __func__);
    
    
    // 重定向为 unrecognizedSelector: 方法
    SEL unrecognizedSelector = @selector(unrecognizedSelector:);
    NSMethodSignature *methodSig = [[self class] instanceMethodSignatureForSelector:unrecognizedSelector];
    
    return methodSig;
}


/*
 4.调用forwardInvocation:方法，将地3步获取到的方法签名包装成Invocation传入，如何处理就在这里面了。
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"%s", __func__);
    
    FakeMessage *aFakeMessage = [[FakeMessage alloc]init];
    if ([aFakeMessage respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:aFakeMessage];
    } else {
        [super forwardInvocation:anInvocation];
    }
    
}

- (void)unrecognizedSelector:(SEL)sel
{
    NSLog(@"%s", __func__);
    
    NSLog(@"unrecognized method");


}

@end


