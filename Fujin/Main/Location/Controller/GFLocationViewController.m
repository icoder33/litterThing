//
//  GFLocationViewController.m
//  附近
//
//  Created by wanggf on 15/8/15.
//  Copyright (c) 2015年 wanggf. All rights reserved.
//

#import "GFLocationViewController.h"
#import "GFLocationHeadView.h"
#import "common.h"
#import <MAMapKit/MAMapKit.h>

@interface GFLocationViewController ()<MAMapViewDelegate>{
    NSArray *_items;
    MAMapView *_mapView;
    UIButton *_showBtn;
    BOOL _show;
    GFLocationHeadView *_headView;
}

@end

@implementation GFLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setUpMapView];
    [self setUpHeadView];
    [self createShowBtn];
    
    
    
}


- (void)setUpHeadView{
    _headView = [[GFLocationHeadView alloc]initWithFrame:CGRectMake(0, 64, kWidth, 180)];
    _headView.type = iCarouselTypeInvertedCylinder;
    _headView.items = _items;
    _headView.bounceDistance = 0.2f;
    _headView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_headView];
    
}

- (void)setUpMapView{
    [MAMapServices sharedServices].apiKey = @"26cd290864c862f3c66a397ae64e2e88";
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.showTraffic= YES;
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:_mapView];
}

- (void)createShowBtn{
    
    _showBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth/2 - 10, 244, 20, 20)];
    //[btn setBackgroundColor:[UIColor redColor]];
    [_showBtn setBackgroundImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateNormal];
    [_showBtn addTarget:self action:@selector(changeState) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_showBtn];
}

- (void)changeState{
    
     _show = !_show;
    
    if (_show) {
        [_showBtn setBackgroundImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.5f animations:^{
            _headView.transform = CGAffineTransformTranslate(_headView.transform, 0, -180);
            _showBtn.transform = CGAffineTransformTranslate(_showBtn.transform, 0, -180);
        } completion:^(BOOL finished) {
            _headView.hidden = YES;
        }];
       
    }else{
        [_showBtn setBackgroundImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5f animations:^{
            _headView.transform = CGAffineTransformTranslate(_headView.transform, 0, 180);
            _showBtn.transform = CGAffineTransformTranslate(_showBtn.transform, 0, 180);
            _headView.hidden = NO;
        }];
        
    }
}

- (void)loadData{
    _items = @[@"去运动",@"去影院",@"去K歌",@"去医院",@"去酒吧",@"去网咖"];
    //NSLog(@"%d",_items.count);
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        //NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}



@end
