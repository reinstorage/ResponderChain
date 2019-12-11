//
//  TopView.m
//  ResponderChainDemo
//
//  Created by Simon on 2019/12/11.
//  Copyright © 2019 Simon. All rights reserved.
//

#import "TopView.h"
#import "UIResponder+Router.h"

@interface TopView()

@property (nonatomic, strong) UILabel *testLabelA;
@property (nonatomic, strong) UILabel *testLabelB;
@property (nonatomic, strong) UILabel *testLabelC;

@end

@implementation TopView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    [self addSubview:self.testLabelA];
    [self addSubview:self.testLabelB];
    [self addSubview:self.testLabelC];
    
    UITapGestureRecognizer *tapA = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickLabelTapA)];
    [self.testLabelA addGestureRecognizer:tapA];
    
    UITapGestureRecognizer *tapB = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickLabelTapB)];
    [self.testLabelB addGestureRecognizer:tapB];
    
    UITapGestureRecognizer *tapC = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickLabelTapC)];
    [self.testLabelC addGestureRecognizer:tapC];
    
}

-(void)didClickLabelTapA{
    [self routerEventWithName:@"evevta" userInfo:@{@"key":@"a"}];
}

-(void)didClickLabelTapB{
    [self routerEventWithName:@"evevtb" userInfo:@{@"key":@"b"}];
}

-(void)didClickLabelTapC{
    [self routerEventWithName:@"evevtc" userInfo:@{@"key":@"c"}];
}


-(UILabel *)testLabelA{
    if (!_testLabelA) {
        _testLabelA = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 100, 50)];
        _testLabelA.textColor = [UIColor redColor];
        _testLabelA.font = [UIFont boldSystemFontOfSize:18];
        _testLabelA.userInteractionEnabled = YES;
        _testLabelA.text = @"点击事件 A";
    }
    return _testLabelA;
}

-(UILabel *)testLabelB{
    if (!_testLabelB) {
        _testLabelB = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 100, 50)];
        _testLabelB.textColor = [UIColor yellowColor];
        _testLabelB.font = [UIFont boldSystemFontOfSize:18];
        _testLabelB.userInteractionEnabled = YES;
        _testLabelB.text = @"点击事件 B";
    }
    return _testLabelB;
}

-(UILabel *)testLabelC{
    if (!_testLabelC) {
        _testLabelC = [[UILabel alloc] initWithFrame:CGRectMake(30, 150, 100, 50)];
        _testLabelC.textColor = [UIColor purpleColor];
        _testLabelC.font = [UIFont boldSystemFontOfSize:18];
        _testLabelC.userInteractionEnabled = YES;
        _testLabelC.text = @"点击事件 C";
    }
    return _testLabelC;
}


@end
