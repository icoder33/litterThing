//
//  DataService.m
//  HWMovie
//
//  Created by gj on 15/7/18.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "DataService.h"
#import <AFNetworking.h>


@implementation DataService

+ (void)requestUrl:(NSString *)urlString httpMethod:(NSString *)method params:(NSMutableDictionary *)params block:(BlockType)block{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    if ([method isEqualToString:@"GET"]) {
        
        [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"请求成功");
            block(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"请求失败");
        }];
    }else if([method isEqualToString:@"POST"]){
        
        [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"请求成功");
            block(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"请求失败");
        }];
    }
    
}

@end
