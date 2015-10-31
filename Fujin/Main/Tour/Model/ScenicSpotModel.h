//
//  ScenicSpotModel.h
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/4.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "BaseModel.h"

//----------> e.g.

//"Activity":"",
//"Address":"浙江省杭州市西湖风景名胜区。",
//"CommentGrade":4.5,
//"CommentUserCount":774,
//"CountryID":1,
//"CountryName":"中国",
//"CoverImageBaseUrl":null,
//"CoverImageId":0,
//"CoverImageUrl":null,
//"CoverSmallImageUrl":null,
//"Distance":0,
//"DistrictID":14,
//"DistrictName":"杭州",
//"ID":49894,
//"Image":"http://dimg02.c-ctrip.com/images/tg/710/501/123/db734b291e974f3e9b9ce87867fdb8d8_C_186_105.jpg",
//"IsReturnCash":false,
//"LimitSaleMsg":null,
//"MarketPrice":8,
//"Name":"西湖",
//"OrderCount":1293,
//"Price":7,
//"ProductListItemList":
//"ProductManagerRecommand":"一品天堂，一醉西湖！",
//"ProvinceID":16,
//"ProvinceName":"浙江",
//"ReturnCashAmount":0,
//"SaleTag":null,
//"Star":5,
//"TicketGroupAttributes"


//-----------> result

//status	int	返回码
//message	string	返回说明
//data	string	结果
//TabTypeSatisticsDTO	TabTypeSatisticsDTO	大Tab统计信息
//LabelSatisticsDTO	LabelSatisticsDTO	标签统计信息
//SubLabelSatisticsDTO	SubLabelSatisticsDTO	子标签统计信息
//ScenicSpotListItemDTO	ScenicSpotListItemDTO	景点列表项信息
//ProductListItemDTO	ProductListItemDTO	门票产品列表项信息
//ResourceListItemDTO	ResourceListItemDTO	门票资源列表项信息
//RowCount	int	记录数
//PagingCount	int	页码数


//-------------> scenicSpot

//ID	int	景点编号
//Name	string	景点名称
//Star	int	景点星级
//Address	string	景点地址
//DistrictID	int	景点所属景区编号
//DistrictName	string	景点所属景区名称
//ProvinceID	int	景点所属省编号
//ProvinceName	string	景点所属省名称
//CountryID	int	景点所属国家编号
//CountryName	string	景点所属国家名称
//ProductManagerRecommand	string	产品经理推荐
//CommentGrade	float	点评分数（主产品）
//CommentUserCount	int	点评人数（主产品）
//OrderCount	Int	30天内订单数

@interface ScenicSpotModel : BaseModel

@property (nonatomic, copy) NSString *Name;
@property (nonatomic, assign) int ID;
@property (nonatomic, assign) int Star;
@property (nonatomic, copy) NSString *Address;
@property (nonatomic, assign) int DistrictID;
@property (nonatomic, copy) NSString *DistrictName;
@property (nonatomic, assign) int ProvinceID;
@property (nonatomic, copy) NSString *ProvinceName;
@property (nonatomic, assign) int CountryID;
@property (nonatomic, copy) NSString *CountryName;
@property (nonatomic, assign) CGFloat CommentGrade;
@property (nonatomic, assign) int CommentUserCount;
@property (nonatomic, assign) int OrderCount;
@property (nonatomic, copy) NSString *ProductManagerRecommand;
@property (nonatomic, copy) NSString *Image;    //imageURLStr



@end
