//
//  ScenicSpotWebDataSerVice.h
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/4.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^requestCompleteBlock)(id result);

@interface ScenicSpotWebDataService : NSObject

@property (nonatomic, assign) NSInteger tag;    //标识

/**
 * 获取景点数据方法
 */
- (instancetype)initWithUrl:(NSString *)mUrl
                  parameter:(NSDictionary *)mParameter
                     result:(requestCompleteBlock)block;

/**
 * 获取景点数据便利构造方法
 */
+ (instancetype)scenicSpotDataWithUrl:(NSString *)mUrl
                            parameter:(NSDictionary *)mParameter
                               result:(requestCompleteBlock)block;

/**
 * 获取景点列表方法
 */
+ (instancetype)scenicSpotListWithparameter:(NSDictionary *)mParameter
                             result:(requestCompleteBlock)block;

/**
 * 获取景点详情方法
 */
+ (instancetype)scenicSpotInfoWithparameter:(NSDictionary *)mParameter
                             result:(requestCompleteBlock)block;

@end
