//
//  XMLTool.h
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/5.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLTool : NSObject<NSXMLParserDelegate>

/**
 * 解析XML字符串
 */
- (NSString *)stringWithXMLStringData:(NSData *)stringData placeholderString:(NSString *)pString;


@end
