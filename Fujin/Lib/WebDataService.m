//
//  WebDataService.m
//  Weather
//
//  Created by Jorn.Wu on 15/8/28.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "WebDataService.h"
#import "Constant.h"

@interface WebDataService ()<NSURLSessionDelegate,NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation WebDataService

+ (void)weatherIfonWithUrl:(NSString *)mUrl
                 parameter:(NSDictionary *)mParameter
                    result:(requestCompleteBlock)block{
    

    /**
     * 基础接口URL
     */
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@%@", BaseUrl, mUrl];
    
    
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
     * 构建完整的URL String
     */
    NSString *pramasUrlString = [NSString stringWithFormat:@"%@?%@",urlStr,paramString];

    
    /**
     * 源url字符串中有中文或其他特别字符，要先编码
     */
    NSString *decodeStr = [pramasUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    /**
     * 构建request
     */
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:decodeStr] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue:apikey forHTTPHeaderField: @"apikey"];


    
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



+ (void)weatherIfonWithCityName:(NSString *)cityName
                         result:(requestCompleteBlock)block{
    
    [self weatherIfonWithUrl:todayWeathersUrl parameter:@{@"cityname" : cityName} result:block];
    
}


@end


























