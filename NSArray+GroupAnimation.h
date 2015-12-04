//
//  NSArray+GroupAnimation.h
//  PAGroupViewsAnimation
//
//  Created by DengJinlong on 12/4/15.
//  Copyright © 2015 dengjinlong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PAGroupViewAnimationModel.h"

@interface NSArray (GroupAnimation)

/*!
 @brief  给每个view设置frame动画
 */
- (void)animateViewsFromFrame:(CGRect)fromFrame toFrames:(NSArray *)toFrames completion:(void(^)(void))completion;
- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrame:(CGRect)toFrame completion:(void(^)(void))completion;
- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrames:(NSArray *)toFrames completion:(void(^)(void))completion;

- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrames:(NSArray *)toFrames duration:(CGFloat)duration interval:(CGFloat)interval completion:(void(^)(void))completion;

- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrames:(NSArray *)toFrames duration:(CGFloat)duration interval:(CGFloat)interval reverse:(BOOL)reverse completion:(void(^)(void))completion;

/*!
 @brief  以view中心点做为动画的参数
 */
- (void)animateViewsFromCenters:(NSArray *)fromCenters toCenters:(NSArray *)toCenters completion:(void (^)(void))completion;
- (void)animateViewsFromCenters:(NSArray *)fromCenters toCenters:(NSArray *)toCenters duration:(CGFloat)duration interval:(CGFloat)interval completion:(void(^)(void))completion;
- (void)animateViewsFromCenters:(NSArray *)fromCenters toCenters:(NSArray *)toCenters duration:(CGFloat)duration interval:(CGFloat)interval reverse:(BOOL)reverse completion:(void(^)(void))completion; 


#pragma mark - 设置任意动画

/*!
 @brief  给每个view设置动画，同时设置每个动画的的时长和动画的间隔，默认有spring效果
 
 @param keyPath    可以直接对view设置的键值
 @param fromValues 各个view对应的起始位置
 @param toValues   各个view对应的终止位置
 @param duration   各个view动画时长
 @param interval   view依次开始动画的时间间隔
 @param reverse    设置动画顺序，默认NO
            reverse为NO，动画顺序同array顺序
            reverse为YES，动画顺序同array逆序
 @param completion 动画结束后执行block
 */
- (void)animateViewsForKeyPath:(NSString *)keyPath from:(NSArray *)fromValues to:(NSArray *)toValues duration:(CGFloat)duration interval:(CGFloat)interval reverse:(BOOL)reverse completion:(void(^)(void))completion;


#pragma mark - 用模型设置动画参数

- (void)animateViewsFromCenters:(NSArray *)fromCenters toCenters:(NSArray *)toCenters settingModel:(PAGroupViewAnimationModel *)settingModel completion:(void (^)(void))completion;

- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrames:(NSArray *)toFrames settingModel:(PAGroupViewAnimationModel *)settingModel completion:(void (^)(void))completion;

- (void)animateViewsForKeyPath:(NSString *)keyPath from:(NSArray *)fromValues to:(NSArray *)toValues settingModel:(PAGroupViewAnimationModel *)settingModel completion:(void (^)(void))completion;

@end
