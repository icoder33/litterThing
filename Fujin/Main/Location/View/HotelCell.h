//
//  HotelCell.h
//  Fujin
//
//  Created by wanggf on 15/8/20.
//  Copyright (c) 2015年 wanggf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hotel.h"
#import "StarView.h"

@interface HotelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *hotelName;
@property (weak, nonatomic) IBOutlet UILabel *hotelAddress;
@property (weak, nonatomic) IBOutlet UILabel *userScore;
@property (weak, nonatomic) Hotel *hotel;
@property (weak, nonatomic) IBOutlet StarView *starView;


@end
