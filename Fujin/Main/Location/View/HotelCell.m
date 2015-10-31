//
//  HotelCell.m
//  Fujin
//
//  Created by wanggf on 15/8/20.
//  Copyright (c) 2015年 wanggf. All rights reserved.
//

#import "HotelCell.h"

@implementation HotelCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHotel:(Hotel *)hotel{
    _hotel = hotel;
   
    [self setNeedsLayout];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.hotelName.text = self.hotel.hotelName;
    self.hotelAddress.text = self.hotel.hotelAddress;
    //NSString *str = _hotel.score;
    self.userScore.text = [NSString stringWithFormat:@"评分:%.2f",self.hotel.score.floatValue];
    self.starView.average = self.hotel.rating.floatValue * 2;
    
}

@end
