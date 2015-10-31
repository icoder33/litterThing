//
//  GFLocationHeadView.m
//  附近
//
//  Created by wanggf on 15/8/15.
//  Copyright (c) 2015年 wanggf. All rights reserved.
//

#import "GFLocationHeadView.h"

@implementation GFLocationHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel * __nonnull)carousel{
   // NSLog(@"%d",self.items.count);
    
    return self.items.count;
}


- (UIView *)carousel:(iCarousel * __nonnull)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view{
    
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180.0f, 180.0f)];
        view.contentMode = UIViewContentModeCenter;
        view.backgroundColor = [UIColor colorWithRed: (arc4random() % 256 / 256.0 ) green: ( arc4random() % 256 / 256.0 ) blue: ( arc4random() % 256 / 256.0 ) alpha:1];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, 200, 50)];
        label.text = self.items[index];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        return view;
    
}

- (void)setItems:(NSArray *)items{
    _items = items;
    [self reloadData];
}


@end
