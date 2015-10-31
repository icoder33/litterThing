//
//  ScenicSpotProductAddInfoModel.h
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/5.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "BaseModel.h"
#import "ScenicSpotProductAddInfoDetailModel.h"

//AddInfoSubTitleName = "\U4ea7\U54c1\U7ecf\U7406\U63a8\U8350";
//AddInfoTitleName = "\U57fa\U672c\U4fe1\U606f";
//IsRegOrder = 0;
//IsShowAtReserve = 1;
//ProductAddInfoDetailList = []
//ProductAddInfoID = 1820774;
//SortNum = 2;

//ProductAddInfoDTO参数说明
//AddInfoSubTitleName	string	产品附加信息子标题名称
//AddInfoTitleName	string	产品附加信息标题名称
//IsRegOrder	boolean	是否记入订单
//IsShowAtReserve	boolean	是否预订时显示
//ProductAddInfoDetailList	ArrayOfProductAddInfoDetailDTO	门票产品附加信息明细
//ProductAddInfoID	int	产品附加信息编号
//SortNum	int	排序号

//ProductAddInfoDetailList参数说明
//DepartureCityIDs	ArrayOfInt	关联出发城市编号
//DescDetail	string	产品附加信息描述
//EffectDate	dateTime	起始时间
//ExpireDate	dateTime	截止时间
//IsHighlight	boolean	是否高亮
//IsShowAtReserve	boolean	是否预订时显示
//SortNum	int	排序号
//URL	string	地址，相对路径

@interface ScenicSpotProductAddInfoModel : BaseModel

@property (nonatomic, copy) NSString *AddInfoTitleName;
@property (nonatomic, copy) NSString *AddInfoSubTitleName;
@property (nonatomic, copy) NSArray *ProductAddInfoDetailList;

@property (nonatomic, copy) NSArray *productAddInfoDetailModelAr;
@property (nonatomic, assign) CGFloat cellHeight;


@end
