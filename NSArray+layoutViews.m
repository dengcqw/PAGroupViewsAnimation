//
//  NSArray+layoutViews.m
//  LeGengApp
//
//  Created by DengJinlong on 12/1/15.
//  Copyright © 2015 LeGeng. All rights reserved.
//

#import "NSArray+layoutViews.h"
#import "UIView+PASetValueForKeyPath.h"
#import <objc/runtime.h>

#define PAGroupViewAnimationSpringDamping (0.8)
#define PAGroupViewAnimationSpringVelocity (0.3)

@implementation NSArray (layoutViews)

- (NSArray *)viewFramesHorizontallyLayoutInFrame:(CGRect)frame withViewEdgeInsets:(UIEdgeInsets)edgeInsets {
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

- (NSArray *)viewFramesVerticallyLayoutInFrame:(CGRect)frame withViewEdgeInsets:(UIEdgeInsets)edgeInsets {
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

- (NSArray *)viewCentersOnArcWithCenter:(CGPoint)center radian:(CGFloat)radian viewArcLength:(CGFloat)arclength startAngle:(CGFloat)startAngle {
    
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


- (void)layoutViewsHorizontallyInFrame:(CGRect)frame {
    [self layoutViewsHorizontallyInFrame:frame viewEdgeInsets:UIEdgeInsetsZero];
}

- (void)layoutViewsVerticallyInFrame:(CGRect)frame {
    [self layoutViewsVerticallyInFrame:frame viewEdgeInsets:UIEdgeInsetsZero];
}

- (void)layoutViewsHorizontallyInFrame:(CGRect)frame viewEdgeInsets:(UIEdgeInsets)edgeInsets {
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

- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrames:(NSArray *)toFrames completion:(void(^)(void))completion {
    [self animateViewsFromFrames:fromFrames toFrames:toFrames duration:PAGroupViewAnimationDuration interval:PAGroupViewAnimationInterval completion:completion];
}

- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrames:(NSArray *)toFrames duration:(CGFloat)duration interval:(CGFloat)interval completion:(void(^)(void))completion {
    [self animateViewsFromFrames:fromFrames toFrames:toFrames duration:duration interval:interval reverse:NO completion:completion];
}

- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrames:(NSArray *)toFrames duration:(CGFloat)duration interval:(CGFloat)interval reverse:(BOOL)reverse completion:(void(^)(void))completion {
    [self animateViewsForKeyPath:@"frame" from:fromFrames to:toFrames duration:duration interval:interval reverse:reverse completion:completion];
}

- (void)animateViewsFromCenters:(NSArray *)fromCenters toCenters:(NSArray *)toCenters completion:(void (^)(void))completion {
    [self animateViewsFromCenters:fromCenters toCenters:toCenters duration:PAGroupViewAnimationDuration interval:PAGroupViewAnimationInterval reverse:NO completion:completion];
}

- (void)animateViewsFromCenters:(NSArray *)fromCenters toCenters:(NSArray *)toCenters duration:(CGFloat)duration interval:(CGFloat)interval completion:(void(^)(void))completion {
    [self animateViewsFromCenters:fromCenters toCenters:toCenters duration:duration interval:interval reverse:NO completion:completion];
}

- (void)animateViewsFromCenters:(NSArray *)fromCenters toCenters:(NSArray *)toCenters duration:(CGFloat)duration interval:(CGFloat)interval reverse:(BOOL)reverse completion:(void(^)(void))completion {
    
    NSMutableArray *fromFrames = [NSMutableArray array];
    NSMutableArray *toFrames = [NSMutableArray array];

    // 计算frame
    [self enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = CGRectZero;
        CGPoint fromPoint = [(NSValue *)fromCenters[idx] CGPointValue];
        CGPoint toPoint = [(NSValue *)toCenters[idx] CGPointValue];
        
        frame = CGRectChangeCenter(view.frame, fromPoint);
        [fromFrames addObject:[NSValue valueWithCGRect:frame]];
        
        frame = CGRectChangeCenter(view.frame, toPoint);
        [toFrames addObject:[NSValue valueWithCGRect:frame]];
    }];
    
    [self animateViewsFromFrames:fromFrames toFrames:toFrames duration:duration interval:interval reverse:reverse completion:completion];
}

- (void)animateViewsForKeyPath:(NSString *)keyPath from:(NSArray *)fromValues to:(NSArray *)toValues duration:(CGFloat)duration interval:(CGFloat)interval reverse:(BOOL)reverse completion:(void(^)(void))completion {
    
    NSAssert(fromValues.count == self.count,@"fromFrames is not equal to view count");
    NSAssert(toValues.count == self.count,@"toFrames is not equal to view count");
    NSLog(@"Group Views Animation: duration %@, interval %@, reverse %@",@(duration), @(interval), @(reverse));
    
    // 设置起始值
    [self enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [view pa_setValue:fromValues[idx] forKeyPath:keyPath];
    }];
    
    [self setPA_animatedCount:0];
    
    NSEnumerator *viewEnumrator = reverse?self.reverseObjectEnumerator:self.objectEnumerator;
    NSEnumerator *toFrameEnumrator = reverse?toValues.reverseObjectEnumerator:toValues.objectEnumerator;
    toValues = toFrameEnumrator.allObjects;
    
    [viewEnumrator.allObjects enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        
        [UIView animateWithDuration:duration
                              delay:interval*idx 
             usingSpringWithDamping:PAGroupViewAnimationSpringDamping 
              initialSpringVelocity:PAGroupViewAnimationSpringVelocity
                            options:UIViewAnimationOptionCurveEaseInOut 
                         animations:^{
                             [view pa_setValue:toValues[idx] forKeyPath:keyPath];
                         } 
                         completion:^(BOOL finished) {
                             NSInteger count = [self getPA_animatedCount]+1;
                             if (count==self.count && completion) {
                                 completion();
                             }
                             [self setPA_animatedCount:count];
                         }];
    }]; // end of enumerate...
}

- (void)setPA_animatedCount:(NSInteger)count {
    objc_setAssociatedObject(self, _cmd, @(count), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)getPA_animatedCount {
    NSNumber *count = objc_getAssociatedObject(self, @selector(setPA_animatedCount:));
    return count.integerValue;
}

@end

NSArray *arrayWithRepeatElement(id element, NSInteger count) {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < count; i++) {
        [mutableArray addObject:element];
    }
    return [mutableArray copy]; 
}

CGRect CGRectChangeCenter(CGRect rect, CGPoint center) {
    return CGRectMake(center.x-rect.size.width*0.5, center.y-rect.size.height*0.5, rect.size.width, rect.size.height);
}
