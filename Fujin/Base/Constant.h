//
//  Constant.h
//  Weather
//
//  Created by Jorn.Wu on 15/8/28.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#ifndef Weather_Constant_h
#define Weather_Constant_h


/**
 * 天气预报网络接口
 */
#define BaseUrl @"http://apis.baidu.com/apistore/weatherservice"

/**
 * 最近天气请求接口
 */
#define recentWeathersUrl @"/recentweathers"

/**
 * 当天天气详情接口
 */
#define todayWeathersUrl @"/cityname"

#define apikey @"95ef137041c164e44a15ff7c85d72e5e"

/**
 * 屏幕尺寸
 */
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

/**
 * 景点接口
 */
#define kScenicSpotURL @"http://api2.juheapi.com/xiecheng/senicspot/ticket"

/**
 * 查询接口
 */
#define kSearchScenicSpotURL @"/search"

/**
 * 详情接口
 */
#define kScenicSpotIfonURL @"/info"

/**
 * appkey
 */
#define kScenicSpotAPPKey @"d37b11d6ab2efbeaeacd682e7e34035c"


#endif
