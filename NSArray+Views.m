//
//  NSArray+Views.m
//  PAGroupViewsAnimation
//
//  Created by DengJinlong on 12/3/15.
//  Copyright © 2015 dengjinlong. All rights reserved.
//

#import "NSArray+Views.h"

@implementation NSArray (Views)

- (void)setHide:(BOOL)hide {
    [self enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.hidden = hide;
    }];
}

- (void)setFrame:(CGRect)frame {
    [self enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.frame = frame;
    }];
}

- (void)setCenter:(CGPoint)center {
    [self enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.center = center;
    }];
} 

- (void)setAlpha:(CGFloat)alpha {
    [self enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.alpha = alpha;
    }];
}

@end
