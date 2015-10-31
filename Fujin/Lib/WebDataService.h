//
//  WebDataService.h
//  Weather
//
//  Created by Jorn.Wu on 15/8/28.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^requestCompleteBlock)(id result);

@interface WebDataService : NSObject


/**
 * 通过接口和参数请求天气网络数据（GET）
 */
+ (void)weatherIfonWithUrl:(NSString *)mUrl
                 parameter:(NSDictionary *)mParameter
                    result:(requestCompleteBlock)block;

/**
  * 通过城市名查询当前详细天气
  */
+ (void)weatherIfonWithCityName:(NSString *)cityName
                         result:(requestCompleteBlock)block;

@end
