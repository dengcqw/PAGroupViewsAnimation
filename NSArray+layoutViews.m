//
//  NSArray+layoutViews.m
//  LeGengApp
//
//  Created by DengJinlong on 12/1/15.
//  Copyright © 2015 LeGeng. All rights reserved.
//

#import "NSArray+layoutViews.h"

@implementation NSArray (layoutViews)

- (NSArray *)viewFramesHorizontallyLayoutInFrame:(CGRect)frame edgeInsets:(UIEdgeInsets)edgeInsets viewPadding:(CGFloat)padding {
    NSMutableArray *viewArrs = [NSMutableArray array];
    
    frame = CGRectMake(frame.origin.x + edgeInsets.left,
                       frame.origin.y + edgeInsets.top,
                       frame.size.width-edgeInsets.left-edgeInsets.right,
                       frame.size.height-edgeInsets.top-edgeInsets.bottom);
    
    CGFloat width = frame.size.width/self.count - padding*self.count;
    CGFloat height = frame.size.height;
    
    for (NSUInteger i=0; i<self.count; i++) {
        CGFloat viewX = frame.origin.x + i*width + i*padding;
        CGFloat viewY = frame.origin.y;
        
        [viewArrs addObject:[NSValue valueWithCGRect:CGRectMake(viewX, viewY, width, height)]];
    }
    return [viewArrs copy];
}

- (NSArray *)viewFramesVerticallyLayoutInFrame:(CGRect)frame edgeInsets:(UIEdgeInsets)edgeInsets viewPadding:(CGFloat)padding {
    NSMutableArray *viewArrs = [NSMutableArray array];
    
    frame = CGRectMake(frame.origin.x + edgeInsets.left,
                       frame.origin.y + edgeInsets.top,
                       frame.size.width-edgeInsets.left-edgeInsets.right,
                       frame.size.height-edgeInsets.top-edgeInsets.bottom);
    
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height / self.count- padding*self.count;
    
    for (NSUInteger i=0; i<self.count; i++) {
        CGFloat viewX = frame.origin.x;
        CGFloat viewY = frame.origin.y + i*height + i*padding;
        
        [viewArrs addObject:[NSValue valueWithCGRect:CGRectMake(viewX, viewY, width, height)]];
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

- (NSArray *)viewCentersOnCircleWithCenter:(CGPoint)center viewArcLength:(CGFloat)arclength startAngle:(CGFloat)startAngle {
    return [self viewCentersOnArcWithCenter:center radian:2*M_PI-1 viewArcLength:arclength startAngle:startAngle];
}


- (void)layoutViewsHorizontallyInFrame:(CGRect)frame {
    [self layoutViewsHorizontallyInFrame:frame edgeInsets:(UIEdgeInsetsZero) viewPadding:0.0]; 
}

- (void)layoutViewsVerticallyInFrame:(CGRect)frame {
    [self layoutViewsVerticallyInFrame:frame edgeInsets:(UIEdgeInsetsZero) viewPadding:0.0];
}

- (void)layoutViewsHorizontallyInFrame:(CGRect)frame edgeInsets:(UIEdgeInsets)edgeInsets viewPadding:(CGFloat)padding {
    NSArray *frames = [self viewFramesHorizontallyLayoutInFrame:frame edgeInsets:edgeInsets viewPadding:padding];
    
    [self enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:UIView.class]) {
            return;
        }
        NSValue *frameValue = frames[idx];
        obj.frame = frameValue.CGRectValue;
    }];
}
    
- (void)layoutViewsVerticallyInFrame:(CGRect)frame edgeInsets:(UIEdgeInsets)edgeInsets viewPadding:(CGFloat)padding {
    NSArray *frames = [self viewFramesVerticallyLayoutInFrame:frame edgeInsets:edgeInsets viewPadding:padding];
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
