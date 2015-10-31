//
//  DayWeatherModel.h
//  Weather
//
//  Created by Jorn.Wu on 15/8/30.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DayWeatherModel : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *week;
@property (nonatomic, copy) NSString *aqi;
@property (nonatomic, copy) NSString *fengxiang;
@property (nonatomic, copy) NSString *fengli;
@property (nonatomic, copy) NSString *curTemp;      //今天的当前温度（其他天为nil）
@property (nonatomic, copy) NSString *hightemp;
@property (nonatomic, copy) NSString *lowtemp;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSArray *index;         //今天的提示信息（其他天为nil）

- (instancetype)initWithDictionary:(NSDictionary *)dic;

+ (instancetype)weatherModelWithDictionary:(NSDictionary *)dic;

@end
