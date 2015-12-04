//
//  NSArray+layoutViews.m
//  LeGengApp
//
//  Created by DengJinlong on 12/1/15.
//  Copyright © 2015 LeGeng. All rights reserved.
//

#import "NSArray+layoutViews.h"

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
