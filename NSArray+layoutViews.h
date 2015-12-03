//
//  NSArray+layoutViews.h
//  LeGengApp
//
//  Created by DengJinlong on 12/1/15.
//  Copyright © 2015 LeGeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*!
 @brief  根据计算修改各个view元素的frame
         给一组view设置frame动画
 */
@interface NSArray (layoutViews)

#pragma mark - calculate position 

/*!
 @brief  在`frame`中水平，垂直布局一组view
 
 @param edgeInsets 各个view的边距
 */
- (NSArray *)viewFramesHorizontallyLayoutInFrame:(CGRect)frame withViewEdgeInsets:(UIEdgeInsets)edgeInsets;
- (NSArray *)viewFramesVerticallyLayoutInFrame:(CGRect)frame withViewEdgeInsets:(UIEdgeInsets)edgeInsets;

/**
 * 计算有起始角度的圆弧上的frame
 *
 *  @param center     中心点
 *  @param radian     整个arc弧度
 *  @param arclength  两个view之间弧长
 *  @param startAngle 起始弧度
 */
- (NSArray *)viewCentersOnArcWithCenter:(CGPoint)center radian:(CGFloat)radian viewArcLength:(CGFloat)arclength startAngle:(CGFloat)startAngle;


#pragma mark - layout views 

/*!
 @brief  水平方向布局则view高度等于frame高度，view宽度等于frame宽度按view数量等分。
         垂直方向布局则view宽度等于frame宽度，view高度等于frame高度按view数量等分。
 */
- (void)layoutViewsHorizontallyInFrame:(CGRect)frame;
- (void)layoutViewsVerticallyInFrame:(CGRect)frame;

/*!
 @brief  布局同时给每个view增加edge insets
 */
- (void)layoutViewsHorizontallyInFrame:(CGRect)frame viewEdgeInsets:(UIEdgeInsets)edgeInsets;
- (void)layoutViewsVerticallyInFrame:(CGRect)frame viewEdgeInsets:(UIEdgeInsets)edgeInsets;


#pragma mark - animate views

/*!
 @brief  给每个view设置frame动画
 */
- (void)animateViewsFromFrame:(CGRect)fromFrame toFrames:(NSArray *)toFrames completion:(void(^)(void))completion;
- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrame:(CGRect)toFrame completion:(void(^)(void))completion;
- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrames:(NSArray *)toFrames completion:(void(^)(void))completion;

/*!
 @brief  给每个view设置frame动画，起点，终点不同，同时设置每个动画的的时长和动画的间隔
 
 @param fromFrames 各个view对应的起始位置
 @param toFrames   各个view对应的终止位置
 @param duration   总的动画时长
 @param interval   各个view开始动画的时间间隔
 @param completion 动画结束后执行block
 */
- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrames:(NSArray *)toFrames duration:(CGFloat)duration interval:(CGFloat)interval completion:(void(^)(void))completion;

/*!
 @brief 增加reverse属性，设置动画顺序，默认NO
        reverse为NO，动画顺序同array顺序
        reverse为YES，动画顺序同array逆序
 */
- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrames:(NSArray *)toFrames duration:(CGFloat)duration interval:(CGFloat)interval reverse:(BOOL)reverse completion:(void(^)(void))completion;

/*!
 @brief  以view中心点做为动画的参数
 */
- (void)animateViewsFromCenters:(NSArray *)fromCenters toCenters:(NSArray *)toCenters completion:(void (^)(void))completion;


@end
