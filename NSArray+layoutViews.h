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

- (NSArray *)viewFramesHorizontallyLayoutInFrame:(CGRect)frame withViewEdgeInsets:(UIEdgeInsets)edgeInsets;
- (NSArray *)viewFramesVerticallyLayoutInFrame:(CGRect)frame withViewEdgeInsets:(UIEdgeInsets)edgeInsets;
/**
 *  计算view分布的圆弧上的Center
 *
 *  @param radian    整个arc弧度
 *  @param arclength 每个view之间弧长
 */
- (NSArray *)viewCentersOnArcWithCenter:(CGPoint)center radian:(CGFloat)radian viewArcLength:(CGFloat)arclength;

/**
 * 计算有起始角度的圆弧上的frame
 *
 *  @param center     中心点
 *  @param radian     整个arc弧度
 *  @param arclength  两个view之间弧长
 *  @param startAngle 起始角度
 *
 */
- (NSArray *)viewCentersOnArcWithCenter:(CGPoint)center radian:(CGFloat)radian viewArcLength:(CGFloat)arclength startAngle:(CGFloat)startAngle;

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

/*!
 @brief  给每个view设置frame动画，起点相同都是aFrame，终点不同
 */
- (void)animateViewsFromFrame:(CGRect)aFrame toFrames:(NSArray *)frames completion:(void(^)(void))completion;
- (void)animateViewsFromFrames:(NSArray *)frames toFrame:(CGRect)toFrame completion:(void(^)(void))completion;
/*!
 @brief  给每个view设置frame动画，起点，终点都不同
 */
- (void)animateViewsFromFrames:(NSArray *)frames toFrames:(NSArray *)frames completion:(void(^)(void))completion;
/*!
 @brief  给每个view设置frame动画，起点，终点不同，同时设置每个动画的的时长和动画的间隔
 */
- (void)animateViewsFromFrames:(NSArray *)frames toFrames:(NSArray *)frames duration:(CGFloat)duration interval:(CGFloat)interval completion:(void(^)(void))completion;

- (void)animateViewsFromCenters:(NSArray *)fromCenters toCenters:(NSArray *)toCenters completion:(void (^)(void))completion;


@end
