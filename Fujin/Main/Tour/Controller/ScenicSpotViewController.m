//
//  ScenicSpotsViewController.m
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/1.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "ScenicSpotViewController.h"
#import "ScenicSpotTableView.h"
#import "ScenicSpotWebDataService.h"
#import "ScenicSpotModel.h"
#import "ScenicSpotInfoViewController.h"
#import "MJRefresh.h"

@interface ScenicSpotViewController ()<ScenicSpotTableViewDelegate>

@property (nonatomic, copy) NSString *mKeyWord;
@property (nonatomic, assign) NSInteger mPage;

/**
 * 景点列表
 */
@property (nonatomic, strong) ScenicSpotTableView *tableView;

/**
 * 存储景点列表数据
 */
@property (nonatomic, strong) NSMutableArray *scenicSpotListAr;

/**
 * 存储每次获取的数据
 */
@property (nonatomic, strong) NSMutableArray *dateAr;

@end

@implementation ScenicSpotViewController

static NSString *keyWord = @"杭州";   //默认

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.mKeyWord = [keyWord copy];
        self.mPage = 1;
        self.title = @"景点和门票";
        self.view.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
}

- (void)addTableView{
    
    _tableView = [[ScenicSpotTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStyleGrouped];
    _tableView.ScenicSpotListAr = self.scenicSpotListAr;
    _tableView.myDelegate = self;
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.view addSubview:_tableView];
    
}

/**
 * 上拉加载更多数据
 */
- (void)loadMoreData{
    
    self.mPage++;
    NSDictionary *params = @{
                             @"pageindex" : @(self.mPage),
                             @"pagesize" : @20,
                             @"keyword" : _mKeyWord,
                             };
    
    [ScenicSpotWebDataService scenicSpotListWithparameter:params result:^(id result) {
        
        NSDictionary *resultDic = [result objectForKey:@"result"];
        
        NSArray *listAr = [resultDic objectForKey:@"ScenicSpotListItemList"];
        
        NSMutableArray *tAr = [NSMutableArray array];
        for (NSDictionary *scenicSpotDic in listAr) {
            
            ScenicSpotModel *model = [ScenicSpotModel modelWithDictionary:scenicSpotDic];
            
            [tAr addObject:model];
        }
        
        self.dateAr = [tAr mutableCopy];
        
        [self.scenicSpotListAr addObjectsFromArray:self.dateAr];
        self.tableView.ScenicSpotListAr = self.scenicSpotListAr;
        [self.tableView reloadData];
        
        [self.tableView.footer endRefreshing];
        
        }];
    
}

#pragma mark ScenicSpotTableViewDelegate
/**
 * 选择某行
 */
- (void)scenicSpotTableView:(ScenicSpotTableView *)tableView didSelectIndex:(NSInteger)index{
    
    ScenicSpotInfoViewController *infoVC = [[ScenicSpotInfoViewController alloc] init];
    infoVC.scenicSpotModel = self.scenicSpotListAr[index];
    
    [self.navigationController pushViewController:infoVC animated:YES];
    
 
}

/**
 * 点击搜索
 */
- (void)scenicSpotTableView:(ScenicSpotTableView *)tableView ClickSearchButtomWithText:(NSString *)searchBarText{
    self.mPage = 1; //重置查询页码
    _mKeyWord = searchBarText;  //切换关键字
    
    [self.scenicSpotListAr removeAllObjects];
    
    NSDictionary *params = @{
                             @"pageindex" : @(self.mPage),
                             @"pagesize" : @20,
                             @"keyword" : _mKeyWord,
                             };
    
    [ScenicSpotWebDataService scenicSpotListWithparameter:params result:^(id result) {
        //        NSLog(@"%@",result);
        
        NSDictionary *resultDic = [result objectForKey:@"result"];
        
        NSArray *listAr = [resultDic objectForKey:@"ScenicSpotListItemList"];
        
        NSMutableArray *tAr = [NSMutableArray array];
        for (NSDictionary *scenicSpotDic in listAr) {
            
            ScenicSpotModel *model = [ScenicSpotModel modelWithDictionary:scenicSpotDic];
            
            [tAr addObject:model];
        }
        
        self.dateAr = [tAr mutableCopy];
        
        self.scenicSpotListAr = [self.dateAr mutableCopy];
        
        
        /**
         * 刷新列表
         */
        self.tableView.ScenicSpotListAr = self.scenicSpotListAr;
        [self.tableView reloadData];
        
    }];
    
    
    
}


///----------------------------------------------------------------------------------



- (NSMutableArray *)scenicSpotListAr{
    if (!_scenicSpotListAr) {
        _scenicSpotListAr = [NSMutableArray array];
    }
    return _scenicSpotListAr;
}

- (NSMutableArray *)dateAr{
    if (!_dateAr) {
        _dateAr = [NSMutableArray array];
    }
    return _dateAr;
}

- (void)loadData{
    NSDictionary *params = @{
                             @"pageindex" : @(self.mPage),
                             @"pagesize" : @20,
                             @"keyword" : _mKeyWord,
                             };
    
    [ScenicSpotWebDataService scenicSpotListWithparameter:params result:^(id result) {
//        NSLog(@"%@",result);
        
        NSDictionary *resultDic = [result objectForKey:@"result"];
        
        NSArray *listAr = [resultDic objectForKey:@"ScenicSpotListItemList"];
        
        NSMutableArray *tAr = [NSMutableArray array];
        for (NSDictionary *scenicSpotDic in listAr) {
            
            ScenicSpotModel *model = [ScenicSpotModel modelWithDictionary:scenicSpotDic];
            
            [tAr addObject:model];
        }
        
        self.dateAr = [tAr mutableCopy];
        
        self.scenicSpotListAr = [self.dateAr mutableCopy];
        
        
        /**
         * 创建列表
         */
        [self addTableView];
        
    }];
    

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
