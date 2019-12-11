//
//  UIResponder+Router.h
//  ResponderChainDemo
//
//  Created by Simon on 2019/11/25.
//  Copyright © 2019 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
