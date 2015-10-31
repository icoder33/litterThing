//
//  DataTangAPI.h
//  DataTangAPI
//
//  Created by NSDeveloper on 12/11/14.
//  Copyright (c) 2014年 DataTang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTangAPI : NSObject

/**
 *  @brief 使用AppKey初始化SDK
 *
 *  @param key 在官网创建应用后得到的AppKey
 */
+ (void)setAppKey:(NSString *)key;

/**
 *  传入参数异步请求得到服务器返回数据
 *
 *  @param paramDict       请求参数字典
 *  @param completionBlock 请求完成后回调block
 */
+ (void)requestData:(NSDictionary *)paramDict completionBlock:(void (^)(NSDictionary *results))completionBlock;

@end
