//
//  ScenicSpotProductAddInfoDetailModel.h
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/5.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "BaseModel.h"

//    "DescDetail": "★当今世界上保存完整、埋藏皇帝最多的墓葬群！",
//    "EffectDate": "1900-01-01 00:00:00.00",
//    "ExpireDate": "9999-01-01 00:00:00.00",
//    "IsHighlight": false,
//    "SortNum": 0,
//    "StringURL": null,
//    "URL": 0

@interface ScenicSpotProductAddInfoDetailModel : BaseModel

@property (nonatomic, copy) NSString *DescDetail;
@property (nonatomic, copy) NSString *EffectDate;
@property (nonatomic, copy) NSString *ExpireDate;



@end
