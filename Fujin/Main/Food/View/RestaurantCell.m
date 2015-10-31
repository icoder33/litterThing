//
//  RestaurantCell.m
//  Fujin
//
//  Created by wanggf on 15/8/18.
//  Copyright (c) 2015年 wanggf. All rights reserved.
//

#import "RestaurantCell.h"
#import "UIImageView+WebCache.h"

@implementation RestaurantCell



- (void)awakeFromNib {
    // Initialization code
    self.restaurantImage.layer.cornerRadius = CGRectGetHeight(self.restaurantImage.bounds)/2;
    self.restaurantImage.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setRestaurant:(Restaurant *)restaurant{
    _restaurant = restaurant;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self.restaurantImage sd_setImageWithURL:[NSURL URLWithString:self.restaurant.imageAddress] placeholderImage:[UIImage imageNamed:@"plachImage.jpg"]];
    self.restaurantName.text = self.restaurant.restaurantName;
    self.restaurantKind.text = self.restaurant.restuarantKind;
    self.distance.text = [NSString stringWithFormat:@"距离%.1f",self.restaurant.distance];
    //self.cost.text = [NSString stringWithFormat:@"消费%.1f",self.restaurant.cost];
    self.average.text = [NSString stringWithFormat:@"评分%.1f",self.restaurant.score];
    //self.restaurantAddress.text = self.restaurant.address;
    
    
    
    
}


@end
