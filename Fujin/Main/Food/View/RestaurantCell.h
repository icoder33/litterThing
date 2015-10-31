//
//  RestaurantCell.h
//  Fujin
//
//  Created by wanggf on 15/8/18.
//  Copyright (c) 2015年 wanggf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"

@interface RestaurantCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantKind;
@property (weak, nonatomic) IBOutlet UILabel *average;
@property (weak, nonatomic) IBOutlet UILabel *distance;
//@property (weak, nonatomic) IBOutlet UILabel *cost;
@property (strong,nonatomic) Restaurant *restaurant;

//@property (weak, nonatomic) IBOutlet UILabel *restaurantAddress;

@end
