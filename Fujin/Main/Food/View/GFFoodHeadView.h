//
//  GFFoodHeadView.h
//  附近
//
//  Created by wanggf on 15/8/15.
//  Copyright (c) 2015年 wanggf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFFoodHeadView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSArray *kindArray;

@end
