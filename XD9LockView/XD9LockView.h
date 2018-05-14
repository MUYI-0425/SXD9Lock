//
//  XD9LockView.h
//  XD9LockView
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 sxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XD9LockView : UIView

- (instancetype)initWithFrame:(CGRect)frame normalImgSte:(NSString *)normal selectImgStr:(NSString *)select selectedOrder:(void (^)(NSArray *orderArr))selectedOrder;
@end
