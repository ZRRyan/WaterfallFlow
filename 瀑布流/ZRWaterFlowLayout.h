//
//  ZRWaterFlowLayout.h
//  瀑布流
//
//  Created by Ryan on 15/10/12.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZRWaterFlowLayout;

@protocol ZRWaterFlowLayoutDelegate <NSObject>

- (CGFloat)waterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface ZRWaterFlowLayout : UICollectionViewLayout
@property (assign, nonatomic) UIEdgeInsets sectionInset;
/** 每一列之间的间距 */
@property (assign, nonatomic) CGFloat marginX;
/** 每一行之间的间距 */
@property (assign, nonatomic) CGFloat marginY;
/** 显示多少列 */
@property (assign, nonatomic) int columuCount;

@property (assign, nonatomic) id<ZRWaterFlowLayoutDelegate> delegate;
@end
