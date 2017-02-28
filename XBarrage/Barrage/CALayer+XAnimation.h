//
//  CALayer+XAnimation.h
//  XBarrage
//
//  Created by sajiner on 2017/2/28.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (XAnimation)
/**
 暂停动画
 */
- (void)pauseAnimate;

/**
 继续动画
 */
- (void)resumeAnimate;

@end
