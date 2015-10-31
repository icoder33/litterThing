//
//  ScenicSpotProductAddInfoModel.m
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/5.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "ScenicSpotProductAddInfoModel.h"
#import "WXLabel.h"

@implementation ScenicSpotProductAddInfoModel

- (NSArray *)productAddInfoDetailModelAr{
    
    if (!_productAddInfoDetailModelAr) {
        _productAddInfoDetailModelAr = [NSArray array];
        
        NSMutableArray *tArray = [NSMutableArray array];
        
        NSArray *productAddInfoDetailList = self.ProductAddInfoDetailList;
        
        for (NSDictionary *productAddInfoDetailDic in productAddInfoDetailList) {
            
            ScenicSpotProductAddInfoDetailModel *model = [ScenicSpotProductAddInfoDetailModel modelWithDictionary:productAddInfoDetailDic];
            [tArray addObject:model];
        }
        
        _productAddInfoDetailModelAr = [tArray copy];
  
    }
    return _productAddInfoDetailModelAr;
}

- (CGFloat)cellHeight{
    
    CGFloat height = 30 + 5;    //name的高度 + 底部预留间距
    if (self.productAddInfoDetailModelAr.count == 0) {
        CGFloat subHeight = [WXLabel getTextHeight:13 width:kScreenWidth text:@"无" linespace:5];
        height += (subHeight + 10); //加间距
    }else {
        for (ScenicSpotProductAddInfoDetailModel *model in self.productAddInfoDetailModelAr) {
            CGFloat subHeight = [WXLabel getTextHeight:13 width:kScreenWidth text:model.DescDetail linespace:5];
            height += (subHeight + 10); //加间距
        }
    }

    return height;
}


@end
