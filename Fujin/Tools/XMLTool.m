//
//  XMLTool.m
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/5.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "XMLTool.h"

@interface XMLTool ()

@property (nonatomic, strong) NSMutableString *newString;

@end

@implementation XMLTool

- (NSString *)stringWithXMLStringData:(NSData *)stringData placeholderString:(NSString *)pString{
    if (!stringData) {
        return pString;
    }else {
        
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:stringData];
        parser.delegate = self;
        [parser parse];
        
        
        return self.newString;
        
    }
}

- (NSMutableString *)newString{
    if (!_newString) {
        _newString = [NSMutableString string];
    }
    return _newString;
}

//发现元素开始符的处理函数  （即报告元素的开始以及元素的属性)
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict{
    
    
    
    
    
    
    
}


//处理标签包含内容字符 （报告元素的所有或部分内容）
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [self.newString appendString:string];
    NSLog(@"------;;;----");
    
}


//发现元素结束符的处理函数，保存元素各项目数据（即报告元素的结束标记）
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName{
    
}


//报告解析的结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"解析完成！");
}


//报告不可恢复的解析错误
- (void)paser:parserErrorOccured{
    NSLog(@"解析错误！");
}



@end
