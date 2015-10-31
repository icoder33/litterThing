//
//  NSString+EXtension.m
//  Weather
//
//  Created by Jorn.Wu on 15/8/31.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "NSString+EXtension.h"

@implementation NSString (EXtension)

+ (instancetype)stringWithString:(NSString *)string placeholderString:(NSString *)pString{
    if (!string) {
        return [self stringWithString:pString];
    }else {
        return [self stringWithString:string];
    }
}

@end
