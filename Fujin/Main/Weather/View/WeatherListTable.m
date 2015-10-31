//
//  WeatherListTable.m
//  Weather
//
//  Created by Jorn.Wu on 15/8/30.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "WeatherListTable.h"
#import "WeatherTableViewCell.h"
#import "DayWeatherModel.h"

@interface WeatherListTable ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation WeatherListTable

static NSString  *cellID = @"weatherCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSelectionStyleDefault;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        
        /**
         * 注册cell类(再此从xib中加载过来)
         */
        [self registerNib:[UINib nibWithNibName:@"WeatherTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.weatherModelAr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    DayWeatherModel *model = self.weatherModelAr[indexPath.row];
    cell.weatherModel = model;
    
    
    return cell;
    
    
}



@end
