//
//  PAGroupViewAnimationModel.h
//  PAGroupViewsAnimation
//
//  Created by DengJinlong on 12/4/15.
//  Copyright © 2015 dengjinlong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define PAGroupViewAnimationDuration (0.1) // 每个view默认动画时间
#define PAGroupViewAnimationInterval (0.1) // view依次开始动画的默认时间间隔

#define PAGroupViewAnimationSpringDamping (0.8)
#define PAGroupViewAnimationSpringVelocity (0.3)

@interface PAGroupViewAnimationModel : NSObject

@property (assign, nonatomic) CGFloat duration; /*< 各个view动画时长 */
@property (assign, nonatomic) CGFloat interval; /*< view依次开始动画的时间间隔，若为0，则同时开始动画 */

@property (assign, nonatomic) CGFloat springDamping;
@property (assign, nonatomic) CGFloat springVelocity;

@property (assign, nonatomic) UIViewAnimationOptions options;

@property (assign, nonatomic) BOOL reverse; /*< 设置动画顺序，默认NO */

@end
