//
//  ScenicSpotInfoViewController.m
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/4.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "ScenicSpotInfoViewController.h"
#import "ScenicSpotWebDataService.h"
#import "ScenicSpotModel.h"
#import "ScenicSpotInfoTableView.h"
#import "UILabel+Extension.h"
#import "ScenicSpotInfoModel.h"
#import "ScenicSpotProductAddInfoModel.h"
#import "XMLTool.h"
#import "NSString+EXtension.h"
#import "UIImageView+WebCache.h"

@interface ScenicSpotInfoViewController ()

@property (nonatomic, strong) ScenicSpotInfoTableView *tableView;
@property (nonatomic, strong) UIScrollView *topScrollView;      //info
@property (nonatomic, strong) ScenicSpotInfoModel *infoModel;
@property (nonatomic, copy) NSArray *productAddInfoModelAr;

@end

@implementation ScenicSpotInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self loadDate];
}

- (NSArray *)productAddInfoModelAr{
    if (!_productAddInfoModelAr) {
        _productAddInfoModelAr = [NSArray array];
    }
    return _productAddInfoModelAr;
}

- (void)loadDate{
    NSDictionary *params = @{
                             @"scenicspotid" : @(self.scenicSpotModel.ID),
                             };
    [ScenicSpotWebDataService scenicSpotInfoWithparameter:params result:^(id result) {
        
        NSDictionary *resultDic = [result objectForKey:@"result"];
        
        NSArray *scenicSpotList = [resultDic objectForKey:@"ScenicSpotList"];
        
        NSDictionary *scenicSpotDic = scenicSpotList[0];        //只有一个
        _infoModel = [ScenicSpotInfoModel modelWithDictionary:scenicSpotDic];
        
        NSArray *productList = _infoModel.ProductList;
        NSDictionary *productDic = productList[0];      //只有一个
        
        NSArray *ProductAddInfoList = [productDic objectForKey:@"ProductAddInfoList"];
        NSMutableArray *tArray = [NSMutableArray array];
        for (NSDictionary *productAddInfoDic in ProductAddInfoList) {
            
            ScenicSpotProductAddInfoModel *productAddInfoModel = [ScenicSpotProductAddInfoModel modelWithDictionary:productAddInfoDic];
            [tArray addObject:productAddInfoModel];
            
        }
        self.productAddInfoModelAr = [tArray copy];
        
        
        /**
         * 创建列表
         */
        [self addTableView];
        
        
    }];
}

- (UIView *)createTopView{
    
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    _topScrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    _topScrollView.pagingEnabled = YES;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    
//first（信息简介）
    
    UIView *fView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    fView.backgroundColor = [UIColor redColor];
    
    NSArray *productList = _infoModel.ProductList;
    NSDictionary *productDic = productList[0];      //只有一个
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 10, 100)];
    NSURL *imageURL = [NSURL URLWithString:_infoModel.Image];
    [topImageView sd_setImageWithURL:imageURL];
    
#warning -------解析未完成
    /**
     * 解析XML
     */
    NSLog(@"%@",[[[XMLTool alloc] init] stringWithXMLStringData:[[productDic[@"ProductDescriptionInfo"] valueForKey:@"Introduction"] dataUsingEncoding:NSUTF8StringEncoding] placeholderString:@"-未知-"]);
    
    UILabel *titleLb = [UILabel lableWithFrame:CGRectMake(5, CGRectGetMaxY(topImageView.frame), kScreenWidth - 10, 30)
                                          text:@"景点简介："
                                     textColor:[UIColor blackColor]
                                          font:[UIFont systemFontOfSize:15]];

    UITextView *introductionTV = [[UITextView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(titleLb.frame), kScreenWidth - 10, _topScrollView.frame.size.height - 30 - 100 - 5 - 5)];
    introductionTV.text = [NSString stringWithFormat:@"%@",[productDic[@"ProductDescriptionInfo"] valueForKey:@"Introduction"]];
    introductionTV.editable = NO;
    introductionTV.font = [UIFont systemFontOfSize:15];
    introductionTV.backgroundColor = [UIColor clearColor];
    introductionTV.layer.borderColor = [UIColor whiteColor].CGColor;
    introductionTV.layer.borderWidth = 1.0;
    introductionTV.layer.cornerRadius = 5;
    
    [fView addSubview:topImageView];
    [fView addSubview:titleLb];
    [fView addSubview:introductionTV];
    
    
    
    
//second（景点信息）
    
    UIView *sView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, 250)];
    sView.backgroundColor = [UIColor greenColor];
    
    UILabel *nameLb = [UILabel lableWithFrame:CGRectMake(0, 0, kScreenWidth, 30)
                                         text:_infoModel.Name
                                    textColor:[UIColor blackColor]
                                         font:[UIFont systemFontOfSize:15]];
    nameLb.textAlignment = NSTextAlignmentCenter;
    
    UILabel *PMRecommandLb = [ UILabel lableWithFrame:CGRectMake(0, CGRectGetMaxY(nameLb.frame), kScreenWidth, 30)
                                                 text:_infoModel.PMRecommand
                                            textColor:[UIColor blackColor]
                                                 font:[UIFont systemFontOfSize:15]];
    PMRecommandLb.textAlignment = NSTextAlignmentCenter;
    
    CGFloat spacing = 10;
    CGFloat width = (kScreenWidth - spacing * 5) / 4.0;
    
    UILabel *CommentCountLb = [ UILabel lableWithFrame:CGRectMake(spacing, CGRectGetMaxY(PMRecommandLb.frame), width, 30)
                                                 text:[NSString stringWithFormat:@"评论数:%d",_infoModel.CommentCount]
                                            textColor:[UIColor blackColor]
                                                 font:[UIFont systemFontOfSize:13]];
    UILabel *CommentGradeLb = [ UILabel lableWithFrame:CGRectMake(CGRectGetMaxX(CommentCountLb.frame) + spacing, CGRectGetMaxY(PMRecommandLb.frame), width, 30)
                                                 text:[NSString stringWithFormat:@"平均分:%.f",_infoModel.CommentGrade]
                                            textColor:[UIColor blackColor]
                                                 font:[UIFont systemFontOfSize:13]];
    UILabel *LongitudeLb = [ UILabel lableWithFrame:CGRectMake(CGRectGetMaxX(CommentGradeLb.frame) + spacing, CGRectGetMaxY(PMRecommandLb.frame), width, 30)
                                                 text:[NSString stringWithFormat:@"经度:%.2f",_infoModel.Longitude]
                                            textColor:[UIColor blackColor]
                                                 font:[UIFont systemFontOfSize:13]];
    UILabel *LatitudeLb = [ UILabel lableWithFrame:CGRectMake(CGRectGetMaxX(LongitudeLb.frame) + spacing, CGRectGetMaxY(PMRecommandLb.frame), width, 30)
                                                 text:[NSString stringWithFormat:@"纬度:%.2f",_infoModel.Latitude]
                                            textColor:[UIColor blackColor]
                                                 font:[UIFont systemFontOfSize:13]];
    UILabel *StarLb = [ UILabel lableWithFrame:CGRectMake(spacing, CGRectGetMaxY(CommentCountLb.frame), width, 30)
                                                 text:[NSString stringWithString:[NSString stringWithFormat:@"星级:%d星",_infoModel.Star] placeholderString:@"星级:无"]
                                            textColor:[UIColor blackColor]
                                                 font:[UIFont systemFontOfSize:13]];
    UILabel *PriseLb = [ UILabel lableWithFrame:CGRectMake(CGRectGetMaxX(StarLb.frame) + spacing, CGRectGetMaxY(CommentCountLb.frame), width, 30)
                                                 text:[NSString stringWithString:[NSString stringWithFormat:@"携程价:%d元",_infoModel.Price] placeholderString:@"携程价:无"]
                                            textColor:[UIColor blackColor]
                                                 font:[UIFont systemFontOfSize:13]];
    
    UITextView *OpenTimeTV = [[UITextView alloc] initWithFrame:CGRectMake(2.5, CGRectGetMaxY(PriseLb.frame), kScreenWidth - 5, 60)];
    OpenTimeTV.text = _infoModel.OpenTimeDesc;
    OpenTimeTV.editable = NO;
    OpenTimeTV.font = [UIFont systemFontOfSize:13];
    OpenTimeTV.backgroundColor = [UIColor clearColor];
    OpenTimeTV.layer.borderColor = [UIColor whiteColor].CGColor;
    OpenTimeTV.layer.borderWidth = 1.0;
    OpenTimeTV.layer.cornerRadius = 5;

    UILabel *ownerLb = [ UILabel lableWithFrame:CGRectMake(0, CGRectGetMaxY(OpenTimeTV.frame), kScreenWidth, 30)
                                              text:[NSString stringWithFormat:@"所属:%@(%@)-%@(%@)-%@(%@)",
                                                    _infoModel.CountryName,_infoModel.CountryEName,
                                                    _infoModel.ProvinceName,_infoModel.ProvinceEName,
                                                    _infoModel.DistrictName,_infoModel.DistrictEName]
                                         textColor:[UIColor blackColor]
                                              font:[UIFont systemFontOfSize:13]];
    UILabel *URLLb = [ UILabel lableWithFrame:CGRectMake(0, CGRectGetMaxY(ownerLb.frame), kScreenWidth, 30)
                                              text:[NSString stringWithFormat:@"详情请进:%@",_infoModel.URL]
                                         textColor:[UIColor blackColor]
                                              font:[UIFont systemFontOfSize:13]];
    
    
    
    [sView addSubview:nameLb];
    [sView addSubview:PMRecommandLb];
    [sView addSubview:CommentCountLb];
    [sView addSubview:CommentGradeLb];
    [sView addSubview:LongitudeLb];
    [sView addSubview:LatitudeLb];
    [sView addSubview:StarLb];
    [sView addSubview:PriseLb];
    [sView addSubview:OpenTimeTV];
    [sView addSubview:ownerLb];
    [sView addSubview:URLLb];

    
    [_topScrollView addSubview:fView];
    [_topScrollView addSubview:sView];
    

    return _topScrollView;
 
}

/**
 * 添加列表
 */
- (void)addTableView{
    
    self.tableView = [[ScenicSpotInfoTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    self.tableView.tableHeaderView = [self createTopView];
    self.tableView.productAddInfoModelAr = self.productAddInfoModelAr;
    [self.view addSubview:self.tableView];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
