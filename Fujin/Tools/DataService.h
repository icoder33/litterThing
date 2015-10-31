//
//  DataService.h
//  HWMovie
//
//  Created by gj on 15/7/18.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BlockType)(id result);

@interface DataService : NSObject


+ (void)requestUrl:(NSString *)urlString //url
        httpMethod:(NSString *)method //GET  POST
            params:(NSMutableDictionary *)params //参数
             block:(BlockType)block; //接收到的数据的处理
@end
