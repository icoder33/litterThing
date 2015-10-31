//
//  ScenicSpotInfoModel.h
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/5.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "BaseModel.h"

//---------> e.g.

//Address = "\U6d59\U6c5f\U7701\U676d\U5dde\U5e02\U5cb3\U6e56\U666f\U533a\U5317\U5c71\U8def\U5cb3\U5e99\U5bf9\U9762\U3002 ";
//CommentCount = 2368;
//CommentGrade = "4.5";
//CommentUser = 2368;
//CountryEName = China;
//CountryID = 1;
//CountryName = "\U4e2d\U56fd";
//DistrictEName = Hangzhou;
//DistrictID = 14;
//DistrictName = "\U676d\U5dde";
//ID = 67402;
//Image = "http://dimg02.c-ctrip.com/images/tg/366/879/158/e8eded6bb5c04a788acff0126463233c_C_186_105.jpg";
//IsCanBooking = 1;
//IsOverSea = 0;
//IsReturnCash = 0;
//IsWirelessSale = 1;
//Latitude = "30.2510604858398";
//LimitSaleMsg = "<null>";
//Longitude = "120.134330749512";
//MarketPrice = 280;
//Name = "\U300a\U5370\U8c61\U897f\U6e56\U300b\U6f14\U51fa";
//OpenTimeDesc = "\U7b2c\U4e00\U573a\U6f14\U51fa\U65f6\U95f4\U4e3a\Uff1a19\Uff1a45\U201420\Uff1a45\Uff1b\U7b2c\U4e8c\U573a21\Uff1a15\U201422\Uff1a15\U3002 18\Uff1a30\U201419\Uff1a45\Uff08\U7b2c\U4e00\U573a\U6362\U7968\U65f6\U95f4\Uff09\U3002";
//OrderCount = 2454;
//PMRecommand = "\U2605\U5f20\U827a\U8c0b\U6253\U9020\Uff0c\U5c71\U6c34\U5b9e\U666f\U6f14\U51fa\Uff01";
//Price = 260;
//ProductList =[]
//ProvinceEName = Zhejiang;
//ProvinceID = 16;
//ProvinceName = "\U6d59\U6c5f";
//ReturnCashAmount = 0;
//SaleTag = "<null>";
//Score = 7;
//Star = 0;
//TicketGroupAttributes =[]
//URL = "http://piao.ctrip.com/dest/t67402.html";


//Address	string	景点地址
//CommentCount	int	点评总数（每日更新）
//CommentGrade	float	点评分（主产品/每日更新）
//CommentUser	int	点评人数（主产品/每日更新）
//CountryID	int	景点所属国家编号
//CountryName	string	景点所属国家名称
//CountryEName	string	景点所属国家英文名称
//DistrictID	int	景点所属景区编号
//DistrictName	string	景点所属景区名称
//ID	int	景点编号
//Image	Image	图片，目前取主产品第一张封面图片，若主产品无图数据，此字段也无数据
//IsReturnCash	boolean	是否返现
//IsOverSea	boolean	是否海外产品
//MarketPrice	int	市场价
//Name	string	景点名称
//OpenTimeDesc	string	营业时间
//OrderCount	int	订单总数
//Price	int	携程卖价
//ProvinceID	int	景点所属省编号
//ProvinceName	string	景点所属省名称
//ProvinceEName	string	景点所属省英文名称
//Score	decimal	景点评分（景点）
//Star	int	星级
//Latitude	decimal	所在位置纬度，范围（-90，90）
//Longitude	decimal	所在位置经度，范围（-180，180)
//URL	string	景点对应URL

//ProductDTO参数说明
//AdvanceBookingDays	int	提前预定天数
//AdvanceBookingTime	string	提前预定时间
//CanBookingFirstDate	dateTime	产品最早可订时间
//IsMaster	boolean	是否主产品

//ProductDescriptionInfoDTO参数说明
//Introduction	string	简介信息
//IsRegOrder	boolean	是否记入订单

//ProductBasicInfoDTO参数说明
//DeliveryType	DeliverType	EMS:EMS，PJS:邮寄，PST：平邮，GET：市内自取,SND：市内配送,NUL：不取不送,JOU：邮寄行程单
//ID	int	景点编号
//IsAutoProcess	string	是否自动处理
//Name	string	景点名称
//IsReturnCash	boolean	是否返现
//MarketPrice	int	市场价
//NameProvideMode	int	产品旅客姓名模式（多选） 0.无,1.仅中文,2.仅英文
//PaymentType	int	支付方式（多选）0.无支付，1.现金,2.信用卡,4.第三方支付、网银,8.抵用券,16.旅游票券,32.信用卡分期
//PayMode	string	收款方式(O-现付;P-预付)
//Price	int	携程卖价
//SaleMode	string	销售方式
//ProductTimingInfo	ProductTimingInfoDTO	产品时间信息
//WorkEndTime	string	工作截至时间

@interface ScenicSpotInfoModel : BaseModel

@property (nonatomic, copy) NSString *Address;
@property (nonatomic, assign) int CommentCount;
@property (nonatomic, assign) float CommentGrade;
@property (nonatomic, copy) NSString *CountryName;
@property (nonatomic, copy) NSString *CountryEName;
@property (nonatomic, copy) NSString *ProvinceName;
@property (nonatomic, copy) NSString *ProvinceEName;
@property (nonatomic, copy) NSString *DistrictName;
@property (nonatomic, copy) NSString *DistrictEName;
@property (nonatomic, assign) int Price;
@property (nonatomic, assign) CGFloat Score;
@property (nonatomic, assign) int Star;
@property (nonatomic, assign) CGFloat Latitude;
@property (nonatomic, assign) CGFloat Longitude;
@property (nonatomic, copy) NSString *Image;
@property (nonatomic, copy) NSString *URL;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *OpenTimeDesc;
@property (nonatomic, copy) NSString *PMRecommand;

@property (nonatomic, copy) NSArray *ProductList;




@end
