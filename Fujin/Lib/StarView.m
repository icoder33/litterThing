//
//  StarView.m
//  HWMovie
//
//  Created by gj on 15/7/21.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "StarView.h"


//- (void)testStar{
//    UIImage *image1 = [UIImage imageNamed:@"yellow"];
//    UIImage *image2 = [UIImage imageNamed:@"gray"];
//    
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, image1.size.width*3.5, image1.size.height)];
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, image2.size.width*5, image1.size.height)];
//    
//    view1.backgroundColor = [UIColor colorWithPatternImage:image1];
//    view2.backgroundColor = [UIColor colorWithPatternImage:image2];
//    
//    [self.view addSubview:view2];
//    [self.view addSubview:view1];
//    
//}

@implementation StarView

//当alloc 手动创建对象的时候调用此方法
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubviews];
        
    }
    
    return  self;
}

//从xib创建出来的时候调用此方法
- (void)awakeFromNib{
    
    [self _createSubviews];
    
}



- (void)_createSubviews{
    UIImage *yellowImage = [UIImage imageNamed:@"yellow"];
    UIImage *grayImage = [UIImage imageNamed:@"gray"];
    
    _grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, grayImage.size.width*5, grayImage.size.height)];
    _grayView.backgroundColor = [UIColor colorWithPatternImage:grayImage];
    
    _yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, yellowImage.size.width*5, yellowImage.size.height)];
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImage];
    
    
    [self addSubview:_grayView];
    [self addSubview:_yellowView];
    
    
    //放大倍数
    float scale = self.frame.size.height/grayImage.size.height;
    
    
    
    _grayView.transform = CGAffineTransformMakeScale(scale, scale);
    _yellowView.transform = CGAffineTransformMakeScale(scale, scale);

    //放大以后坐标需要调整
    CGRect frame = _grayView.frame;
    frame.origin = CGPointZero;
    _grayView.frame = frame;
    
    _yellowView.frame = frame;
    
}

- (void)setAverage:(float)average{
    
    _average = average;
    [self setNeedsLayout];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //根据评分 来设置黄色星星的宽度 
    float width = _average/10.0 * _grayView.frame.size.width;
    
    CGRect frame = _grayView.frame;
    
    frame.size.width = width;
    
    _yellowView.frame = frame;
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
