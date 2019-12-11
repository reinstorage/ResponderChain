# ResponderChain
一种基于ResponsderChain的对象交互方式

### 由来
iOS的对象间传递方式有：直接property，delegate，KVO，block，protocol，多态，Target-Action。但有一天我翻阅技术文档时，发现了一种全新的交互方式，基于ResponsderChain实现对象间的交互。

这种方式通过在UIResponder上挂一个category，使得事件和参数可以沿着responder chain逐步传递。相当于借用UIResponder chain实现一个自己的事件传递，这才事件需要层层传递的时候特别好用，但这种对象交互方式的有效场景仅限于在responder chain 上的UIResponder对象上。

### 实现

仅需要一个categroy就可以实现基于ResponderChain的对象交互

.h文件

```
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END

```

.m文件

```
#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
```

发送事件时：
 
```
[self routerEventWithName:@"evevta" userInfo:@{@"key":@"a"}];
```
响应事件时：

```
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{

     

    // 如果需要让事件继续往上传递，则调用下面的语句
    // [super routerEventWithName:eventName userInfo:userInfo];
}

```
 
在上面的代码中，如果事件来源多个，就无法避免需要if-else语句来针对具体事件作相应的处理。这种情况会导致if-else极多，所以可以考虑用NSInvocation来消除if-else ：

```
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{

    // 如果需要让事件继续往上传递，则调用下面的语句
    // [super routerEventWithName:eventName userInfo:userInfo];
    
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation setArgument:&userInfo atIndex:2];
    [invocation invoke];
    
}
```
self.eventStrategy是一个字典 存在于事件接受的类中，这个字典以eventName作Key，对应的处理逻辑封装到NSInvocation来做value

```
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

```
这样就可以避免冗长的if-else，具体请下载demo查看。

### 分析

这种对象交互方式的缺点显而易见，它只能对存在于Responder Chain上的UIResopnder对象期作用。

优点也蛮多的：
* 以前靠delegate层层传递的方案，可以改为这种基于Responder Chain的方式来传递。在复杂UI层级的页面中，这种方式可以避免无谓的delegate声明。
* 由于众多自定义事件都通过这种方式做了传递，就使得事件处理的逻辑得到归拢。在这方法里面下断点就能够管理所有的事件。
* 使用Strategy模式（策略模式用NSInvocation来实现）优化之后，UIViewController/UIView的事件相应逻辑得到了很好的管理，相应逻辑不会零散到各处地方。
