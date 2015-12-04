//
//  NSArray+GroupAnimation.m
//  PAGroupViewsAnimation
//
//  Created by DengJinlong on 12/4/15.
//  Copyright © 2015 dengjinlong. All rights reserved.
//

#import "NSArray+GroupAnimation.h"
#import "NSArray+layoutViews.h"
#import "UIView+PASetValueForKeyPath.h"
#import <objc/runtime.h>

@implementation NSArray (GroupAnimation)

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
    
    PAGroupViewAnimationModel *settingModel = [[PAGroupViewAnimationModel alloc] init];
    settingModel.duration = duration;
    settingModel.interval = interval;
    settingModel.reverse = reverse;
    settingModel.springDamping = PAGroupViewAnimationSpringDamping;
    settingModel.springVelocity = PAGroupViewAnimationSpringVelocity;
    settingModel.options = UIViewAnimationOptionCurveEaseInOut;
    settingModel.spring  = YES;
    
    [self animateViewsForKeyPath:keyPath from:fromValues to:toValues settingModel:settingModel completion:completion];
    
}

- (void)animateViewsFromCenters:(NSArray *)fromCenters toCenters:(NSArray *)toCenters settingModel:(PAGroupViewAnimationModel *)settingModel completion:(void (^)(void))completion {

    [self animateViewsForKeyPath:@"center" from:fromCenters to:toCenters settingModel:settingModel completion:completion];
}

- (void)animateViewsFromFrames:(NSArray *)fromFrames toFrames:(NSArray *)toFrames settingModel:(PAGroupViewAnimationModel *)settingModel completion:(void (^)(void))completion {
    
    [self animateViewsForKeyPath:@"frame" from:fromFrames to:toFrames settingModel:settingModel completion:completion];
}

- (void)animateViewsForKeyPath:(NSString *)keyPath from:(NSArray *)fromValues to:(NSArray *)toValues settingModel:(PAGroupViewAnimationModel *)settingModel completion:(void (^)(void))completion {
    
    NSAssert(keyPath.length,@"keyPath can not be empty");
    NSAssert(fromValues.count == self.count,@"fromFrames is not equal to view count");
    NSAssert(toValues.count == self.count,@"toFrames is not equal to view count");
    NSAssert(settingModel, @"settingModel can not be nil");
    
    CGFloat duration = settingModel.duration;
    CGFloat interval = settingModel.interval;
    CGFloat reverse  = settingModel.reverse;
    NSLog(@"Group Views (%@) Animation: duration(%@), interval(%@), reverse(%@)",keyPath, @(duration), @(interval), reverse?@"YES":@"NO");
    
    // 设置起始值
    [self enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [view pa_setValue:fromValues[idx] forKeyPath:keyPath];
    }];
    
    NSEnumerator *viewEnumrator = reverse?self.reverseObjectEnumerator:self.objectEnumerator;
    NSEnumerator *toFrameEnumrator = reverse?toValues.reverseObjectEnumerator:toValues.objectEnumerator;
    toValues = toFrameEnumrator.allObjects;
    
    // view动画结束计数
    [self setPA_animatedCount:0];
    void(^_completion)(BOOL finished) = ^(BOOL finish) {
        NSInteger count = [self getPA_animatedCount]+1;
        if (count==self.count && completion) {
            completion();
        }
        [self setPA_animatedCount:count];
    };
    
    [viewEnumrator.allObjects enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if (settingModel.spring) {
            [UIView animateWithDuration:duration
                                  delay:interval*idx
                 usingSpringWithDamping:settingModel.springDamping
                  initialSpringVelocity:settingModel.springVelocity
                                options:settingModel.options
                             animations:^{
                                 [view pa_setValue:toValues[idx] forKeyPath:keyPath];
                             }
                             completion:_completion];
        }else {
            [UIView animateWithDuration:duration 
                                  delay:interval*idx 
                                options:settingModel.options 
                             animations:^{
                [view pa_setValue:toValues[idx] forKeyPath:keyPath];
            } completion:_completion];
        }
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
