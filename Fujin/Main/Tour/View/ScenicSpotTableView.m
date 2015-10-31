//
//  ScenicSpotsTableView.m
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/4.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "ScenicSpotTableView.h"
#import "ScenicSpotTableViewCell.h"
#import "ScenicSpotTableViewCell.h"
#import "MJRefresh.h"
#import "ScenicSpotWebDataService.h"
#import "ScenicSpotModel.h"

@interface ScenicSpotTableView ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

/**
 * 用于搜索的关键字
 */
@property (nonatomic, copy) NSString *mKeyword;

/**
 * 顶部标签容器视图
 */
@property (nonatomic, strong) UIView *topView;

/**
 * 热门景点名数组
 */
@property (nonatomic, copy) NSArray *hotSpotNameAr;

/**
 * 热门景点标签视图
 */
@property (nonatomic, strong) UIView *hotSpotView;

@end

@implementation ScenicSpotTableView

/**
 * 根据地位获得
 */
static NSString *keyword = @"杭州";

static NSString *cellId = @"scenicSpotCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.mKeyword = keyword;    //暂未全局变量
        self.backgroundColor = [UIColor clearColor];
        
        
        self.tableHeaderView = [self addTopView];
        
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        [self registerNib:[UINib nibWithNibName:@"ScenicSpotTableViewCell" bundle:nil] forCellReuseIdentifier:cellId];
        
        
    }
    return self;
}

- (UIView *)addTopView{
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索想去的景点";
    searchBar.showsSearchResultsButton = YES;
    searchBar.showsScopeBar = YES;
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    _topView.backgroundColor = [UIColor clearColor];
    
    UILabel *myPositionLb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBar.frame), kScreenWidth, 20)];
#warning ------------定位获得的位置（暂设）
    myPositionLb.text = @"您当前的位置：浙江省杭州市江干区下沙高教园区";
    myPositionLb.font = [UIFont boldSystemFontOfSize:15];
    [_topView addSubview:myPositionLb];
    
    UILabel *markLb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myPositionLb.frame), kScreenWidth, 20)];
    markLb.text = @"热门景点：";
    markLb.font = [UIFont systemFontOfSize:15];
    [_topView addSubview:markLb];
    
    [_topView addSubview:searchBar];
 
    return _topView;
}

#pragma mark - UISearchBarDelegate

/**
 * 点击搜索
 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if ([self.myDelegate respondsToSelector:@selector(scenicSpotTableView:ClickSearchButtomWithText:)]) {
        
        self.mKeyword = searchBar.text;

        [self.myDelegate scenicSpotTableView:self ClickSearchButtomWithText:searchBar.text];
    }
    
    
}


#pragma mark - UITableViewDataSource/UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.ScenicSpotListAr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ScenicSpotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    ScenicSpotModel *model = self.ScenicSpotListAr[indexPath.section];
    cell.scenicSpotModel = model;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 5;
    }

    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.myDelegate respondsToSelector:@selector(scenicSpotTableView:didSelectIndex:)]) {
        [self.myDelegate scenicSpotTableView:self didSelectIndex:indexPath.section];    //以节为单位
    }
}












/**
 * 创建热门景点标签视图
 */
- (void)addHotSpotViewWith:(NSArray *)hotSpotNameAr{
    
    _hotSpotView = [[UIView alloc] initWithFrame:CGRectMake(2.5, 30 + 20 + 20, kScreenWidth - 5, 120 - 40)];
    _hotSpotView.backgroundColor = [UIColor clearColor];
    _hotSpotView.layer.borderColor = [UIColor blackColor].CGColor;
    _hotSpotView.layer.borderWidth = 1.0;
    _hotSpotView.layer.cornerRadius = 5.f;
    
    /**
     * 热门景点标签
     */
    int col = 3;
    NSInteger num = hotSpotNameAr.count;
    CGFloat xSpacing = 10;
    CGFloat ySpacing = 5;
    CGFloat w = (kScreenWidth - 5 - xSpacing * (col + 1)) / col;
    CGFloat h = (CGRectGetHeight(_hotSpotView.frame) - ySpacing * (9 / col + 1))/ (9 / col);
    for (int i = 0; i < num; i++) {
        int c = i % col;
        int r = i / col;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(xSpacing + (xSpacing + w) * c, ySpacing + (ySpacing + h) * r, w, h)];
        btn.backgroundColor = [UIColor grayColor];
        btn.tag = i + 100;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setTitle:hotSpotNameAr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:9];
        [_hotSpotView addSubview:btn];
    }
    
    
    [_topView addSubview:_hotSpotView];
}


/**
 * 标签按钮的响应方法
 */
- (void)btnAction:(UIButton *)btn{

    if ([self.myDelegate respondsToSelector:@selector(scenicSpotTableView:ClickSearchButtomWithText:)]) {
        [self.myDelegate scenicSpotTableView:self ClickSearchButtomWithText:btn.titleLabel.text];
    }
}


/**
 * 当切换关键字时调用
 */
- (void)setMKeyword:(NSString *)mKeyword{

    _mKeyword = mKeyword;
    [self loadHotSpotData];
    
}

/**
 * 查询热门景点数据
 */
- (void)loadHotSpotData{    //只查询前100个
    NSDictionary *params = @{
                             @"pageindex" : @1,
                             @"pagesize" : @100,
                             @"keyword" : _mKeyword,
                             };
    
    [ScenicSpotWebDataService scenicSpotListWithparameter:params result:^(id result) {
        
        NSDictionary *resultDic = [result objectForKey:@"result"];
        
        NSArray *listAr = [resultDic objectForKey:@"ScenicSpotListItemList"];
        
        NSMutableArray *tAr = [NSMutableArray array];
        for (NSDictionary *scenicSpotDic in listAr) {
            
            ScenicSpotModel *model = [ScenicSpotModel modelWithDictionary:scenicSpotDic];
            
            if (tAr.count < 9) {   //最多为9个
                
                if (model.Star >= 4) {//等于五星
                    NSString *nameStr = model.Name;
                    [tAr addObject:nameStr];
                }
                
            }
            
        }
        
        self.hotSpotNameAr = [tAr copy];
        
        
        
        if (self.hotSpotView) {     //已经创建，先移除在创建
            [self.hotSpotView removeFromSuperview];
        }
        /**
         * 创建标签视图
         */
        [self addHotSpotViewWith:self.hotSpotNameAr];

    }];


}


@end
