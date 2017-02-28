//
//  XBarrageView.h
//  XBarrage
//
//  Created by sajiner on 2017/2/27.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBarrageModelProtocol.h"

@class XBarrageView;
@protocol XBarrageViewProtocol <NSObject>
/// 当前时间
@property (nonatomic, assign, readonly) NSTimeInterval currentTime;

- (UIView *)barrageViewWithModel: (id<XBarrageModelProtocol>)model;
- (void)barrageViewDidClick: (XBarrageView *)barrageView at: (CGPoint)point;

@end

@interface XBarrageView : UIView

/// 弹幕模型数组
@property (nonatomic, strong) NSMutableArray<id <XBarrageModelProtocol>> *models;

@property (nonatomic, weak) id<XBarrageViewProtocol> delegate;

- (void)pause;
- (void)resume;

@end
