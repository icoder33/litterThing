//
//  WeatherTableViewCell.h
//  Weather
//
//  Created by Jorn.Wu on 15/8/30.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@class DayWeatherModel;
@interface WeatherTableViewCell : UITableViewCell

@property (nonatomic, strong) DayWeatherModel *weatherModel;

@end
