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
@property (strong, nonatomic) MenuView *longPressView;

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
    
    NSLog(@"width:%f,height:%f",self.view.width,self.view.height);
    
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
    self.longPressView.bounds = self.view.bounds;
    //获取触摸点的位置
    NSArray *toCenters = [NSArray array];
    [self.view addSubview:self.longPressView];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            
            CGPoint point =[gesture locationInView:self.longPressView];
            
            NSLog(@"gesturePoints:%@,subviewpoints: %@",NSStringFromCGPoint(point),self.longPressView.viewArrs);
            [self.longPressView.viewArrs enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL * stop) {
                obj.frame  = CGRectMake(0, 0, 72, 108);
            }];
            NSValue *pointValue = [NSValue valueWithCGPoint:point];
            NSArray *fromCenters = @[pointValue,pointValue,pointValue];
            if (point.x > self.view.width-72) {
                toCenters = [self.longPressView.viewArrs viewCentersOnArcWithCenter:point radian:(M_PI_4*2.5) viewArcLength:110 startAngle:(M_PI-M_PI_4*2.5/2)];
            }else {
                toCenters = [self.longPressView.viewArrs viewCentersOnArcWithCenter:point radian:(M_PI_4*2.5) viewArcLength:110 startAngle:-(M_PI_4*2.5/2)];
            }
            
            //NSArray *toCenters = [self.longPressView.viewArrs viewCentersOnArcWithCenter:point radian:(M_PI_4*2.5) viewArcLength:110 startAngle:-(M_PI_4*2.5/2)];
            [self.longPressView.viewArrs animateViewsFromCenters:fromCenters toCenters:toCenters completion:^{
                
            }];
        }
            break;
        case UIGestureRecognizerStateEnded:  {
            [self.longPressView removeFromSuperview];
        }
        case UIGestureRecognizerStateCancelled: {
            [self.longPressView removeFromSuperview];
        }
            
        default:
            break;
    }
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.leftBtn.frame = CGRectMake(0, 450, 80, 80);
    self.menuView.frame = CGRectMake(0, 450-360, 80, 360);
    
    self.leftBottomBtn.frame = CGRectMake(0, self.view.bottom-80, 80, 80);
    self.leftBottomMenuView.frame = CGRectMake(self.view.center.y*0.5, 90, 80, 360);
    
    CGFloat bottomMenuViewX = (self.view.width-300)*0.5;
    CGFloat bottomMenuViewY = (self.view.height-150) *0.7;
    self.bottomBtn.frame = CGRectMake((self.view.width-80)*0.5, self.view.bottom-80, 80, 80);
    self.bottomMenuView.frame = CGRectMake(bottomMenuViewX, bottomMenuViewY, 300, 280);
    self.longPressView.frame = self.view.frame;
    
    
}

- (MenuView *)longPressView{
    if (nil == _longPressView) {
        _longPressView = [[MenuView alloc]init];
        _longPressView.backgroundColor = [UIColor clearColor];
    }
    return _longPressView;
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
    NSArray *fromFrames = [self.menuView.viewArrs viewFramesVerticallyLayoutInFrame:CGRectMake(-80, 0, 80, 360) withViewEdgeInsets:(UIEdgeInsetsMake(5, 0, 5, 0))];
    NSArray *toFrames = [self.menuView.viewArrs viewFramesVerticallyLayoutInFrame:self.menuView.bounds withViewEdgeInsets:(UIEdgeInsetsMake(5, 0, 5, 0))];
    if (! sender.isSelected) {      // out
        [UIView animateWithDuration:0.3 animations:^{
            self.menuView.backgroundColor = [UIColor lightGrayColor];
        }];
        [self.menuView.viewArrs animateViewsFromFrames:fromFrames toFrames:toFrames duration:0.2 interval:0.0 completion:^{
        }];
    } else {                       // in
        [UIView animateWithDuration:0.3 animations:^{
            self.menuView.backgroundColor = [UIColor whiteColor];
        }];
        [self.menuView.viewArrs animateViewsFromFrames:toFrames toFrames:fromFrames duration:0.2 interval:0.0 completion:^{
        }];
    }
    sender.selected = ! sender.isSelected;
}

- (void)leftBottomBtnClicked:(UIButton *)btn{
    CGRect fromFrame = CGRectMake(-80, self.view.bottom, 80, 120);
    fromFrame = [self.view convertRect:fromFrame toView:self.leftBottomMenuView];
    
    NSArray *toFrames = [self.leftBottomMenuView.viewArrs viewFramesVerticallyLayoutInFrame:self.leftBottomMenuView.bounds withViewEdgeInsets:(UIEdgeInsetsMake(5, 0, 5, 0))];
    if (! btn.isSelected) { // fly in
        [UIView animateWithDuration:0.3 animations:^{
            self.leftBottomMenuView.backgroundColor = [UIColor lightGrayColor];
        }];
        [self.leftBottomMenuView.viewArrs animateViewsFromFrame:fromFrame toFrames:toFrames completion:^{
            
        }];
        //        self.view.backgroundColor = [UIColor lightGrayColor];
    } else { // fly out
        [UIView animateWithDuration:0.3 animations:^{
            self.leftBottomMenuView.backgroundColor = [UIColor whiteColor];
        }];
        [self.leftBottomMenuView.viewArrs animateViewsFromFrames:toFrames toFrame:fromFrame completion:^{
            
        }];
        //        self.view.backgroundColor = [UIColor whiteColor];
    }
    btn.selected = ! btn.isSelected;
}

- (void)bottomBtnClicked:(UIButton *)btn{
    
    NSArray *fromFramesOne = [self.bottomMenuView.viewArrs viewFramesHorizontallyLayoutInFrame:CGRectMake((self.view.width-360)*0.5, self.view.bottom, 360, 80) withViewEdgeInsets:(UIEdgeInsetsMake(0, 5, 0, 5))];
    NSArray *toFramesOne = [self.bottomMenuView.viewArrs viewFramesHorizontallyLayoutInFrame:CGRectMake(0, 0, 300, 150) withViewEdgeInsets:(UIEdgeInsetsMake(15, 10, 15, 10))];
    NSArray *fromFramesTwo = [self.bottomMenuView.secondViewArrs viewFramesHorizontallyLayoutInFrame:CGRectMake((self.view.width-360)*0.5, self.view.bottom, 360, 80) withViewEdgeInsets:(UIEdgeInsetsMake(0, 5, 0, 5))];
    NSArray *toFramesTwo = [self.bottomMenuView.secondViewArrs viewFramesHorizontallyLayoutInFrame:CGRectMake(0, 120, 300, 150) withViewEdgeInsets:(UIEdgeInsetsMake(15, 10,15, 10))];
    
    if (! btn.isSelected) {      // out
        [UIView animateWithDuration:0.3 animations:^{
            //self.bottomMenuView.backgroundColor = [UIColor redColor];
        }];
        [self.bottomMenuView.viewArrs animateViewsFromFrames:fromFramesOne toFrames:toFramesOne duration:0.1 interval:0.0 completion:^{
            [self.bottomMenuView.secondViewArrs animateViewsFromFrames:fromFramesTwo toFrames:toFramesTwo duration:0.2 interval:0.0 completion:^{
                
            }];
        }];
    } else {                       // in
        [UIView animateWithDuration:0.3 animations:^{
            // self.bottomMenuView.backgroundColor = [UIColor clearColor];
        }];
        [self.bottomMenuView.viewArrs animateViewsFromFrames:toFramesOne toFrames:fromFramesOne duration:0.1 interval:0.0 completion:^{
            [self.bottomMenuView.secondViewArrs animateViewsFromFrames:toFramesTwo toFrames:fromFramesTwo duration:0.2 interval:0.0 completion:^{
                
            }];
        }];
    }
    btn.selected = !btn.isSelected;
    
}



@end

