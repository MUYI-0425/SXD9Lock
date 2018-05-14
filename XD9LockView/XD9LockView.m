//
//  XD9LockView.m
//  XD9LockView
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 sxd. All rights reserved.
//

#import "XD9LockView.h"

@interface XD9LockView()
@property (nonatomic,strong)NSMutableArray <UIButton *>*btnArray;
@property (nonatomic)CGPoint point;
@property (nonatomic,copy)void (^innerOrderSelect)(NSArray *tempA);
@end

@implementation XD9LockView

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (instancetype)initWithFrame:(CGRect)frame normalImgSte:(NSString *)normal selectImgStr:(NSString *)select selectedOrder:(void (^)(NSArray *orderArr))selectedOrder {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self set9BtnNormal:normal select:select];
        self.innerOrderSelect = selectedOrder;
    }
    return self;
}

- (void)set9BtnNormal:(NSString *)normal select:(NSString *)select {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    UIImage *normalImg = [UIImage imageNamed:normal];
    CGFloat width = normalImg.size.width;
    CGFloat height = normalImg.size.height;
    int clos = 3;
    CGFloat margin = (self.frame.size.width - clos * width) / 4;
    int top = 120;
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat x = margin + i % clos * (width + margin);
        CGFloat y = top + i / clos * (margin + height);
        btn.frame = CGRectMake(x, y, width, height);
        btn.tag = i;
        [btn setImage:normalImg forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:select] forState:UIControlStateSelected];
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
    }
}

- (void)pan:(UIPanGestureRecognizer *)sender {
    self.point = [sender locationInView:self];
    NSArray <UIButton *>*btnA = self.subviews;
    for (UIButton *btn in btnA) {
        if (CGRectContainsPoint(btn.frame, self.point) && !btn.selected) {
            btn.selected = YES;
            [self.btnArray addObject:btn];
        }
    }
    if(sender.state == UIGestureRecognizerStateEnded) {
        NSMutableArray *strM = [NSMutableArray array];
        for (UIButton *btn in self.btnArray) {
            [strM addObject:@(btn.tag)];
        }
        if (self.innerOrderSelect) {
            self.innerOrderSelect(strM);
            [self clearLine];
        }
    }
    [self setNeedsDisplay];
}

- (void)clearLine {
    NSArray <UIButton *>*btnA = self.subviews;
    for (UIButton *btn in btnA) {
        btn.selected = NO;
    }
    [self.btnArray removeAllObjects];
}

- (void)drawRect:(CGRect)rect {
    if (self.btnArray.count == 0) return;
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < self.btnArray.count; i++) {
        UIButton *btn = self.self.btnArray[i];
        if (i == 0) {
            [path moveToPoint:btn.center];
        }else {
            [path addLineToPoint:btn.center];
        }
    }
    [[UIColor greenColor] set];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 10;
    [path stroke];
}


@end
