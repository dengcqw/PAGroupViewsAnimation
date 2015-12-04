//
//  UIView+PASetValueForKeyPath.m
//  PAGroupViewsAnimation
//
//  Created by DengJinlong on 12/3/15.
//  Copyright © 2015 dengjinlong. All rights reserved.
//

#import "UIView+PASetValueForKeyPath.h"

@implementation UIView (PASetValueForKeyPath)

- (void)pa_setValue:(id)value forKeyPath:(NSString *)keyPath {
    NSArray *animationAttrs = @[/*view*/
                                @"frame", 
                                @"bounds", 
                                @"center",
                                @"transfrom", 
                                /*layer*/                            
                                @"layer.bounds", //4
                                @"layer.position",
                                @"layer.anchorPoint",
                                @"layer.zPosition",
                                @"layer.transform", 
                                @"layer.shadowOffset",
                                ];
    switch ([animationAttrs indexOfObject:keyPath]) {
        case 0:// frame
            if ([value isKindOfClass:[NSValue class]]) {
                self.frame = [(NSValue *)value CGRectValue];
            }
            break;
        case 1:// bounds
            if ([value isKindOfClass:[NSValue class]]) {
                self.bounds = [(NSValue *)value CGRectValue];
            }
            break;
        case 4:// layer.bounds
            if ([value isKindOfClass:[NSValue class]]) {
                self.layer.bounds = [(NSValue *)value CGRectValue];
            }
            break;
        case 2:// center
            if ([value isKindOfClass:[NSValue class]]) {
                self.center = [(NSValue *)value CGPointValue];
            }
            break;
        case 5:// layer.position
            if ([value isKindOfClass:[NSValue class]]) {
                self.center = [(NSValue *)value CGPointValue];
            }
            break;
        case 6:// layer.anchorPoint
            if ([value isKindOfClass:[NSValue class]]) {
                self.center = [(NSValue *)value CGPointValue];
            }
            break;
        case 7:// layer.zPosition
            if ([value isKindOfClass:[NSValue class]]) {
                self.center = [(NSValue *)value CGPointValue];
            }
            break;
        case 9:// layer.shadowOffset
            if ([value isKindOfClass:[NSValue class]]) {
                self.center = [(NSValue *)value CGPointValue];
            }
            break;
        case 3:// transform
            if ([value isKindOfClass:[NSValue class]]) {
                self.transform = [(NSValue *)value CGAffineTransformValue];
            }
            break;
        case 8:// layer.transform
            if ([value isKindOfClass:[NSValue class]]) {
                self.layer.transform = [(NSValue *)value CATransform3DValue];
            }
            break;
        default:
            [self setValue:value forKeyPath:keyPath];
            break;
    }
}

@end
