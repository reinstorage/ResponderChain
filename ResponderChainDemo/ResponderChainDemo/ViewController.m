//
//  ViewController.m
//  ResponderChainDemo
//
//  Created by Simon on 2019/11/25.
//  Copyright © 2019 Simon. All rights reserved.
//
//参考文献
//https://casatwy.com/responder_chain_communication.html
#import "ViewController.h"
#import "MiddleView.h"
#import "TopView.h"

@interface ViewController ()

@property (nonatomic, strong) NSDictionary <NSString *, NSInvocation *> *eventStrategy;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MiddleView *middleView = [[MiddleView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 350)];
    middleView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:middleView];
    
    TopView *topView = [[TopView alloc] initWithFrame:CGRectMake(30, 50, self.view.frame.size.width - 60, 250)];
    topView.backgroundColor = [UIColor grayColor];
    [middleView addSubview:topView];
}

//MARK: event response
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{

    // 如果需要让事件继续往上传递，则调用下面的语句
//     [super routerEventWithName:eventName userInfo:userInfo];
    
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation setArgument:&userInfo atIndex:2];
    [invocation invoke];
    
}

-(void)responderChainA:(NSDictionary *)userInfo{
    NSLog(@"responderChainA = %@",userInfo);
}

-(void)responderChainB:(NSDictionary *)userInfo{
    NSLog(@"responderChainB = %@",userInfo);
}

-(void)responderChainC:(NSDictionary *)userInfo{
    NSLog(@"responderChainC = %@",userInfo);
}

//策略模式
- (NSDictionary <NSString *, NSInvocation *> *)eventStrategy
{
    //实际开发时,可以将KEY设置成全局变量,以防出错,代码也会更清晰
    if (_eventStrategy == nil) {
        _eventStrategy = @{
            @"evevta":[self createInvocationWithSelector:@selector(responderChainA:)],
            @"evevtb":[self createInvocationWithSelector:@selector(responderChainB:)],
            @"evevtc":[self createInvocationWithSelector:@selector(responderChainC:)]
        };
    }
    return _eventStrategy;
}


//实际开发时也可将此方法放入工具类中
-(NSInvocation *)createInvocationWithSelector:(SEL)sel{
    
    //1.通过方法调用者创建方法签名；此方法是NSObject 的方法
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:sel];
    //2.通过方法签名 生成NSInvocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    //3.对invocation设置 方法调用者
    [invocation setTarget:self];
    //4.对invocation设置 方法选择器
    [invocation setSelector:sel];
    
    return invocation;
}




@end
