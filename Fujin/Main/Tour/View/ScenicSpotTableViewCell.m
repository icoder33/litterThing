//
//  ScenicSpotTableViewCell.m
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/4.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import "ScenicSpotTableViewCell.h"
#import "ScenicSpotModel.h"
#import "UIImageView+WebCache.h"

@interface ScenicSpotTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *recommandLb;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UILabel *starLb;
@property (weak, nonatomic) IBOutlet UILabel *gradeLb;

@end

@implementation ScenicSpotTableViewCell

- (void)awakeFromNib {

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setScenicSpotModel:(ScenicSpotModel *)scenicSpotModel{
    if (_scenicSpotModel != scenicSpotModel) {
        _scenicSpotModel = scenicSpotModel;
        
        self.nameLb.text = scenicSpotModel.Name;
        self.recommandLb.text = scenicSpotModel.ProductManagerRecommand;
        self.addressLb.text = [NSString stringWithFormat:@"地址：%@",scenicSpotModel.Address];
        self.gradeLb.text = [NSString stringWithFormat:@"评分：%.1lf",scenicSpotModel.CommentGrade];
        
        switch (scenicSpotModel.Star) {
            case 0:
                self.starLb.text = nil;
                break;
            case 1:
                self.starLb.text = @"星级：A";
                break;
            case 2:
                self.starLb.text = @"星级：AA";
                break;
            case 3:
                self.starLb.text = @"星级：AAA";
                break;
            case 4:
                self.starLb.text = @"星级：AAAA";
                break;
                
            default:
                self.starLb.text = @"星级：AAAAA";
                break;
        }
        
    }
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:scenicSpotModel.Image]];
}










- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
