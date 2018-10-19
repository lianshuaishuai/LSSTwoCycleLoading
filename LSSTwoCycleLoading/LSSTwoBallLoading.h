//
//  LSSTwoBallLoading.h
//  LSSTwoCycleLoading
//
//  Created by 连帅帅 on 2018/10/19.
//  Copyright © 2018年 连帅帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LSSTwoBallTool : NSObject
@property(nonatomic,strong)UIColor * oneBallCor;//第一个球的颜色
@property(nonatomic,strong)UIColor *twoBallCor;//第二个球的颜色
@end



@interface LSSTwoBallLoading : UIView
/**
 显示
 */
+(void)showLoading:(UIView *)view andTool:(LSSTwoBallTool *)tool;

/**
隐藏
 */
+(void)hideLoading:(UIView *)view;
@end
