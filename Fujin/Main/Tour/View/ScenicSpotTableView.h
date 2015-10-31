//
//  ScenicSpotsTableView.h
//  ScenicSpots
//
//  Created by Jorn.Wu on 15/9/4.
//  Copyright (c) 2015年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScenicSpotTableView;
@protocol ScenicSpotTableViewDelegate <NSObject>

/**
 * 选择某行
 */
- (void)scenicSpotTableView:(ScenicSpotTableView *)tableView didSelectIndex:(NSInteger)index;

/**
 * 点击搜索按钮
 */
- (void)scenicSpotTableView:(ScenicSpotTableView *)tableView ClickSearchButtomWithText:(NSString *)searchBarText;

@end

@interface ScenicSpotTableView : UITableView

@property (nonatomic, weak) id<ScenicSpotTableViewDelegate> myDelegate;

@property (nonatomic, copy) NSArray *ScenicSpotListAr;

@end
