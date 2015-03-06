//
//  MyProxy.h
//  NSProxy
//
//  Created by 王钱钧 on 15/3/5.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginHandlerProtocol.h"
#import "MessageHandlerProtocol.h"

@interface AppProxy : NSProxy<LoginHandlerProtocol, MessageHandlerProtocol>

+ (instancetype)sharedProxy;

- (void)registerHandlerProtocol:(Protocol *)protocol handler:(id)handler;

@end
