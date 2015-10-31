//
//  GFFoodViewController.m
//  附近
//
//  Created by wanggf on 15/8/15.
//  Copyright (c) 2015年 wanggf. All rights reserved.
//

#import "GFFoodViewController.h"
#import "GFFoodHeadView.h"
#import "common.h"
#import "DataTangAPI.h"
#import "Restaurant.h"
#import "RestaurantCell.h"
#import "AFNetworking.h"
#import "MJRefresh.h"

static const NSString *foodKey = @"a1ce3fb3b19d0c02e37d0733b8630b0a";
static  NSString *restId = @"RestaurantCell";

@interface GFFoodViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_restaurantArray;
    AFHTTPRequestOperationManager *_manager;
    int _index;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GFFoodViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    _restaurantArray = [NSMutableArray array];
    [self loadData];
    [_tableView registerNib:[UINib nibWithNibName:restId bundle:nil] forCellReuseIdentifier:@"restCell"];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark dataSource/delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _restaurantArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"restCell" forIndexPath:indexPath];
    cell.restaurant = _restaurantArray[indexPath.row];
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.headerReferenceSize = CGSizeMake(0, 0);
    GFFoodHeadView *headView = [[GFFoodHeadView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 200) collectionViewLayout:layout];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 140;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

#pragma mark loadDate

- (void)loadData{
    
    
    
    NSDictionary *dict = @{@"apitype":@"restaurant",
                           @"apicode":@"queryRestList",
                           @"distance":@"1000",
                           @"glat":@"30.314702",
                           @"glng":@"120.342804",
                           @"picsize":@(2),
                           @"curpage":@(_index + 1)
                           };
    [DataTangAPI requestData:dict
             completionBlock:^(NSDictionary *results) {
                 //NSLog(@"result:%@",results);
                 
                 NSArray *array = [results objectForKey:@"data"];
                 
                 for (NSDictionary *resInfo in array) {
                     Restaurant *resturant = [[Restaurant alloc]init];
                     resturant.restaurantName = [resInfo objectForKey:@"restaurantname"];
                     resturant.distance = [[resInfo objectForKey:@"distance"] floatValue];
                     resturant.cost = [[resInfo objectForKey:@"avgprice"] floatValue];
                     resturant.score = [[resInfo objectForKey:@"score"] floatValue];
                     resturant.restuarantKind = [resInfo objectForKey:@"cuisinename"];
                     resturant.imageAddress = [resInfo objectForKey:@"defaultpic"];
                     
                     [_restaurantArray addObject:resturant];
                     
                 }
                 //NSLog(@"%@",_restaurantArray);
                 [_tableView reloadData];
                 _index += 1;
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [_tableView.footer endRefreshing];
                 });
                 

    }];
    
    
    
    
}


@end
