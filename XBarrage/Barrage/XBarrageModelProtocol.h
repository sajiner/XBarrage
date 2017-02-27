//
//  XBarrageModelProtocol.h
//  XBarrage
//
//  Created by sajiner on 2017/2/27.
//  Copyright © 2017年 sajiner. All rights reserved.
//

@protocol XBarrageModelProtocol <NSObject>

@required
/// 弹幕的开始时间
@property (nonatomic, assign, readonly) NSTimeInterval beginTime;
/// 弹幕的存活时间
@property (nonatomic, assign, readonly) NSTimeInterval liveTime;

@end
