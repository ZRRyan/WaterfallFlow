//
//  ZRWaterFlowLayout.m
//  瀑布流
//
//  Created by Ryan on 15/10/12.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import "ZRWaterFlowLayout.h"

@interface ZRWaterFlowLayout ()
/** 这个字典用来存储每一列最大的Y值(每一列的高度) */
@property (nonatomic, strong) NSMutableDictionary *maxYDict;

/** 存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray *attsArrM;
@end

@implementation ZRWaterFlowLayout


- (NSMutableDictionary *)maxYDict
{
    if (!_maxYDict) {
        _maxYDict = [[NSMutableDictionary alloc] init];
        
    }
    return _maxYDict;
}

- (NSMutableArray *)attsArrM
{
    if (!_attsArrM) {
        _attsArrM = [[NSMutableArray alloc] init];
    }
    return _attsArrM;
}


- (instancetype)init
{
    if (self = [super init]) {
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.marginX = 10;
        self.marginY = 10;
        self.columuCount = 3;
    }
    return self;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


/**
 * 每次布局之前的准备
 */
-(void)prepareLayout
{
    [super prepareLayout];
    // 清空最大的Y值
    for (int i = 0; i < self.columuCount; i ++) {
        NSString *column = [NSString stringWithFormat:@"%d",i];
        self.maxYDict[column] = @(self.sectionInset.top);
    }
    
    // 计算所有cell的属性
    [self.attsArrM removeAllObjects];
    NSMutableArray *arrM = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i ++) {
        [arrM addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
    self.attsArrM = arrM;
}

/**
 * 返回所有的尺寸
 */
- (CGSize)collectionViewContentSize
{
    __block NSString *maxColumn = @"0";
    
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
     return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue] + self.sectionInset.bottom);
}


-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
     // 假设最短的那一列的第0列
    __block NSString *minColumn = @"0";
    
    // 找出最短的那一列
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] < [self.maxYDict[minColumn] floatValue]) {
            minColumn = column;
        }
    }];
  
     // 计算尺寸
    CGFloat w = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.columuCount - 1) * self.marginX ) / self.columuCount;
    CGFloat h = [self.delegate waterFlowLayout:self heightForWidth:w atIndexPath:indexPath];
    
    // 计算位置
    CGFloat x = self.sectionInset.left + (w + self.marginX) * [minColumn intValue];
    CGFloat y = [self.maxYDict[minColumn] floatValue] + self.marginY;
    
    // 更新这一列的最大Y值
    self.maxYDict[minColumn] = @(y + h);
    
    // 创建属性
    UICollectionViewLayoutAttributes *atts = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    atts.frame = CGRectMake(x, y, w, h);
    
    return atts;
}


-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
//    for (int i = 0; i < self.columuCount; i ++) {
//        NSString *column = [NSString stringWithFormat:@"%d",i];
//        self.maxYDict[column] = @0;
//    }
//    
//    NSMutableArray *arrM = [NSMutableArray array];
//    NSInteger count = [self.collectionView numberOfItemsInSection:0];
//    for (int i = 0; i < count; i ++) {
//        [arrM addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
//    }
//    return arrM;
    return self.attsArrM;
}

@end
