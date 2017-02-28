//
//  ViewController.m
//  XBarrage
//
//  Created by sajiner on 2017/2/27.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "ViewController.h"
#import "XBarrageView.h"
#import "XBarrageModel.h"

@interface ViewController ()<XBarrageViewProtocol>

@property (nonatomic, weak) XBarrageView *barrageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XBarrageView *barrageView = [[XBarrageView alloc] initWithFrame:CGRectMake(50, 100, 250, 200)];
    barrageView.backgroundColor = [UIColor orangeColor];
    barrageView.delegate = self;
    _barrageView = barrageView;
    [self.view addSubview:barrageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    XBarrageModel *model1 = [[XBarrageModel alloc] init];
    model1.beginTime = 3;
    model1.liveTime = 5;
    model1.content = @"你好啦反馈过";
    [self.barrageView.models addObject:model1];
    
    XBarrageModel *model2 = [[XBarrageModel alloc] init];
    model2.beginTime = 3.2;
    model2.liveTime = 8;
    model2.content = @"哈哈😄";
    [self.barrageView.models addObject:model2];
}

- (IBAction)pause:(UIButton *)sender {
    [self.barrageView pause];
}

- (IBAction)resume:(UIButton *)sender {
    [self.barrageView resume];
}

#pragma mark - XBarrageViewProtocol
- (UIView *)barrageViewWithModel:(XBarrageModel *)model {
    UILabel *label = [UILabel new];
    label.text = model.content;
    [label sizeToFit];
    return label;
}

- (void)barrageViewDidClick:(XBarrageView *)barrageView at:(CGPoint)point {
    NSLog(@"%@ %@", barrageView, NSStringFromCGPoint(point));
}

- (NSTimeInterval)currentTime {
    static double time = 0;
    time += 0.1;
    return time;
}

@end
