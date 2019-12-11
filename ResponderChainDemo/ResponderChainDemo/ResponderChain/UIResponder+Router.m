//
//  UIResponder+Router.m
//  ResponderChainDemo
//
//  Created by Simon on 2019/11/25.
//  Copyright © 2019 Simon. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
