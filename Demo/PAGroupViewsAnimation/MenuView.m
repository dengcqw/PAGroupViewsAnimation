//
//  MenuView.m
//  AnimationDemo
//
//  Created by eileen on 15/12/2.
//  Copyright © 2015年 平安好房. All rights reserved.
//

#import "MenuView.h"
#import "NSArray+layoutViews.h"

@interface MenuView ()

@property (strong, nonatomic) UIImageView *aboutIV;
@property (strong, nonatomic) UIImageView *jobsIV;
@property (strong, nonatomic) UIImageView *libraryIV;

@property (strong, nonatomic) UIImageView *newsIV;
@property (strong, nonatomic) UIImageView *noticeIV;
@property (strong, nonatomic) UIImageView *lafIV;

@end

@implementation MenuView
/**
 *  initailize
 *
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    _aboutIV = [[UIImageView alloc]init];
    _aboutIV.image = [UIImage imageNamed:@"gpa.png"];
    [self addSubview:_aboutIV];
    
    _jobsIV = [[UIImageView alloc]init];
    _jobsIV.image = [UIImage imageNamed:@"jobs.png"];
    [self addSubview:_jobsIV];
    
    _libraryIV  = [[UIImageView alloc]init];
    _libraryIV.image = [UIImage imageNamed:@"library.png"];
    [self addSubview:_libraryIV];
    
    [self.viewArrs addObject:_aboutIV];
    [self.viewArrs addObject:_jobsIV];
    [self.viewArrs addObject:_libraryIV];
    
    _newsIV = [[UIImageView alloc]init];
    _newsIV.image = [UIImage imageNamed:@"news.png"];
    [self addSubview:_newsIV];
    
    _noticeIV = [[UIImageView alloc]init];
    _noticeIV.image = [UIImage imageNamed:@"notice.png"];
    [self addSubview:_noticeIV];
    
    _lafIV  = [[UIImageView alloc]init];
    _lafIV.image = [UIImage imageNamed:@"laf.png"];
    [self addSubview:_lafIV];
    
    [self.secondViewArrs addObject:_newsIV];
    [self.secondViewArrs addObject:_noticeIV];
    [self.secondViewArrs addObject:_lafIV];
}

- (NSMutableArray *)viewArrs{
    if (_viewArrs.count ==0) {
        _viewArrs = [NSMutableArray array];
    }
    return _viewArrs;
}

- (NSMutableArray *)secondViewArrs{
    if (_secondViewArrs ==0) {
        _secondViewArrs = [NSMutableArray array];
    }
    return _secondViewArrs;
}


@end
