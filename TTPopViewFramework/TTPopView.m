//
//  TTPopView.m
//  TTPopView
//
//  Created by le tong on 2019/11/20.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "TTPopView.h"

@interface TTPopView()

@property (nonatomic, strong)UIView *TTShaperView;
@property (nonatomic, strong)UIButton *TTButton;
@end

@implementation TTPopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.layer.cornerRadius = 10.0f;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.TTButton];
    }
    return self;
}

/**
 弹出视图
 
 @param block 如果视图有操作按钮
 @return 返回操作结果
 */
+ (instancetype)TTPopViewWithblocks:(TTPopViewBlock)block{
    TTPopView * popView = [[TTPopView alloc]init];
    popView = [[TTPopView alloc]initWithFrame:CGRectMake(0, 0, 275, 246)];
    popView.backgroundColor = [UIColor redColor];
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    [keyWindow addSubview:popView.TTShaperView];
    [keyWindow addSubview:popView];
    popView.center = keyWindow.center;
    // 第一步：将view宽高缩至无限小（点）
    popView.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                            CGFLOAT_MIN, CGFLOAT_MIN);
    [UIView animateWithDuration:0.2
                     animations:^{
                         // 第三步： 以动画的形式将view恢复至原始大小
                         popView.transform = CGAffineTransformIdentity;
                     }];
    popView.block = block;
    return popView;
}
- (void)selectedTTButton:(UIButton *)sender{
    [self hideWeatherPopView];
    self.block(YES);
}
/**
 隐藏视图
 */
- (void)hideWeatherPopView{
    [UIView animateWithDuration:0.3
                     animations:^{
                         // 第二步： 以动画的形式将view缩小至原来的1/1000分之1倍
                         self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                         self.TTShaperView.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         // 第三步： 移除
                         [self.TTShaperView removeFromSuperview];
                         [self removeFromSuperview];
                     }];
}

// 弹出视图阴影view
- (UIView *)TTShaperView{
    if (!_TTShaperView) {
        
        _TTShaperView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _TTShaperView.backgroundColor = [UIColor blackColor];
        _TTShaperView.alpha = 0.0;
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideWeatherPopView)];
        [_TTShaperView addGestureRecognizer:tapGesture];
    }
    return _TTShaperView;
}

- (UIButton *)TTButton{
    if (!_TTButton) {
        _TTButton = [[UIButton alloc]initWithFrame:CGRectMake(275 / 2.0 - 20, 0, 40, 40)];
        _TTButton.backgroundColor = [UIColor blueColor];
        [_TTButton addTarget:self action:@selector(selectedTTButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _TTButton;
}

@end
