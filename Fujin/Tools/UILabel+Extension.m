//
//  UILabel+Extension.m
//  Weather
//
//  Created by Jorn.Wu on 15/8/31.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (instancetype)lableWithFrame:(CGRect)frame
                          text:(NSString *)text
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font{
    UILabel *label = [[self alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    return label;
}

@end
