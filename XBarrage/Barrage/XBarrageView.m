//
//  XBarrageView.m
//  XBarrage
//
//  Created by sajiner on 2017/2/27.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "XBarrageView.h"

#define kClockDec 0.1
#define kLaneCount 6

@interface XBarrageView ()

@property (nonatomic, weak) NSTimer *clock;
/// 弹道的等待时间组
@property (nonatomic, strong) NSMutableArray *laneWaitTimes;
/// 弹道的存活时间组
@property (nonatomic, strong) NSMutableArray *laneLeftTimes;

@property (nonatomic, strong) NSMutableArray *barrageViews;

@end

@implementation XBarrageView

#pragma mark - 检查碰撞
- (void)checkAndCollided {
    
    // 实时更新弹道记录的时间信息
    for (int i = 0; i < kLaneCount; i++) {
        double waitValue = [self.laneWaitTimes[i] doubleValue] - kClockDec;
        if (waitValue <= 0) {
            waitValue = 0.0;
        }
        self.laneWaitTimes[i] = @(waitValue);
        
        double leftValue = [self.laneLeftTimes[i] doubleValue] - kClockDec;
        if (leftValue <= 0) {
            leftValue = 0.0;
        }
        self.laneLeftTimes[i] = @(leftValue);
    }
    // 对弹幕模型数组进行降序排列
    [self.models sortUsingComparator:^NSComparisonResult(id<XBarrageModelProtocol>  _Nonnull obj1, id<XBarrageModelProtocol>   _Nonnull obj2) {
        if (obj1.beginTime < obj2.beginTime) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    // 检测模型数组里的模型，是否可以发射，如果可以直接发射
    // 存储不符合的model
    NSMutableArray *deleteModels = [NSMutableArray array];
    for (id<XBarrageModelProtocol>model in self.models) {
        NSTimeInterval beginTime = model.beginTime;
        NSTimeInterval currentTime = self.delegate.currentTime;
        if (beginTime > currentTime) {
            break;
        }
        // 检测是否会发生碰撞
        BOOL result = [self checkBoomAndCollidedWith:model];
        if (result) {
            [deleteModels addObject:model];
        }
    }
    [self.models removeObjectsInArray:deleteModels];
}

- (BOOL)checkBoomAndCollidedWith: (id<XBarrageModelProtocol>)model {
    CGFloat laneH = self.frame.size.height / kLaneCount;
    for (int i = 0; i < kLaneCount; i++) {
        // 获取该弹道的绝对等待时间
        NSTimeInterval waitTime = [self.laneWaitTimes[i] doubleValue];
        if (waitTime > 0) {
            continue;
        }
        // 判断会不会与前面一个视图产生碰撞
        UIView *barrageView = [self.delegate barrageViewWithModel:model];
        NSTimeInterval leftTime = [self.laneLeftTimes[i] doubleValue];
        double speed = (barrageView.frame.size.width + self.frame.size.width) / model.liveTime;
        double distance = leftTime * speed;
        if (distance > self.frame.size.width) {
            continue;
        }
        [self.barrageViews addObject:barrageView];
        // 重置数据
        self.laneLeftTimes[i] = @(model.liveTime);
        self.laneWaitTimes[i] = @(barrageView.frame.size.width / speed);
        // 发射弹幕
        CGRect frame = barrageView.frame;
        frame.origin = CGPointMake(self.frame.size.width, laneH * i);
        barrageView.frame = frame;
        [self addSubview:barrageView];
        
        [UIView animateWithDuration:model.liveTime animations:^{
            CGRect frame = barrageView.frame;
            frame.origin.x = - barrageView.frame.size.width;
            barrageView.frame = frame;
        } completion:^(BOOL finished) {
            [barrageView removeFromSuperview];
            [self.barrageViews removeObject:barrageView];
        }];
        return YES;
    }
    return NO;
}

#pragma mark - life cycle
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    [self clock];
}

- (void)dealloc {
    [self.clock invalidate];
    self.clock = nil;
}

#pragma mark - lazy
- (NSTimer *)clock {
    if (!_clock) {
        NSTimer *clock = [NSTimer timerWithTimeInterval:kClockDec target:self selector:@selector(checkAndCollided) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:clock forMode:NSRunLoopCommonModes];
        _clock = clock;
    }
    return _clock;
}

- (NSMutableArray *)laneWaitTimes {
    if (!_laneWaitTimes) {
        _laneWaitTimes = [NSMutableArray array];
        for (int i = 0; i < kLaneCount; i ++) {
            _laneWaitTimes[i] = @0.0;
        }
    }
    return _laneWaitTimes;
}

- (NSMutableArray *)laneLeftTimes {
    if (!_laneLeftTimes) {
        _laneLeftTimes = [NSMutableArray array];
        for (int i = 0; i < kLaneCount; i ++) {
            _laneLeftTimes[i] = @0.0;
        }
    }
    return _laneLeftTimes;
}

- (NSMutableArray *)barrageViews {
    if (!_barrageViews) {
        _barrageViews = [NSMutableArray array];
    }
    return _barrageViews;
}

@end
