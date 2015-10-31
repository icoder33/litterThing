//
//  UILabel+Extension.h
//  Weather
//
//  Created by Jorn.Wu on 15/8/31.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

+ (instancetype)lableWithFrame:(CGRect)frame
                          text:(NSString *)text
                     textColor:(UIColor *)color
                          font:(UIFont *)font;

@end
