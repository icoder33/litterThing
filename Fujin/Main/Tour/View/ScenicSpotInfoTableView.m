//
//  ScenicSpotInfoTableView.m
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/5.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "ScenicSpotInfoTableView.h"
#import "ScenicSpotInfoTableViewCell.h"
#import "ScenicSpotProductAddInfoModel.h"

@interface ScenicSpotInfoTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ScenicSpotInfoTableView

static NSString *infoTableViewCellID = @"infoTableViewCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerNib:[UINib nibWithNibName:@"ScenicSpotInfoTableViewCell" bundle:nil] forCellReuseIdentifier:infoTableViewCellID];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.productAddInfoModelAr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ScenicSpotInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infoTableViewCellID forIndexPath:indexPath];
    ScenicSpotProductAddInfoModel *model = self.productAddInfoModelAr[indexPath.row];
    cell.productAddInfoModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScenicSpotProductAddInfoModel *model = self.productAddInfoModelAr[indexPath.row];
    return model.cellHeight;
}



















@end
