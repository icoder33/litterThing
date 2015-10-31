//
//  WeatherTableViewCell.m
//  Weather
//
//  Created by Jorn.Wu on 15/8/30.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "WeatherTableViewCell.h"
#import "DayWeatherModel.h"

@interface WeatherTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *weekLb;
@property (weak, nonatomic) IBOutlet UILabel *dateLb;
@property (weak, nonatomic) IBOutlet UILabel *tempLb;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;

@end

@implementation WeatherTableViewCell

- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor clearColor];        //去掉颜色
    self.selectionStyle = UITableViewCellSelectionStyleNone;        //去掉选中背景色
    
}

//Model
//@property (nonatomic, copy) NSString *data;
//@property (nonatomic, copy) NSString *week;
//@property (nonatomic, copy) NSString *aqi;
//@property (nonatomic, copy) NSString *fengxiang;
//@property (nonatomic, copy) NSString *fengji;
//@property (nonatomic, copy) NSString *hightemp;
//@property (nonatomic, copy) NSString *lowtemp;
//@property (nonatomic, copy) NSString *type;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];        //去掉颜色
        self.selectionStyle = UITableViewCellSelectionStyleNone;        //去掉选中背景色
    }
    return self;
}

- (void)setWeatherModel:(DayWeatherModel *)weatherModel{
    if (_weatherModel != weatherModel) {
        _weatherModel = weatherModel;
        
        self.weekLb.text = weatherModel.week;
        self.dateLb.text = weatherModel.date;
        self.tempLb.text = [NSString stringWithFormat:@"%@ ~ %@",weatherModel.lowtemp,weatherModel.hightemp];
        
#warning ---------根据天气类型找相应的图标，暂未设
//        NSString *weatherType = weatherModel.type;
        
//        self.weatherIcon.image = [UIImage imageNamed:nil];
        
#warning ---------样式可以展开，暂未设
        
  
    }
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
