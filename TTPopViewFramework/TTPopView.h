//
//  TTPopView.h
//  TTPopView
//
//  Created by le tong on 2019/11/20.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TTPopViewBlock)(BOOL isCancel);

@interface TTPopView : UIView

@property (nonatomic, copy)TTPopViewBlock block;
+ (instancetype)TTPopViewWithblocks:(TTPopViewBlock)block;

@end

NS_ASSUME_NONNULL_END
