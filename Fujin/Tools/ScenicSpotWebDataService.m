//
//  ScenicSpotWebDataSerVice.m
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/4.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "ScenicSpotWebDataService.h"

@interface ScenicSpotWebDataService ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSMutableData *mData;


@end

@implementation ScenicSpotWebDataService

- (instancetype)initWithUrl:(NSString *)mUrl
                  parameter:(NSDictionary *)mParameter
                     result:(requestCompleteBlock)block{
    
    if (self = [super init]) {
        /**
         * 基础接口URL
         */
        NSString *urlStr = [[NSString alloc]initWithFormat: @"%@%@", kScenicSpotURL, mUrl];
        
        
        /**
         * 拼接参数
         */
        NSArray *allKeys = [mParameter allKeys];
        NSMutableString *paramString = [NSMutableString string];
        for (NSString *key in allKeys) {
            
            NSString *value = mParameter[key];
            
            if ([key isEqualToString:[allKeys lastObject]]) {
                [paramString appendFormat:@"%@=%@",key,value];      //最后一个不用加
            }else {
                [paramString appendFormat:@"%@=%@&",key,value];     //&  为连接符
            }
            
        }
        
        /**
         * 添加appkey
         */
        [paramString insertString:[NSString stringWithFormat:@"key=%@&",kScenicSpotAPPKey] atIndex:0];
        
        
        /**
         * 构建完整的URL String
         */
        NSString *pramasUrlString = [NSString stringWithFormat:@"%@?%@",urlStr,paramString];
        NSLog(@"%@",pramasUrlString);
        
        
        /**
         * 源url字符串中有中文或其他特别字符，要先编码
         */
        NSString *decodeStr = [pramasUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        /**
         * 构建request
         */
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:decodeStr] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
        [request setHTTPMethod: @"GET"];
        
        
        
        /**
         * 发送异步请求
         */
        [NSURLConnection sendAsynchronousRequest: request
                                           queue: [NSOperationQueue mainQueue]
                               completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                                   if (error) {
                                       NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                                   } else {
                                       /**
                                        * 相应代号
                                        */
                                       //                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                       //                                   NSLog(@"HttpResponseCode:%ld", responseCode);
                                       
                                       /**
                                        * 返回数据
                                        */
                                       id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                       
                                       /**
                                        * 将数据保存到block中
                                        */
                                       block(result);
                                       
                                   }
                               }];
    }
    return self;
}

+ (instancetype)scenicSpotDataWithUrl:(NSString *)mUrl
                    parameter:(NSDictionary *)mParameter
                       result:(requestCompleteBlock)block{

    return [[self alloc] initWithUrl:mUrl parameter:mParameter result:block];
    
}

+ (instancetype)scenicSpotListWithparameter:(NSDictionary *)mParameter
                             result:(requestCompleteBlock)block{
    return [self scenicSpotDataWithUrl:kSearchScenicSpotURL parameter:mParameter result:block];
}

+ (instancetype)scenicSpotInfoWithparameter:(NSDictionary *)mParameter
                             result:(requestCompleteBlock)block{
    return [self scenicSpotDataWithUrl:kScenicSpotIfonURL parameter:mParameter result:block];
}


@end
