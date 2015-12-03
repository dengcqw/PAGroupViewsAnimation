//
//  NSArray+layoutViews.m
//  LeGengApp
//
//  Created by DengJinlong on 12/1/15.
//  Copyright © 2015 LeGeng. All rights reserved.
//

#import "NSArray+layoutViews.h"

#define PAGroupViewAnimationDuration (0.1*self.count)
#define PAGroupViewAnimationInterval (0.1)
#define PAGroupViewAnimationSpringDamping (0.8)
#define PAGroupViewAnimationSpringVelocity (0.3)

@implementation NSArray (layoutViews)

- (NSArray *)viewFramesHorizontallyLayoutInFrame:(CGRect)frame withViewEdgeInsets:(UIEdgeInsets)edgeInsets{
    NSMutableArray *viewArrs = [NSMutableArray array];
    CGFloat width = frame.size.width/self.count;
    CGFloat height = frame.size.height;
    
    for (NSUInteger i=0; i<self.count; i++) {
        CGFloat viewX = i*width + frame.origin.x;
        CGFloat viewY = frame.origin.y;
        CGFloat insetX = viewX + edgeInsets.left;
        CGFloat insetY = viewY + edgeInsets.top;
        CGFloat insetW = width - edgeInsets.left - edgeInsets.right;
        CGFloat insetH = height - edgeInsets.top - edgeInsets.bottom;
        
        [viewArrs addObject:[NSValue valueWithCGRect:CGRectMake(insetX, insetY, insetW, insetH)]];
    }
    return [viewArrs copy];
}

- (NSArray *)viewFramesVerticallyLayoutInFrame:(CGRect)frame withViewEdgeInsets:(UIEdgeInsets)edgeInsets{
    NSMutableArray *viewArrs = [NSMutableArray array];
    
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height / self.count;
    
    for (NSUInteger i=0; i<self.count; i++) {
        CGFloat viewX = frame.origin.x;
        CGFloat viewY = i*height + frame.origin.y;
        
        CGFloat insetX = viewX + edgeInsets.left;
        CGFloat insetY = viewY + edgeInsets.top;
        CGFloat insetW = width - edgeInsets.left - edgeInsets.right;
        CGFloat insetH = height - edgeInsets.top - edgeInsets.bottom;
        
        [viewArrs addObject:[NSValue valueWithCGRect:CGRectMake(insetX, insetY, insetW, insetH)]];
    }
    return [viewArrs copy];
}
#pragma  mark - view分布的圆弧上的frame
- (NSArray *)viewCentersOnArcWithCenter:(CGPoint)center radian:(CGFloat)radian viewArcLength:(CGFloat)arclength {
    
    NSInteger count = self.count;
    CGFloat averRadian = radian/(count-1);
    
    NSMutableArray *viewArrs = [NSMutableArray array];
   //圆弧的半径
    CGFloat radius = arclength*(count-1) / radian;
    
    CGFloat centerX = center.x;
    CGFloat centerY = center.y;
    
    for (NSUInteger i=0; i<self.count; i++) {
        CGFloat radian = averRadian * (i);
        CGFloat viewX = centerX + radius * cosf(radian);
        CGFloat viewY = centerY - radius * sinf(radian);
        
        [viewArrs addObject:[NSValue valueWithCGPoint:CGPointMake(viewX, viewY)]];
    }
    
    return [viewArrs copy];
}

- (NSArray *)viewCentersOnArcWithCenter:(CGPoint)center radian:(CGFloat)radian viewArcLength:(CGFloat)arclength startAngle:(CGFloat)startAngle{
    
    NSInteger count = self.count;
    CGFloat averRadian = radian / (count -1);  //每两view之间的弧度
    NSMutableArray *viewArrs = [NSMutableArray array];
    
    CGFloat radius = arclength*(count -1)/radian; //半径
    CGFloat centerX = center.x;
    CGFloat centerY = center.y;
    
    for (NSUInteger i=0; i<self.count; i++) {
        CGFloat radian = averRadian * (i) + startAngle;
        CGFloat viewX = centerX + radius * cosf(radian);
        CGFloat viewY = centerY - radius * sinf(radian);
        
        [viewArrs addObject:[NSValue valueWithCGPoint:CGPointMake(viewX, viewY)]];
    }
    return [viewArrs copy];
}


- (void)layoutViewsHorizontallyInFrame:(CGRect)frame{
    [self layoutViewsHorizontallyInFrame:frame viewEdgeInsets:UIEdgeInsetsZero];
}

- (void)layoutViewsVerticallyInFrame:(CGRect)frame{
    [self layoutViewsVerticallyInFrame:frame viewEdgeInsets:UIEdgeInsetsZero];
}

#pragma mark - 每个view增加edgeInsets
- (void)layoutViewsHorizontallyInFrame:(CGRect)frame viewEdgeInsets:(UIEdgeInsets)edgeInsets{
    NSArray *frames = [self viewFramesHorizontallyLayoutInFrame:frame withViewEdgeInsets:edgeInsets];
    
    [self enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:UIView.class]) {
            return;
        }
        NSValue *frameValue = frames[idx];
        obj.frame = frameValue.CGRectValue;
        
    }];
}
- (void)layoutViewsVerticallyInFrame:(CGRect)frame viewEdgeInsets:(UIEdgeInsets)edgeInsets{
    NSArray *frames = [self viewFramesVerticallyLayoutInFrame:frame withViewEdgeInsets:edgeInsets];
    [self enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:UIView.class]) {
            return;
        }
        NSValue *frameValue = frames[idx];
        obj.frame = frameValue.CGRectValue;
    }];
}

/*!
 @brief  给每个view设置frame动画，起点相同都是aFrame，终点不同
 */
- (void)animateViewsFromFrame:(CGRect)fromFrame toFrames:(NSArray *)toFrames completion:(void(^)(void))completion {
    
    NSMutableArray *fromFrames = [NSMutableArray array];
    for (NSUInteger i=0; i < self.count; i++) {
        [fromFrames addObject:[NSValue valueWithCGRect:fromFrame]];
    }
    [self animateViewsFromFrames:fromFrames toFrames:toFrames completion:completion];
}

- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrame:(CGRect)toFrame completion:(void(^)(void))completion {
    
    NSMutableArray *toFrames = [NSMutableArray array];
    for (NSUInteger i=0; i < self.count; i++) {
        [toFrames addObject:[NSValue valueWithCGRect:toFrame]];
    }
    [self animateViewsFromFrames:fromFrames toFrames:toFrames completion:completion];
}

/*!
 @brief  给每个view设置frame动画，起点，终点都不同
 */
- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrames:(NSArray *)toFrames completion:(void(^)(void))completion {
    [self animateViewsFromFrames:fromFrames toFrames:toFrames duration:PAGroupViewAnimationDuration interval:PAGroupViewAnimationInterval completion:completion];
}

- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrames:(NSArray *)toFrames duration:(CGFloat)duration interval:(CGFloat)interval completion:(void(^)(void))completion {
    [self animateViewsFromFrames:fromFrames toFrames:toFrames duration:duration interval:interval reverse:NO completion:completion];
}

static NSInteger s_animatedCount;
- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrames:(NSArray *)toFrames duration:(CGFloat)duration interval:(CGFloat)interval reverse:(BOOL)reverse completion:(void(^)(void))completion {
    
    NSAssert(fromFrames.count == self.count,@"fromFrames is not equal to view count");
    NSAssert(toFrames.count == self.count,@"toFrames is not equal to view count");
    NSLog(@"duration %@, interval %@, reverse %@",@(duration), @(interval), @(reverse));
    
    // 设置起始位置
    [self enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        view.frame = [(NSValue *)fromFrames[idx] CGRectValue];
    }];
    
    CGFloat avg_duration = duration/self.count;
    s_animatedCount = 0;
    
    NSEnumerator *enumrator = reverse?self.reverseObjectEnumerator:self.objectEnumerator;
    [enumrator.allObjects enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        NSLog(@"animated index:%@",@(idx));
        
        [UIView animateWithDuration:avg_duration
                              delay:interval*idx 
             usingSpringWithDamping:PAGroupViewAnimationSpringDamping 
              initialSpringVelocity:PAGroupViewAnimationSpringVelocity
                            options:UIViewAnimationOptionCurveEaseInOut 
                         animations:^{
                                view.frame = [(NSValue *)toFrames[idx] CGRectValue];
                         } 
                         completion:^(BOOL finished) {
                             s_animatedCount++;
                             if (s_animatedCount==self.count && completion) {
                                 completion();
                             }
                         }];
    }]; // end of enumerate...
}

- (void)animateViewsFromCenters:(NSArray *)fromCenters toCenters:(NSArray *)toCenters completion:(void (^)(void))completion {
    NSMutableArray *fromFrames = [NSMutableArray array];
    NSMutableArray *toFrames = [NSMutableArray array];

    [self enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = CGRectZero;
        CGPoint fromPoint = [(NSValue *)fromCenters[idx] CGPointValue];
        CGPoint toPoint = [(NSValue *)toCenters[idx] CGPointValue];
        
        frame = CGRectMake(fromPoint.x -obj.frame.size.width*0.5, fromPoint.y-obj.frame.size.height*0.5, obj.frame.size.width, obj.frame.size.height);
        [fromFrames addObject:[NSValue valueWithCGRect:frame]];
        
        frame = CGRectMake(toPoint.x -obj.frame.size.width*0.5, toPoint.y-obj.frame.size.height*0.5, obj.frame.size.width, obj.frame.size.height);
        [toFrames addObject:[NSValue valueWithCGRect:frame]];
        
    }];
    
    [self animateViewsFromFrames:fromFrames toFrames:toFrames duration:PAGroupViewAnimationDuration*3 interval:0.0 completion:completion];
}


@end
