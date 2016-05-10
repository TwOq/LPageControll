//
//  LPageControll.h
//  PopAnimationDemo
//
//  Created by lizq on 16/5/9.
//  Copyright © 2016年 w jf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPageControllProtocol;

@interface LPageControll : UIView

@property(nonatomic) NSInteger numberOfPages;          // default is 0
@property(nonatomic) NSInteger currentPage;            // default is 0. value pinned to 0..numberOfPages-1
@property(nonatomic,strong) UIColor *pageIndicatorTintColor;
@property(nonatomic,strong) UIColor *currentPageIndicatorTintColor;
@property(nonatomic,assign) float PageWidth; // default is 12
@property(nonatomic,assign) float currentPageWidth; // default is 12
@property(nonatomic,assign) float pointInterval; // default is 6
@property(nonatomic,assign) id<LPageControllProtocol>delegate;



@end

@protocol LPageControllProtocol <NSObject>


//点击事件,拖拽事件回调
- (void)pageControll:(LPageControll*)pageControll currentPageChangedToIndex:(NSInteger)index;


@end
