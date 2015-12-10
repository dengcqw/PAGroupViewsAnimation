//
//  NSArray+layoutViews.h
//  LeGengApp
//
//  Created by DengJinlong on 12/1/15.
//  Copyright © 2015 LeGeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSArray+Views.h"

/*!
 @brief  根据计算修改各个view元素的frame
         给一组view设置frame动画
 */
@interface NSArray (layoutViews)

#pragma mark - calculate position 

/*!
 @brief  在`frame`中水平，垂直布局一组view
 
 @param edgeInsets frame的边距
 @param padding view之间的距离
 */
- (NSArray *)viewFramesHorizontallyLayoutInFrame:(CGRect)frame edgeInsets:(UIEdgeInsets)edgeInsets viewPadding:(CGFloat)padding;
- (NSArray *)viewFramesVerticallyLayoutInFrame:(CGRect)frame edgeInsets:(UIEdgeInsets)edgeInsets viewPadding:(CGFloat)padding;

/**
 * 计算有起始角度的圆弧上的frame
 *
 *  @param center     中心点
 *  @param radian     整个arc弧度
 *  @param arclength  两个view之间弧长
 *  @param startAngle 起始弧度
 */
- (NSArray *)viewCentersOnArcWithCenter:(CGPoint)center radian:(CGFloat)radian viewArcLength:(CGFloat)arclength startAngle:(CGFloat)startAngle;
/**
 *  计算有起始角度的圆上的frame
 *
 *  @param center     中心点
 *  @param radian     圆
 *  @param startAngle 起始弧度
 */
- (NSArray *)viewCentersOnCircleWithCenter:(CGPoint)center viewArcLength:(CGFloat)arclength startAngle:(CGFloat)startAngle;

#pragma mark - layout views 

/*!
 @brief  水平方向布局则view高度等于frame高度，view宽度等于frame宽度按view数量等分。
         垂直方向布局则view宽度等于frame宽度，view高度等于frame高度按view数量等分。
 */
- (void)layoutViewsHorizontallyInFrame:(CGRect)frame;
- (void)layoutViewsVerticallyInFrame:(CGRect)frame;

/*!
 @brief  布局同时给每个view增加padding, 设置frame的edge
 */
- (void)layoutViewsHorizontallyInFrame:(CGRect)frame edgeInsets:(UIEdgeInsets)edgeInsets viewPadding:(CGFloat)padding;
- (void)layoutViewsVerticallyInFrame:(CGRect)frame edgeInsets:(UIEdgeInsets)edgeInsets viewPadding:(CGFloat)padding;


#pragma mark - animate views

@end

NSArray *arrayWithRepeatElement(id element, NSInteger count);

CGRect CGRectChangeCenter(CGRect rect, CGPoint center);
