//
//  LSSTwoBallLoading.m
//  LSSTwoCycleLoading
//
//  Created by 连帅帅 on 2018/10/19.
//  Copyright © 2018年 连帅帅. All rights reserved.
//

#import "LSSTwoBallLoading.h"
#import "Masonry.h"
#define kDistance 10//轨道半径
#define kLSS_SH [UIScreen mainScreen].bounds.size.height
#define kLSS_SW [UIScreen mainScreen].bounds.size.width
#define kCgpoint  CGPointMake(kLSS_SW*0.5, kLSS_SH*0.5)
@implementation LSSTwoBallTool
-(instancetype)init{
    
    if ([super init]) {
     
        
    }
    return self;
}
@end


@interface LSSTwoBallLoading ()

@property(nonatomic,strong)LSSTwoBallTool * ballTool;
@property (nonatomic,strong) CAShapeLayer *oneLayer;
@property (nonatomic,strong) CAShapeLayer *twoLayer;
@end


@implementation LSSTwoBallLoading
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //添加两个CAShapeLayer
        [self.layer addSublayer:self.oneLayer];

        [self.layer addSublayer:self.twoLayer];
    }
    return self;
}

+(void)showLoading:(UIView *)view andTool:(LSSTwoBallTool *)tool{
    [self hideLoading:view];
    LSSTwoBallLoading * ballLoading = [[LSSTwoBallLoading alloc]init];
    ballLoading.backgroundColor = [UIColor clearColor];
    ballLoading.ballTool = tool;
    [view addSubview:ballLoading];
    [ballLoading mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.centerY.equalTo(view);
        make.width.equalTo(@(kLSS_SW));
        make.height.equalTo(@(kLSS_SH));
    }];
    //开始动画
    [ballLoading startAnimaton];
}

-(void)setBallTool:(LSSTwoBallTool *)ballTool{
    
    _ballTool = ballTool;
    self.oneLayer.fillColor = ballTool.oneBallCor.CGColor;
    self.twoLayer.fillColor = ballTool.twoBallCor.CGColor;
}
+(void)hideLoading:(UIView *)view{
    
    for (LSSTwoBallLoading *loading in view.subviews) {
        if ([loading isKindOfClass:[LSSTwoBallLoading class]]) {
            [loading stopAnimation];
            [loading removeFromSuperview];
        }
    }
}


#pragma mark--private
//开始动画
-(void)startAnimaton{
    [self setUpOneBallAnimation];
    [self setUpTwoBallAnimation];
}
//停止动画
-(void)stopAnimation{
    
    [self.oneLayer removeAllAnimations];
    [self.twoLayer removeAllAnimations];
    [self.oneLayer removeFromSuperlayer];
    [self.twoLayer removeFromSuperlayer];
}
//第一个球的动画
-(void)setUpOneBallAnimation{
    
   
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.z"];
    transformAnimation.values = @[@1,@0,@0,@0,@1];
    
     //位移动画
    CAKeyframeAnimation * frameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef  path = CGPathCreateMutable();
    //添加起始位置
    CGPathMoveToPoint(path, NULL, kCgpoint.x, kCgpoint.y);
    //添加路径
    CGPathAddLineToPoint(path, NULL, kCgpoint.x + kDistance , kCgpoint.y);
    CGPathAddLineToPoint(path, NULL, kCgpoint.x, kCgpoint.y);
    CGPathAddLineToPoint(path, NULL, kCgpoint.x - kDistance, kCgpoint.y);
    CGPathAddLineToPoint(path, NULL, kCgpoint.x, kCgpoint.y);
    [frameAnimation setPath:path];
    
    //缩放动画
    CAKeyframeAnimation * scacelAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scacelAnimation.values = @[@1,@0.5,@0.25,@0.5,@1];
    
    //透明度动画
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = @[@1,@0.5,@0.25,@0.5,@1];
    
    //组合动画
    CAAnimationGroup * gropAnimation = [CAAnimationGroup animation];
    gropAnimation.animations = @[transformAnimation,frameAnimation,scacelAnimation,opacityAnimation];
    gropAnimation.duration = 1.5;
    gropAnimation.repeatCount = MAXFLOAT;
    [self.oneLayer addAnimation:gropAnimation forKey:@"oneGroup"];
}

//第二个球的动画
-(void)setUpTwoBallAnimation{
    
    
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.z"];
    transformAnimation.values = @[@0,@0,@1,@0,@0];
    
    //位移动画
    CAKeyframeAnimation * frameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef  path = CGPathCreateMutable();
    //添加起始位置
    CGPathMoveToPoint(path, NULL, kCgpoint.x, kCgpoint.y);
    //添加路径
    CGPathAddLineToPoint(path, NULL, kCgpoint.x - kDistance , kCgpoint.y);
    CGPathAddLineToPoint(path, NULL, kCgpoint.x, kCgpoint.y);
    CGPathAddLineToPoint(path, NULL, kCgpoint.x + kDistance, kCgpoint.y);
    CGPathAddLineToPoint(path, NULL, kCgpoint.x, kCgpoint.y);
    [frameAnimation setPath:path];
    
    //缩放动画
    CAKeyframeAnimation * scacelAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scacelAnimation.values =@[@0.25,@0.5,@1,@0.5,@0.25];
    
    //透明度动画
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values =@[@0.25,@0.5,@1,@0.5,@0.25];
    
    //组合动画
    CAAnimationGroup * gropAnimation = [CAAnimationGroup animation];
    gropAnimation.animations = @[transformAnimation,frameAnimation,scacelAnimation,opacityAnimation];
    gropAnimation.duration = 1.5;
    gropAnimation.repeatCount = MAXFLOAT;
    [self.twoLayer addAnimation:gropAnimation forKey:@"twoGroup"];
}
#pragma mark--getters and setters
//第一个圈
-(CAShapeLayer *)oneLayer{
    
    if (!_oneLayer) {
        
        _oneLayer = [CAShapeLayer layer];
        _oneLayer.frame = CGRectMake(0,0, kLSS_SW, kLSS_SH);
        _oneLayer.fillColor = [UIColor redColor].CGColor;
        _oneLayer.path = [UIBezierPath bezierPathWithArcCenter:kCgpoint radius:10 startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;

    }
    return _oneLayer;
}

//第二个圈
-(CAShapeLayer *)twoLayer{
    
    if (!_twoLayer) {
        
        _twoLayer = [CAShapeLayer layer];
        _twoLayer.frame = CGRectMake(0,0, kLSS_SW, kLSS_SH);
        _twoLayer.fillColor = [UIColor blueColor].CGColor;
        _twoLayer.path = [UIBezierPath bezierPathWithArcCenter:kCgpoint radius:10 startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
    }
    return _twoLayer;
}
@end
