//
//  PAViewAnimationSettingsModel.m
//  PAGroupViewsAnimation
//
//  Created by DengJinlong on 12/4/15.
//  Copyright © 2015 dengjinlong. All rights reserved.
//

#import "PAGroupViewAnimationModel.h"

@implementation PAGroupViewAnimationModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.duration = PAGroupViewAnimationDuration;
        self.interval = PAGroupViewAnimationInterval;
        
        self.springDamping = PAGroupViewAnimationSpringDamping;
        self.springVelocity = PAGroupViewAnimationSpringVelocity;
        
        self.reverse = NO;
        
        self.options = UIViewAnimationOptionCurveEaseInOut;
        self.spring  = NO;
    }
    return self;
}

@end
