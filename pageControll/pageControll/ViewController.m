//
//  ViewController.m
//  pageControll
//
//  Created by lizq on 16/5/10.
//  Copyright © 2016年 w jf. All rights reserved.
//

#import "ViewController.h"
#import "LPageControll.h"

@interface ViewController ()<LPageControllProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LPageControll *page = [[LPageControll alloc] initWithFrame:CGRectMake(100, 100, 150,60)];
    page.currentPageIndicatorTintColor = [UIColor clearColor];
    page.pageIndicatorTintColor = [UIColor blueColor];
    page.numberOfPages = 5;
    page.delegate = self;
    page.PageWidth = 14;
    page.currentPageWidth = 20;
    page.currentPage = 2;
    page.pointInterval = 6;
    [self.view addSubview:page];

    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)pageControll:(LPageControll *)pageControll currentPageChangedToIndex:(NSInteger)index{
    
    
    NSLog(@"代理   %lu",(unsigned long)index);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
