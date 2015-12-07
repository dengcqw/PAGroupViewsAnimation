//
//  NSArray+Views.h
//  PAGroupViewsAnimation
//
//  Created by DengJinlong on 12/3/15.
//  Copyright © 2015 dengjinlong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (Views)

- (void)setHide:(BOOL)hide;
- (void)setFrame:(CGRect)frame;
- (void)setCenter:(CGPoint)center;
- (void)setAlpha:(CGFloat)alpha;

- (void)pa_setValue:(id)value forKeyPath:(NSString *)keyPath;

@end
