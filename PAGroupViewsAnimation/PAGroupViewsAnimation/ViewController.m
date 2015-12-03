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


@interface ViewController ()
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *leftBottomBtn;
@property (strong, nonatomic) UIButton *bottomBtn;

@property (strong, nonatomic) MenuView *menuView;
@property (strong, nonatomic) MenuView *leftBottomMenuView;
@property (strong, nonatomic) MenuView *bottomMenuView;

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
    
    self.leftBottomMenuView.hidden = YES;
    self.bottomMenuView.hidden = YES; 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBottomBtn addTarget:self action:@selector(leftBottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBtn addTarget:self action:@selector(bottomBtnClicked:) forControlEvents:
     UIControlEventTouchUpInside];
    
    UIGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)longPress:(UIGestureRecognizer *)gesture{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            
        }
            break;
        default:
            break;
    }
    
    if (gesture.isEnabled) {
        self.menuView.bounds = self.view.bounds;
        [self.view addSubview:self.menuView];
         //获取触摸点的位置
        CGPoint point =[gesture locationInView:self.view];
        UIView *pressView = [[UIView alloc]initWithFrame:CGRectMake(point.x, point.y, 30, 30)];
        pressView.backgroundColor = [UIColor redColor];
        [self.view addSubview:pressView];
        [self.menuView.viewArrs enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL * stop) {
            obj.frame  = CGRectMake(0, 0, 80, 120);
        }];
        
        NSArray *toCenters = [self.menuView.viewArrs viewCentersOnArcWithCenter:point radian:(M_PI_4*3) viewArcLength:150 startAngle:M_PI_4];
        NSValue *pointValue = [NSValue valueWithCGPoint:point];
        NSArray *fromCenters = @[pointValue,pointValue,pointValue];
        [self.menuView.viewArrs animateViewsFromCenters:fromCenters toCenters:toCenters completion:^{
            
        }];
        
        NSLog(@"I am long pressing.... %f---%f",point.x,point.y);
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.leftBtn.frame = CGRectMake(0, 450, 80, 80);
    self.menuView.frame = CGRectMake(0, 450-370, 80, 360);
    
    self.leftBottomBtn.frame = CGRectMake(0, self.view.bottom-80, 80, 80);
    self.leftBottomMenuView.frame = CGRectMake(self.view.center.y*0.5, 90, 80, 360);
    
    CGFloat bottomMenuViewX = (self.view.width-300)*0.5;
    CGFloat bottomMenuViewY = (self.view.height-150) *0.6;
    self.bottomBtn.frame = CGRectMake((self.view.width-80)*0.5, self.view.bottom-80, 80, 80);
    self.bottomMenuView.frame = CGRectMake(bottomMenuViewX, bottomMenuViewY, 300, 280);
}

- (UIButton *)leftBtn {
    if (nil == _leftBtn) {
        self.leftBtn = ({
            UIButton *aButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            [aButton setTitle:@"Left" forState:UIControlStateNormal];
            [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            aButton.backgroundColor = [UIColor orangeColor];
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
            aButton.backgroundColor = [UIColor blueColor];
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
            aButton.backgroundColor = [UIColor greenColor];
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


- (void)leftBtnClicked:(UIButton *)sender {
    
    BOOL flyOut = sender.isSelected;
    sender.selected = ! sender.isSelected;
    
    NSArray *fromFrames = [self.menuView.viewArrs viewFramesVerticallyLayoutInFrame:CGRectMake(-80, 0, 80, 360) withViewEdgeInsets:(UIEdgeInsetsMake(5, 0, 5, 0))];
    NSArray *toFrames = [self.menuView.viewArrs viewFramesVerticallyLayoutInFrame:self.menuView.bounds withViewEdgeInsets:(UIEdgeInsetsMake(5, 0, 5, 0))];
    if ( !flyOut ) {
        self.menuView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.menuView.backgroundColor = [UIColor lightGrayColor];
        }];
        [self.menuView.viewArrs animateViewsFromFrames:fromFrames toFrames:toFrames duration:0.1 interval:0.1 completion:^{
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.menuView.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
        }];
        [self.menuView.viewArrs animateViewsFromFrames:toFrames toFrames:fromFrames duration:0.1 interval:0.1 completion:^{
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
    if (!flyOut ) { // fly in
        self.leftBottomMenuView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
                self.leftBottomMenuView.backgroundColor = [UIColor lightGrayColor];
        }];
        [self.leftBottomMenuView.viewArrs animateViewsFromFrame:fromFrame toFrames:toFrames completion:^{
        }];
    } else { // fly out
        [UIView animateWithDuration:0.3 animations:^{
                self.leftBottomMenuView.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
        }];
        [self.leftBottomMenuView.viewArrs animateViewsFromFrames:toFrames toFrame:fromFrame completion:^{
            self.leftBottomMenuView.hidden = YES;
        }];
    }
}

- (void)bottomBtnClicked:(UIButton *)sender {
    
    BOOL flyOut = sender.isSelected;
    sender.selected = ! sender.isSelected;
    
    NSArray *fromFramesOne = [self.bottomMenuView.viewArrs viewFramesHorizontallyLayoutInFrame:CGRectMake((self.view.width-360)*0.5, self.view.bottom, 360, 80) withViewEdgeInsets:(UIEdgeInsetsMake(0, 5, 0, 5))];
    NSArray *toFramesOne = [self.bottomMenuView.viewArrs viewFramesHorizontallyLayoutInFrame:CGRectMake(0, 0, 300, 150) withViewEdgeInsets:(UIEdgeInsetsMake(15, 10, 15, 10))];
    
    NSArray *fromFramesTwo = [self.bottomMenuView.secondViewArrs viewFramesHorizontallyLayoutInFrame:CGRectMake((self.view.width-360)*0.5, self.view.bottom, 360, 80) withViewEdgeInsets:(UIEdgeInsetsMake(0, 5, 0, 5))];
    NSArray *toFramesTwo = [self.bottomMenuView.secondViewArrs viewFramesHorizontallyLayoutInFrame:CGRectMake(0, 120, 300, 150) withViewEdgeInsets:(UIEdgeInsetsMake(15, 10,15, 10))];
    
    if ( !flyOut ) {
        self.bottomMenuView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomMenuView.backgroundColor = [UIColor grayColor];
        }];
        [self.bottomMenuView.viewArrs animateViewsFromFrames:fromFramesOne toFrames:toFramesOne duration:0.3 interval:0.01 completion:^{
            [self.bottomMenuView.secondViewArrs animateViewsFromFrames:fromFramesTwo toFrames:toFramesTwo duration:0.3 interval:0.01 completion:^{
            }];
        }];
    } else { 
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomMenuView.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
        }];
        [self.bottomMenuView.viewArrs animateViewsFromFrames:toFramesOne toFrames:fromFramesOne duration:0.3 interval:0.01 completion:^{
            [self.bottomMenuView.secondViewArrs animateViewsFromFrames:toFramesTwo toFrames:fromFramesTwo duration:0.3 interval:0.01 completion:^{
                self.bottomMenuView.hidden = YES;
            }];
        }];
    }
}

@end
