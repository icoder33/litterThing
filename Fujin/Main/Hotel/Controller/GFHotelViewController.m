//
//  GFHotelViewController.m
//  Fujin
//
//  Created by wanggf on 15/8/20.
//  Copyright (c) 2015年 wanggf. All rights reserved.
//

#import "GFHotelViewController.h"
#import "AFNetworking.h"
#import "Hotel.h"
#import "DataService.h"
#import "JSONKit.h"
#import "Hotel.h"
#import "HotelCell.h"
#import "MJRefresh.h"


#define hotelAppKey @"997ccad2f6e37d443c0aabaebfd1ac13"

static NSString * const cellId = @"hotelCell";

@interface GFHotelViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray *_hotelArray;
    int _index;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GFHotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _hotelArray = [NSMutableArray array];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
   
    UINib *nib = [UINib nibWithNibName:@"HotelCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:cellId];
    [self loadDate];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadDate];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _hotelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.hotel = _hotelArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[[NSBundle mainBundle] loadNibNamed:@"HotelHeader" owner:self options:nil]lastObject];
    return headView;
}


- (void)loadDate{
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = @"http://api2.juheapi.com/xiecheng/hotel/search";
    
//    Page 	obj 	否 	分页条件, 字段如下:
//    Page->Skip 	int 	否 	开始结果下标, 范围: [0, 1000], 默认值: 0
//    Page->Limit
    
    NSDictionary *param = @{@"Key" : hotelAppKey,

                            @"Geo":@{
                                    @"Lat":@30.314702,
                                    @"Lng":@120.342804,
                                    @"Distance":@50000.0

                                    },
                            
                            @"Page":@{
                                    @"Skip":@(_index),
                                    @"Limit":@10
                                    }
                          
                            };


    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    [manger POST:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *result = [responseObject objectForKey:@"result"];
        NSArray *list = [result objectForKey:@"list"];
        //NSLog(@"%@",list);
        for (NSDictionary *hotels in list) {
            Hotel *hotel = [[Hotel alloc]init];
            hotel.hotelName = hotels[@"HotelName"];
            hotel.hotelAddress = hotels[@"AddressLine"];
            hotel.rating = [[hotels[@"Award"] firstObject] objectForKey:@"Rating"];
            hotel.score = [[hotels[@"Award"] lastObject] objectForKey:@"Rating"];
            [_hotelArray addObject:hotel];
           

            //NSLog(@"%lu",_hotelArray.count);
            
        }
         [_tableView reloadData];
        _index += 1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.footer endRefreshing];
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    
   }

@end
