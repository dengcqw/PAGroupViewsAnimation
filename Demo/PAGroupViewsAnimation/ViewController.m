//
//  ViewController.m
//  PAAnimationDemo
//
//  Created by eileen on 15/12/2.
//  Copyright © 2015年 平安好房. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+layoutViews.h"
#import "MenuView.h"
#import "UIView+MGEasyFrame.h"

//#define PAAddGrayBackgroundView

@interface ViewController ()
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *leftBottomBtn;
@property (strong, nonatomic) UIButton *bottomBtn;
@property (strong, nonatomic) UILabel *longPressHintLabel;

@property (strong, nonatomic) MenuView *menuView;
@property (strong, nonatomic) MenuView *leftBottomMenuView;
@property (strong, nonatomic) MenuView *bottomMenuView;
@property (strong, nonatomic) MenuView *longPressMenuView;

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.leftBtn];
    [self.view addSubview:self.leftBottomBtn];
    [self.view addSubview:self.bottomBtn];
    
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.leftBottomMenuView];
    [self.view addSubview:self.bottomMenuView];
    
    self.menuView.hidden = YES;
    self.leftBottomMenuView.hidden = YES;
    self.bottomMenuView.hidden = YES;
    self.longPressMenuView.hidden = YES;
    
    [self.view addSubview:self.longPressHintLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBottomBtn addTarget:self action:@selector(leftBottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBtn addTarget:self action:@selector(bottomBtnClicked:) forControlEvents:
     UIControlEventTouchUpInside];
    
    UIGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.leftBtn.frame = CGRectMake(0, 450, 80, 80);
    self.menuView.frame = CGRectMake(0, 92, 80, 360);
    
    self.leftBottomBtn.frame = CGRectMake(0, self.view.bottom-80, 80, 80);
    self.leftBottomMenuView.bounds = CGRectMake(0, 0, 80, 360);
    self.leftBottomMenuView.center = self.view.center;
    
    CGFloat bottomMenuViewX = (self.view.width-300)*0.5;
    CGFloat bottomMenuViewY = (self.view.height-150) *0.3;
    self.bottomBtn.frame = CGRectMake((self.view.width-80)*0.5, self.view.bottom-80, 80, 80);
    self.bottomMenuView.frame = CGRectMake(bottomMenuViewX, bottomMenuViewY, 300, 280);
    
    self.longPressMenuView.frame = self.view.bounds;
    self.longPressHintLabel.frame =  CGRectMake(0, 0, self.view.width, 80);
}

- (MenuView *)longPressMenuView {
    if (nil == _longPressMenuView) {   
        _longPressMenuView = [[MenuView alloc]init];
        _longPressMenuView.backgroundColor = [UIColor clearColor];
        [_longPressMenuView.viewArrs enumerateObjectsUsingBlock:^(UIImageView *view, NSUInteger idx, BOOL * _Nonnull stop) {
            view.size = CGSizeMake(50, 75);
        }];
    }
    return _longPressMenuView;
}

- (UIButton *)leftBtn {
    if (nil == _leftBtn) {
        self.leftBtn = ({
            UIButton *aButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            [aButton setTitle:@"Left" forState:UIControlStateNormal];
            [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            aButton.backgroundColor = [UIColor lightGrayColor];
            aButton.showsTouchWhenHighlighted = YES;
            
            aButton;
        });
    }
    return _leftBtn;
}

- (MenuView *)menuView {
    if (nil == _menuView) {
        self.menuView = [[MenuView alloc]init];
    }
    return _menuView;
}

-(UIButton *)leftBottomBtn{
    if (nil == _leftBottomBtn) {
        self.leftBottomBtn = ({
            UIButton *aButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            [aButton setTitle:@"LBottom" forState:UIControlStateNormal];
            [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            aButton.backgroundColor = [UIColor lightGrayColor];
            aButton.showsTouchWhenHighlighted = YES;
            
            aButton;
            
        });
    }
    return _leftBottomBtn;
}

- (MenuView *)leftBottomMenuView{
    if (nil == _leftBottomMenuView) {
        self.leftBottomMenuView = [[MenuView alloc]init];
    }
    return _leftBottomMenuView;
}

- (UIButton *)bottomBtn{
    if (nil == _bottomBtn) {
        self.bottomBtn = ({
            UIButton *aButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            [aButton setTitle:@"Bottom" forState:UIControlStateNormal];
            [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            aButton.backgroundColor = [UIColor lightGrayColor];
            aButton.showsTouchWhenHighlighted = YES;
            
            aButton;
            
        });
    }
    return _bottomBtn;
}

-(MenuView *)bottomMenuView{
    if (nil == _bottomMenuView) {
        self.bottomMenuView = [[MenuView alloc]init];
    }
    return _bottomMenuView;
}

- (UILabel *)longPressHintLabel {
    if (nil == _longPressHintLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 0, 0)];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.text = @"try long press screen";
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:26];
        self.longPressHintLabel = label;
    }
    return _longPressHintLabel;
}



- (void)leftBtnClicked:(UIButton *)sender {
    
    BOOL flyOut = sender.isSelected;
    sender.selected = ! sender.isSelected;
    
    CGFloat duration = 0.3;
    
    NSArray *fromFrames = [self.menuView.viewArrs viewFramesVerticallyLayoutInFrame:CGRectMake(-80, 0, 80, 360) withViewEdgeInsets:(UIEdgeInsetsMake(5, 0, 5, 0))];
    NSArray *toFrames = [self.menuView.viewArrs viewFramesVerticallyLayoutInFrame:self.menuView.bounds withViewEdgeInsets:(UIEdgeInsetsMake(5, 0, 5, 0))];
    
    if ( !flyOut ) {
        self.menuView.hidden = NO;
#ifdef PAAddGrayBackgroundView
        [UIView animateWithDuration:(duration+3*0.1) animations:^{
            self.menuView.backgroundColor = [UIColor lightGrayColor];
        }];
#endif
        [self.menuView.viewArrs animateViewsFromFrames:fromFrames toFrames:toFrames duration:duration interval:0.1 completion:^{
        }];
    } else {
#ifdef PAAddGrayBackgroundView
        [UIView animateWithDuration:(duration+3*0.1) animations:^{
            self.menuView.backgroundColor = [UIColor clearColor];
        }];
#endif
        [self.menuView.viewArrs animateViewsFromFrames:toFrames toFrames:fromFrames duration:duration interval:0.1 completion:^{
            self.menuView.hidden = YES;
        }];
    }
}

- (void)leftBottomBtnClicked:(UIButton *)sender{
    
    BOOL flyOut = sender.isSelected;
    sender.selected = ! sender.isSelected;
    
    CGRect fromFrame = CGRectMake(-80, self.view.bottom, 80, 120);
    fromFrame = [self.view convertRect:fromFrame toView:self.leftBottomMenuView];
    
    NSArray *toFrames = [self.leftBottomMenuView.viewArrs viewFramesVerticallyLayoutInFrame:self.leftBottomMenuView.bounds withViewEdgeInsets:(UIEdgeInsetsMake(5, 0, 5, 0))];
    if (! flyOut) { 
#ifdef PAAddGrayBackgroundView
        [UIView animateWithDuration:0.3 animations:^{
            self.leftBottomMenuView.backgroundColor = [UIColor lightGrayColor];
        }];
#endif
        self.leftBottomMenuView.hidden = NO;
        [self.leftBottomMenuView.viewArrs animateViewsFromFrame:fromFrame toFrames:toFrames completion:^{
        }];
    } else { 
#ifdef PAAddGrayBackgroundView
        [UIView animateWithDuration:0.3 animations:^{
            self.leftBottomMenuView.backgroundColor = [UIColor whiteColor];
        }];
#endif
        [self.leftBottomMenuView.viewArrs animateViewsFromFrames:toFrames toFrame:fromFrame completion:^{
            self.leftBottomMenuView.hidden = YES; 
        }];
    }
}

- (void)bottomBtnClicked:(UIButton *)sender{
    
    BOOL flyOut = sender.isSelected;
    sender.selected = ! sender.isSelected;
    
    NSArray *fromFramesOne = [self.bottomMenuView.viewArrs viewFramesHorizontallyLayoutInFrame:CGRectMake((self.view.width-360)*0.5, self.view.bottom, 360, 80) withViewEdgeInsets:(UIEdgeInsetsMake(0, 5, 0, 5))];
    NSArray *toFramesOne = [self.bottomMenuView.viewArrs viewFramesHorizontallyLayoutInFrame:CGRectMake(0, 0, 300, 150) withViewEdgeInsets:(UIEdgeInsetsMake(15, 10, 15, 10))];
    
    NSArray *fromFramesTwo = [self.bottomMenuView.secondViewArrs viewFramesHorizontallyLayoutInFrame:CGRectMake((self.view.width-360)*0.5, self.view.bottom, 360, 80) withViewEdgeInsets:(UIEdgeInsetsMake(0, 5, 0, 5))];
    NSArray *toFramesTwo = [self.bottomMenuView.secondViewArrs viewFramesHorizontallyLayoutInFrame:CGRectMake(0, 120, 300, 150) withViewEdgeInsets:(UIEdgeInsetsMake(15, 10,15, 10))];
    
    if ( !flyOut ) {
        self.bottomMenuView.hidden = NO;
#ifdef PAAddGrayBackgroundView
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomMenuView.backgroundColor = [UIColor lightGrayColor];
        }];
#endif
        [self.bottomMenuView.viewArrs animateViewsFromFrames:fromFramesOne toFrames:toFramesOne duration:0.3 interval:0.1 completion:^{
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.bottomMenuView.secondViewArrs animateViewsFromFrames:fromFramesTwo toFrames:toFramesTwo duration:0.3 interval:0.1 completion:^{
            }];
        });
    } else { 
#ifdef PAAddGrayBackgroundView
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomMenuView.backgroundColor = [UIColor clearColor];
        }];
#endif
        [self.bottomMenuView.secondViewArrs animateViewsFromFrames:toFramesTwo toFrames:fromFramesTwo duration:0.3 interval:0.1 reverse:YES completion:^{
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.bottomMenuView.viewArrs animateViewsFromFrames:toFramesOne toFrames:fromFramesOne duration:0.3 interval:0.1 reverse:YES completion:^{
                self.bottomMenuView.hidden = YES;
            }];
        });
    }
}

- (void)longPressAction:(UIGestureRecognizer *)gesture{
    NSArray *toCenters = [NSArray array];
    [self.view addSubview:self.longPressMenuView];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            
            // 初始化起始状态
            [self.longPressMenuView.viewArrs setHide:YES];
            self.longPressMenuView.hidden = NO;
            
            // 计算fromCenters
            CGPoint point =[gesture locationInView:self.view];
            NSValue *pointValue = [NSValue valueWithCGPoint:point];
            NSArray *fromCenters = arrayWithRepeatElement(pointValue, self.longPressMenuView.viewArrs.count);
            
            // 计算toCenters
            if (point.x > self.view.width-72) {
                toCenters = [self.longPressMenuView.viewArrs viewCentersOnArcWithCenter:point radian:(M_PI_4*2.5) viewArcLength:100 startAngle:(M_PI-M_PI_4*2.5/2)];
            }else {
                toCenters = [self.longPressMenuView.viewArrs viewCentersOnArcWithCenter:point radian:(M_PI_4*2.5) viewArcLength:100 startAngle:-(M_PI_4*2.5/2)];
            }
            
            [self.longPressMenuView.viewArrs animateViewsFromCenters:fromCenters toCenters:toCenters duration:0.3 interval:0 completion:nil];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            self.longPressMenuView.hidden = YES;
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint point = [gesture locationInView:self.view];
            //NSLog(@"finger move:%@",NSStringFromCGPoint(point));
            break;
        }
        default:
            break;
    }
}

@end

