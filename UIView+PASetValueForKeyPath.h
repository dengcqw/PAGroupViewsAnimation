//
//  UIView+PASetValueForKeyPath.h
//  PAGroupViewsAnimation
//
//  Created by DengJinlong on 12/3/15.
//  Copyright © 2015 dengjinlong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PASetValueForKeyPath)

- (void)pa_setValue:(id)value forKeyPath:(NSString *)keyPath;

@end
