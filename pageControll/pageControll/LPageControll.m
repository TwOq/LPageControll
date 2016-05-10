//
//  LPageControll.m
//  PopAnimationDemo
//
//  Created by lizq on 16/5/9.
//  Copyright © 2016年 w jf. All rights reserved.
//

#import "LPageControll.h"
#define SPACE  6.0  //圆点间间隔
#define WIDTH  12.0 // 圆点大小
@interface LPageControll()

@property (strong, nonatomic) NSMutableArray *viewArray;
@property (assign, nonatomic) float startX;


@end

@implementation LPageControll

- (instancetype)initWithFrame:(CGRect)frame
{
    CGRect frameNew = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 30);
    self = [super initWithFrame:frameNew];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _currentPage = 0;
        _numberOfPages = 0;
        _PageWidth = WIDTH;
        _currentPageWidth = WIDTH;
        _pointInterval = SPACE;
        UIPanGestureRecognizer *panGestrue = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandel:)];
        [self addGestureRecognizer:panGestrue];
    }
    return self;
}


- (NSMutableArray *)viewArray{
    if (_viewArray == nil) {
        _viewArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _viewArray;
}

/**
 *  刷新圆点属性
 */
- (void)changeDop:(UIView*)view {

    NSUInteger index = [self.viewArray indexOfObject:view];
    if (index == self.currentPage) {
        if (self.currentPageIndicatorTintColor) {
            view.backgroundColor = self.currentPageIndicatorTintColor.copy;
            view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        }else{
            view.backgroundColor = [UIColor redColor];
            view.layer.borderColor = [UIColor whiteColor].CGColor;
        }
        view.transform = CGAffineTransformIdentity;
        view.transform = CGAffineTransformMakeScale(self.currentPageWidth/self.PageWidth, self.currentPageWidth/self.PageWidth);
        view.layer.borderWidth = 1;

    }else{
        if (self.pageIndicatorTintColor) {
            view.backgroundColor = self.pageIndicatorTintColor.copy;
        }else{
            view.backgroundColor = [UIColor lightGrayColor];
        }
        view.transform = CGAffineTransformIdentity;
        view.layer.borderColor = view.backgroundColor.CGColor;
        view.layer.borderWidth = 1;
        
    }
    
}

/**
 *  创建圆点／刷新圆心
 */
- (void)updateDopsResetFrame:(BOOL)isReset{
    float frameX = 0;
    if (self.numberOfPages == 0) {
        return;
    }
        for (int i = 0; i < self.numberOfPages; i++) {

            if (self.viewArray.count == 0 || self.viewArray.count < self.numberOfPages) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frameX + self.pointInterval, 0, self.PageWidth, self.PageWidth)];
                imageView.center = CGPointMake(imageView.center.x, self.frame.size.height/2);
                imageView.layer.cornerRadius = self.PageWidth/2;
                imageView.layer.masksToBounds = YES;
                imageView.userInteractionEnabled = YES;
                
                
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
                [imageView addGestureRecognizer:tapGesture];
                UIPanGestureRecognizer *panGestrue = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandel:)];
                [imageView addGestureRecognizer:panGestrue];
                [self addSubview:imageView];
                
                
                frameX = CGRectGetMaxX(imageView.frame);
                [self.viewArray addObject:imageView];
                [self changeDop:imageView];
                if (i == self.numberOfPages - 1) {
                    CGPoint center = self.center;
                    self.frame = CGRectMake(self.frame.origin.x,
                                            self.frame.origin.y,
                                            CGRectGetMaxX(((UIView*)[self.viewArray lastObject]).frame) + self.pointInterval,
                                            self.frame.size.height);
                    
                    self.center = center;
                }
            }else{
                UIImageView *view = [self.viewArray objectAtIndex:i];
                view.transform = CGAffineTransformIdentity;

                if (isReset) {
                    view.frame = CGRectMake(frameX + self.pointInterval, 0, self.PageWidth, self.PageWidth);
                    view.layer.cornerRadius = self.PageWidth/2.0;
                    view.center = CGPointMake(view.center.x, self.frame.size.height/2);
                    frameX = CGRectGetMaxX(view.frame);

                    if (i == self.numberOfPages - 1) {
                        CGPoint center = self.center;
                        self.frame = CGRectMake(self.frame.origin.x,
                                                self.frame.origin.y,
                                                CGRectGetMaxX(((UIView*)[self.viewArray lastObject]).frame) + self.pointInterval,
                                                self.frame.size.height);
                        
                        self.center = center;
                    }
                }
                [self changeDop:[self.viewArray objectAtIndex:i]];
            }
        }
}

#pragma mark_重写set方法

- (void)setNumberOfPages:(NSInteger)numberOfPages{
    _numberOfPages = numberOfPages;
    [self updateDopsResetFrame:NO];
}

- (void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    if (currentPage >self.numberOfPages && self.numberOfPages > 0) {
        _currentPage = self.numberOfPages - 1;
    }
    [self updateDopsResetFrame:NO];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    [self updateDopsResetFrame:NO];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    [self updateDopsResetFrame:NO];
}

- (void)setCurrentPageWidth:(float)currentPageWidth {
    _currentPageWidth = currentPageWidth;
    [self updateDopsResetFrame:NO];
}
- (void)setPageWidth:(float)PageWidth {
    _PageWidth = PageWidth;
    [self updateDopsResetFrame:YES];
}
- (void)setPointInterval:(float)pointInterval{
    _pointInterval = pointInterval;
    [self updateDopsResetFrame:YES];
}

#pragma mark_手势处理
- (void)panHandel:(UIPanGestureRecognizer*)panGestrue{
    
    if (panGestrue.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [panGestrue locationInView:self];
        self.startX = point.x;
    }
    if (panGestrue.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [panGestrue locationInView:self];
        
        if (self.startX > point.x) {
            if (self.currentPage == 0) {
                self.currentPage = self.viewArray.count - 1;
                [self updateDopsResetFrame:NO];
            }else{
                self.currentPage--;
                [self updateDopsResetFrame:NO];
            }
        }else if(self.startX < point.x){
            if (self.currentPage == (self.viewArray.count - 1)) {
                self.currentPage = 0;
                [self updateDopsResetFrame:NO];
            }else{
                self.currentPage++;
                [self updateDopsResetFrame:NO];
            }
        }
        if ([self.delegate respondsToSelector:@selector(pageControll:currentPageChangedToIndex:)]) {
            [self.delegate pageControll:self currentPageChangedToIndex:self.currentPage];
        }
    }
}



- (void)tapHandle:(UITapGestureRecognizer *)tapGestrue{

    UIView *view = tapGestrue.view;
    NSUInteger index = [self.viewArray indexOfObject:view];
    self.currentPage  = index;
    [self updateDopsResetFrame:NO];
    if ([self.delegate respondsToSelector:@selector(pageControll:currentPageChangedToIndex:)]) {
        [self.delegate pageControll:self currentPageChangedToIndex:self.currentPage];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
