//
//  CALayer+XAnimation.m
//  XBarrage
//
//  Created by sajiner on 2017/2/28.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "CALayer+XAnimation.h"

@implementation CALayer (XAnimation)

- (void)pauseAnimate {
    CFTimeInterval pauseTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0;
    self.timeOffset = pauseTime;
}

- (void)resumeAnimate {
    CFTimeInterval pauseTime = self.timeOffset;
    self.speed = 1.0;
    self.timeOffset = 0;
    self.beginTime = 0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    self.beginTime = timeSincePause;
}

@end
