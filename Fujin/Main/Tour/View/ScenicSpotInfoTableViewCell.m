//
//  ScenicSpotInfoTableViewCell.m
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/5.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "ScenicSpotInfoTableViewCell.h"
#import "ScenicSpotProductAddInfoModel.h"
#import "ScenicSpotProductAddInfoDetailModel.h"
#import "UILabel+Extension.h"
#import "WXLabel.h"



@implementation ScenicSpotInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
}


- (void)setProductAddInfoModel:(ScenicSpotProductAddInfoModel *)productAddInfoModel{
    if (_productAddInfoModel != productAddInfoModel) {
        _productAddInfoModel = productAddInfoModel;
        self.titleName.text = _productAddInfoModel.AddInfoSubTitleName;
        
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];

    NSArray *productAddInfoDetailAr = _productAddInfoModel.productAddInfoDetailModelAr;
    
    if (productAddInfoDetailAr.count == 0) {
        //没有内容
        
        [self productAddInfoDetailViewWithProductAddInfoDetailModel:nil index:0];
        
    }else {
        for (int i = 0; i < productAddInfoDetailAr.count; i ++) {
            
            ScenicSpotProductAddInfoDetailModel *model = productAddInfoDetailAr[i];
            [self productAddInfoDetailViewWithProductAddInfoDetailModel:model index:i];
            
        }
    }
    
}





/**
 * 根据model和下标index创建第index个小视图（信息）
 */
- (void)productAddInfoDetailViewWithProductAddInfoDetailModel:(ScenicSpotProductAddInfoDetailModel *)model index:(NSInteger)index{

    CGFloat spacing = 10.f;     //间距
    
    if (!model) {   //没有内容
        
        CGFloat height = [WXLabel getTextHeight:13 width:(kScreenWidth - spacing) text:@"无" linespace:5];
        
        UILabel *descDetailLb = [UILabel lableWithFrame:CGRectMake(0, 5, kScreenWidth - spacing, height)
                                                   text:@"无"
                                              textColor:[UIColor blackColor]
                                                   font:[UIFont systemFontOfSize:13]];
        descDetailLb.numberOfLines = 0;
        
        /**
         * 规定宽高
         */
        CGRect frame = CGRectMake(spacing / 2.0, 30 + (height + 10) * index, kScreenWidth - 10, height + 10);
        UIView *view = [[UIView alloc] initWithFrame:frame];
        view.layer.borderColor = [UIColor blackColor].CGColor;
        view.layer.borderWidth = 1;
        view.layer.cornerRadius = 5.0;
        
        [view addSubview:descDetailLb];
        [self.contentView addSubview:view];
        
    }else {
        CGFloat height = [WXLabel getTextHeight:13 width:(kScreenWidth - spacing) text:model.DescDetail linespace:5];
        
        UILabel *descDetailLb = [UILabel lableWithFrame:CGRectMake(0, 5, kScreenWidth - spacing, height) text:model.DescDetail textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13]];
        descDetailLb.numberOfLines = 0;
        
        /**
         * 规定宽高
         */
        CGRect frame = CGRectMake(spacing / 2.0, 30 + (height + 10) * index, kScreenWidth - 10, height + 10);
        UIView *view = [[UIView alloc] initWithFrame:frame];
        view.layer.borderColor = [UIColor blackColor].CGColor;
        view.layer.borderWidth = 1;
        view.layer.cornerRadius = 5.0;
        
        [view addSubview:descDetailLb];
        [self.contentView addSubview:view];
    }
   
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
