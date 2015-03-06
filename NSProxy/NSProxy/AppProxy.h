//
//  MyProxy.h
//  NSProxy
//
//  Created by Arthur on 15/3/5.

//

#import <Foundation/Foundation.h>
#import "LoginHandlerProtocol.h"
#import "MessageHandlerProtocol.h"

@interface AppProxy : NSProxy<LoginHandlerProtocol, MessageHandlerProtocol>

+ (instancetype)sharedProxy;

- (void)registerHandlerProtocol:(Protocol *)protocol handler:(id)handler;

@end
