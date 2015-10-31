//
//  Restaurant.h
//  Fujin
//
//  Created by wanggf on 15/8/18.
//  Copyright (c) 2015年 wanggf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject

@property (nonatomic,strong) NSString *imageAddress;
@property (nonatomic,assign) float score;
@property (nonatomic,assign) float distance;
@property (nonatomic,strong) NSString *restaurantName;
@property (nonatomic,strong) NSString *restuarantKind;
@property (nonatomic,assign) float cost;
@property (nonatomic,strong) NSString *address;

@end
