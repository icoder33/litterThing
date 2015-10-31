//
//  DayWeatherModel.m
//  Weather
//
//  Created by Jorn.Wu on 15/8/30.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "DayWeatherModel.h"

@implementation DayWeatherModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    return;
}

+ (instancetype)weatherModelWithDictionary:(NSDictionary *)dic{
    return [[self alloc] initWithDictionary:dic];
}




@end
