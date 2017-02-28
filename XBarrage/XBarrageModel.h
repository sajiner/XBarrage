//
//  XBarrageModel.h
//  XBarrage
//
//  Created by sajiner on 2017/2/28.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBarrageModelProtocol.h"

@interface XBarrageModel : NSObject<XBarrageModelProtocol>

/// 弹幕的开始时间
@property (nonatomic, assign) NSTimeInterval beginTime;
/// 弹幕的存活时间
@property (nonatomic, assign) NSTimeInterval liveTime;

@property (nonatomic, copy) NSString *content;

@end
