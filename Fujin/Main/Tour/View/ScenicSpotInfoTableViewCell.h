//
//  ScenicSpotInfoTableViewCell.h
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/5.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScenicSpotProductAddInfoModel;
@interface ScenicSpotInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (nonatomic, strong) ScenicSpotProductAddInfoModel *productAddInfoModel;

@end
