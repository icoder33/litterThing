//
//  WeatherViewController.m
//  Weather
//
//  Created by Jorn.Wu on 15/8/28.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "WeatherViewController.h"
#import "WebDataService.h"
#import "Constant.h"
#import "DayWeatherModel.h"
#import "WeatherListTable.h"
#import "UILabel+Extension.h"
#import "NSString+EXtension.h"

@interface WeatherViewController ()<UIScrollViewDelegate>

/**
 * 定位button，查找当前位置
 */
@property (nonatomic, strong) UIButton *mPositionBtn;

/**
 * 位置列表按钮（附近，精确定位）
 */
@property (nonatomic, strong) UIButton *titleBtn;

/**
 * 天气图标
 */
@property (nonatomic, strong) UIImageView *weatherIcon;

/**
 * 背景
 */
@property (nonatomic, strong) UIImageView *bgImageView;

/**
 * 顶部视图
 */
@property (nonatomic, strong) UIView *topView;

/**
 * 天气展示视图
 */
@property (nonatomic, strong) UIScrollView *weatherView;

/**
 * pagecontrol
 */
@property (nonatomic, strong) UIPageControl *pageControl;

/**
 * 最近天气列表
 */
@property (nonatomic, strong) WeatherListTable *weatherTableView;

/**
 * 今天天气模型
 */
@property (nonatomic, strong) DayWeatherModel *toDayWeatherModel;

/**
 * 解析的数据模型数组
 */
@property (nonatomic, copy) NSArray *weatherModelAr;

/**
 * 暂存城市名
 */
@property (nonatomic, copy) NSString *cityName;



@end

@implementation WeatherViewController

#warning 城市名--------全局变量（通过定位获得）

static NSString *cityName = @"杭州";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /**
     * 加载数据
     */
    [self loadWeatherDataWithCityName:cityName];
    
}


/**
 * 加载UI界面
 */
- (void)loadUI{
    
    [self addBgImageView];
    [self addTopView];
    [self addWeatherView];
    [self addTableView];
}





///------------------------------------------------------------------------------------------------------------

#pragma mark - 网络请求

/**
 * 获取天气数据（传入参数：cityname，cityid）
 */
- (void)loadWeatherDataWithCityName:(NSString *)cityName{    //暂定 北京
    
    NSDictionary *params = @{
                             @"cityname" : cityName,
//                             @"cityid" : @"101010100"     //城市id选填
                             };
    
    [WebDataService weatherIfonWithUrl:recentWeathersUrl parameter:[params copy] result:^(id result) {
        
        NSDictionary *retDate = [result objectForKey:@"retData"];
        
        //城市名
        self.cityName = [retDate objectForKey:@"city"];
        
        //今天
        NSDictionary *today = [retDate objectForKey:@"today"];
        self.toDayWeatherModel = [DayWeatherModel weatherModelWithDictionary:today];
        

        //之后4天（未来）
        NSArray *forecast = [retDate objectForKey:@"forecast"];
        NSMutableArray *forecastModelAr = [NSMutableArray array];
        for (NSDictionary *day in forecast) {
            DayWeatherModel *model = [DayWeatherModel weatherModelWithDictionary:day];
            [forecastModelAr addObject:model];
        }
        
        //之前7天（历史）
        NSArray *history = [retDate objectForKey:@"history"];
        NSMutableArray *historyModelAr = [NSMutableArray array];
        for (NSDictionary *day in history) {
            DayWeatherModel *model = [DayWeatherModel weatherModelWithDictionary:day];
            [historyModelAr addObject:model];
        }
        
        
        /**
         * 合并数组
         */
        NSMutableArray *tempAr = [NSMutableArray array];
        
        [tempAr addObjectsFromArray:historyModelAr];
        [tempAr addObject:self.toDayWeatherModel];
        [tempAr addObjectsFromArray:forecastModelAr];
        
        self.weatherModelAr = tempAr;
        
        
        /**
         * 加载UI界面，放在这是确保，block执行完后在加载，否则数据为空，产生错误
         */
        [self loadUI];
   
    }];
    
}


/**
 * 懒加载数据
 */
- (NSArray *)weatherModelAr{
    
    if (!_weatherModelAr) {
        
        _weatherModelAr = [NSArray array];
    }
    
    return _weatherModelAr;
  
}







///------------------------------------------------------------------------------------------------------------

#pragma mark - bgView

/**
 * 背景图片视图
 */
- (void)addBgImageView{
    
#warning ---> 图片暂定
    _bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _bgImageView.image = [UIImage imageNamed:@"weather_bg_cloudy.jpg"];
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;

    
    [self.view addSubview:_bgImageView];
    
}


///------------------------------------------------------------------------------------------------------------

#pragma mark - topView

/**
 * 顶部视图
 */
- (void)addTopView{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.2;
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
    _topView.backgroundColor = [UIColor clearColor];
    
    _mPositionBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 20 - 250) / 2.0, 0, 20, 30)];
    _mPositionBtn.center = CGPointMake((kScreenWidth - 20 - 250) / 2.0 - 10, CGRectGetHeight(_topView.frame) / 2.0);
    [_mPositionBtn setImage:[UIImage imageNamed:@"myPosition"] forState:UIControlStateNormal];
    [_mPositionBtn addTarget:self action:@selector(lookMyPosition) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_mPositionBtn.frame), _mPositionBtn.frame.origin.y, 250, 30)];
    _titleBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [_titleBtn setTitle:@"浙江省/杭州市/下沙" forState:UIControlStateNormal];
    
    
    
    [_topView addSubview:_mPositionBtn];
    [_topView addSubview:_titleBtn];
    
    [self.view addSubview:bgView];
    [self.view addSubview:_topView];
    
}


/**
 *  定位
 */
- (void)lookMyPosition{
    
//    ...................
    
}






///------------------------------------------------------------------------------------------------------------

#pragma mark - weatherView

/**
 * 今天天气显示视图
 */
- (void)addWeatherView{
    
    _weatherView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 220)];
    _weatherView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    _weatherView.pagingEnabled = YES;
    _weatherView.showsHorizontalScrollIndicator = NO;
    _weatherView.delegate = self;
    
    NSString *placeholderString = @"-未知-";
    
///------------------------------------------------第一页---------------------------------------------///
    /**
     * 第一页（天气展示页）
     */
    
    /**
     * 城市名
     */
    UILabel *district = [UILabel lableWithFrame:CGRectMake(50, 20, 100, 50)
                                           text:[NSString stringWithString:self.cityName placeholderString:placeholderString]
                                      textColor:[UIColor blackColor]
                                           font:[UIFont systemFontOfSize:30]];//如果为空，设为“未知”
    
    
    /**
     * 日期
     */
    NSString *date = [NSString stringWithString:self.toDayWeatherModel.date placeholderString:placeholderString];
    NSString *week = [NSString stringWithString:self.toDayWeatherModel.week placeholderString:placeholderString];
    UILabel *dateLb = [UILabel lableWithFrame:CGRectMake(10, CGRectGetMaxY(district.frame) + 20, 200, 30)
                                         text:[NSString stringWithFormat:@"%@  %@",week,date]
                                    textColor:[UIColor blackColor]
                                         font:[UIFont systemFontOfSize:20]];
    
    
    /**
     * 温度
     */
    NSString *subString = [self.toDayWeatherModel.curTemp substringToIndex:2];       //去掉单位
    UILabel *temperatureLb = [UILabel lableWithFrame:CGRectMake(50, CGRectGetMaxY(dateLb.frame) + 10, 75, 75)
                                                text:[NSString stringWithString:subString placeholderString:placeholderString]
                                           textColor:[UIColor blackColor]
                                                font:[UIFont systemFontOfSize:65]];
    
    /**
     * 单位
     */
    UILabel *unitLb = [UILabel lableWithFrame:CGRectMake(CGRectGetMaxX(temperatureLb.frame), temperatureLb.frame.origin.y, 40, 40)
                                         text:@"℃"
                                    textColor:[UIColor blackColor]
                                         font:[UIFont systemFontOfSize:30]];
    
    /**
     * 天气
     */
    
//    图标样式
//    _weatherIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxY(unitLb.frame) + 10, CGRectGetMaxY(_district.frame), 100, 100)];
//    _weatherIcon.image = [UIImage imageNamed:@"cloudy"];
    
//    文字样式
    UILabel *weatherTitleLb = [UILabel lableWithFrame:CGRectMake(CGRectGetMaxY(unitLb.frame) + 20, CGRectGetMaxY(district.frame), 150, 100)
                                                 text:[NSString stringWithString:self.toDayWeatherModel.type
                                                               placeholderString:placeholderString]
                                            textColor:[UIColor cyanColor]
                                                 font:[UIFont systemFontOfSize:30]];
    weatherTitleLb.textAlignment = NSTextAlignmentCenter;
    
    
    /**
     * 第一页（平铺导航）
     */
    UIView *viewOne = [[UIView alloc] initWithFrame:_weatherView.bounds];
    
    [viewOne addSubview:district];
    [viewOne addSubview:dateLb];
    [viewOne addSubview:temperatureLb];
    [viewOne addSubview:unitLb];
    [viewOne addSubview:_weatherIcon];
    [viewOne addSubview:weatherTitleLb];
    
    [_weatherView addSubview:viewOne];
    
///---------------------------------------------第二页------------------------------------------------///
    
    /**
     * 第二页(文字信息页)
     */
    
    UIView *viewTwo = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth,
                                                               viewOne.frame.origin.y,
                                                               kScreenWidth,
                                                               CGRectGetHeight(_weatherView.frame))];
    [_weatherView addSubview:viewTwo];
    
    /**
     * 请求数据
     */
    [WebDataService weatherIfonWithCityName:cityName result:^(id result) {
        
        NSDictionary *retData = [result objectForKey:@"retData"];
        
        CGFloat width = 150;
        CGFloat height = 30;
        CGFloat xSpacing = (kScreenWidth - width * 2) / 2.0;     //x间隙
        CGFloat ySpacing = 10;     //y间隙
        
        /**
         * 风向
         */
        UILabel *fengxiangLb = [UILabel lableWithFrame:CGRectMake(xSpacing, ySpacing, width, height)
                                                  text:[NSString stringWithFormat:@"风向：%@",[retData objectForKey:@"WD"]]
                                             textColor:[UIColor cyanColor]
                                                  font:[UIFont boldSystemFontOfSize:15]];
        
        /**
         * 风级
         */
        UILabel *fengjiLb = [UILabel lableWithFrame:CGRectMake(xSpacing, CGRectGetMaxY(fengxiangLb.frame) + ySpacing, width, height)
                                               text:[NSString stringWithFormat:@"风速：%@",[retData objectForKey:@"WS"]]
                                          textColor:[UIColor cyanColor]
                                               font:[UIFont boldSystemFontOfSize:15]];
        
        /**
         * 最高温
         */
        UILabel *hightTempLb = [UILabel lableWithFrame:CGRectMake(xSpacing, CGRectGetMaxY(fengjiLb.frame) + ySpacing, width, height)
                                                  text:[NSString stringWithFormat:@"最高温：%@",self.toDayWeatherModel.hightemp]
                                             textColor:[UIColor cyanColor]
                                                  font:[UIFont boldSystemFontOfSize:15]];
        /**
         * 最低温
         */
        UILabel *lowTempLb = [UILabel lableWithFrame:CGRectMake(xSpacing, CGRectGetMaxY(hightTempLb.frame) + ySpacing, width, height)
                                                text:[NSString stringWithFormat:@"最低温：%@",self.toDayWeatherModel.lowtemp]
                                           textColor:[UIColor cyanColor]
                                                font:[UIFont boldSystemFontOfSize:15]];
        
        /**
         * 经度
         */
        UILabel *longitudeLb = [UILabel lableWithFrame:CGRectMake(CGRectGetMaxX(fengxiangLb.frame) + xSpacing,
                                                                  ySpacing,
                                                                  width, height)
                                                  text:[NSString stringWithFormat:@"经度：%@",[retData objectForKey:@"longitude"]]
                                             textColor:[UIColor cyanColor]
                                                  font:[UIFont boldSystemFontOfSize:15]];
        
        /**
         * 纬度
         */
        UILabel *latitudeLb = [UILabel lableWithFrame:CGRectMake(CGRectGetMaxX(fengxiangLb.frame) + xSpacing,
                                                                 CGRectGetMaxY(longitudeLb.frame) + ySpacing,
                                                                 width, height)
                                                 text:[NSString stringWithFormat:@"纬度：%@",[retData objectForKey:@"latitude"]]
                                            textColor:[UIColor cyanColor]
                                                 font:[UIFont boldSystemFontOfSize:15]];
        
        /**
         * 海拔
         */
        UILabel *altitudeLb = [UILabel lableWithFrame:CGRectMake(CGRectGetMaxX(fengxiangLb.frame) + xSpacing,
                                                                 CGRectGetMaxY(latitudeLb.frame) + ySpacing,
                                                                 width, height)
                                                 text:[NSString stringWithFormat:@"海拔：%@",[retData objectForKey:@"altitude"]]
                                            textColor:[UIColor cyanColor]
                                                 font:[UIFont boldSystemFontOfSize:15]];
        
        /**
         * 日升时间
         */
        UILabel *sunriseLb = [UILabel lableWithFrame:CGRectMake(CGRectGetMaxX(fengxiangLb.frame) + xSpacing,
                                                                CGRectGetMaxY(altitudeLb.frame) + ySpacing,
                                                                width, height)
                                                text:[NSString stringWithFormat:@"日升时间：%@",[retData objectForKey:@"sunrise"]]
                                           textColor:[UIColor cyanColor]
                                                font:[UIFont boldSystemFontOfSize:15]];
        
        /**
         * 日落时间
         */
        UILabel *sunsetLb = [UILabel lableWithFrame:CGRectMake(CGRectGetMaxX(fengxiangLb.frame) + xSpacing,
                                                               CGRectGetMaxY(sunriseLb.frame) + ySpacing,
                                                               width, height)
                                               text:[NSString stringWithFormat:@"日落时间：%@",[retData objectForKey:@"sunset"]]
                                          textColor:[UIColor cyanColor]
                                               font:[UIFont boldSystemFontOfSize:15]];
        
        [viewTwo addSubview:fengxiangLb];
        [viewTwo addSubview:fengjiLb];
        [viewTwo addSubview:hightTempLb];
        [viewTwo addSubview:lowTempLb];
        
        [viewTwo addSubview:longitudeLb];
        [viewTwo addSubview:latitudeLb];
        [viewTwo addSubview:altitudeLb];
        [viewTwo addSubview:sunriseLb];
        [viewTwo addSubview:sunsetLb];
        
    }];
    
///-------------------------------------------第三页--------------------------------------------------///
    
    /**
     * 第三页（友情提示页）
     */
    UIView *viewThree = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth * 2, viewOne.frame.origin.y, kScreenWidth, 220)];
    
    UILabel *notiOneLb = nil;
    UILabel *notiTwoLb = nil;
    UILabel *notiThreeLb = nil;
    
    //解析提示信息
    NSArray *index = self.toDayWeatherModel.index;
    
    for (NSDictionary *dic in index) {
        
        if ([dic[@"code"] isEqualToString:@"fs"]) {
            notiOneLb = [UILabel lableWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 70)
                                           text:[NSString stringWithString:[NSString stringWithFormat:@"防晒指数：%@",[dic valueForKey:@"details"]] placeholderString:placeholderString]
                                      textColor:[UIColor cyanColor]
                                           font:[UIFont systemFontOfSize:17]];
            notiOneLb.numberOfLines = 0;
        }
        if ([dic[@"code"] isEqualToString:@"ct"]) {
            notiTwoLb = [UILabel lableWithFrame:CGRectMake(10, CGRectGetMaxY(notiOneLb.frame), kScreenWidth - 20, 70)
                                           text:[NSString stringWithString:[NSString stringWithFormat:@"穿衣指数：%@",[dic valueForKey:@"details"]] placeholderString:placeholderString]
                                      textColor:[UIColor cyanColor]
                                           font:[UIFont systemFontOfSize:17]];
            notiTwoLb.numberOfLines = 0;
        }
        if ([dic[@"code"] isEqualToString:@"ct"]) {
            notiThreeLb = [UILabel lableWithFrame:CGRectMake(10, CGRectGetMaxY(notiTwoLb.frame), kScreenWidth - 20, 70)
                                             text:[NSString stringWithString:[NSString stringWithFormat:@"洗车指数：%@",[dic valueForKey:@"details"]] placeholderString:placeholderString]
                                        textColor:[UIColor cyanColor]
                                             font:[UIFont systemFontOfSize:17]];
            notiThreeLb.numberOfLines = 0;
        }
        
    }
    
    [viewThree addSubview:notiOneLb];
    [viewThree addSubview:notiTwoLb];
    [viewThree addSubview:notiThreeLb];
    
    [_weatherView addSubview:viewThree];
    
    
    /**
     * pagecontrol
     */
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    CGSize size = [_pageControl sizeForNumberOfPages:3];
    _pageControl.frame = CGRectMake(0, 0, size.width, size.height);
    _pageControl.center = CGPointMake((kScreenWidth - CGRectGetWidth(_pageControl.frame)) / 2.0, CGRectGetMaxY(_weatherView.frame) + size.height / 2.0);
    
    [self.view addSubview:_pageControl];
    
    [self.view addSubview:_weatherView];
}


/**
 * 代理方法
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
#warning ----> 不太灵敏，待优化
    CGFloat index = (scrollView.contentOffset.x * 1.0 + 0.5)/ kScreenWidth;
    [_pageControl setCurrentPage:index];
    
    
}




///------------------------------------------------------------------------------------------------------------

#pragma mark - 最近天气列表

- (void)addTableView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageControl.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(self.weatherView.frame))];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.1;
    
    _weatherTableView = [[WeatherListTable alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageControl.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(self.pageControl.frame))];
    _weatherTableView.weatherModelAr = self.weatherModelAr;     //把数据传过去
    
    [self.view addSubview:bgView];
    [self.view addSubview:_weatherTableView];
    
}






///------------------------------------------------------------------------------------------------------------



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
