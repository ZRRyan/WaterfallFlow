//
//  ViewController.m
//  瀑布流
//
//  Created by Ryan on 15/10/12.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import "ViewController.h"
#import "ZRShop.h"
#import "ZRShopCell.h"
#import "ZRWaterFlowLayout.h"
#import "MJRefresh.h"

#define CellID @"Shop"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,ZRWaterFlowLayoutDelegate>
@property (weak, nonatomic) UICollectionView  *collectionView;
@property (nonatomic, strong) NSMutableArray *shops;
@property (strong, nonatomic) ZRWaterFlowLayout  *layout;
@end

@implementation ViewController

- (NSArray *)shops
{
    if (!_shops) {
      _shops = [NSMutableArray array];
       
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.初始化数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray * arrMShop = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        ZRShop * shop = [ZRShop initWithDict:dict];
        [arrMShop addObject:shop];
    }
    _shops = arrMShop;
    
    self.layout = [[ZRWaterFlowLayout alloc] init];
    self.layout.delegate = self;
    
    // 2.创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:@"ZRShopCell" bundle:nil] forCellWithReuseIdentifier:CellID];
     collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    
    // 3.增加刷新控件
    [self.collectionView addFooterWithTarget:self action:@selector(loadMore)];
}

- (void)loadMore
{
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dict in dictArray) {
        ZRShop * shop = [ZRShop initWithDict:dict];
        [self.shops addObject:shop];
    }
    [self.collectionView reloadData];
    [self.collectionView footerEndRefreshing];
});
}
-(void)viewDidLayoutSubviews
{

    [super viewDidLayoutSubviews];
 
    BOOL isH = self.view.frame.size.width > self.view.frame.size.height ? YES : NO;
    if (isH) {
        self.layout.columuCount = 5;
    }
    else
    {
        self.layout.columuCount = 3;
    }
       self.collectionView.frame = self.view.bounds;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _shops.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZRShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    [cell setBackgroundColor:[UIColor redColor]];
    return cell;
}

#pragma mark - ZRWaterFlowLayoutDelegate
- (CGFloat)waterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    ZRShop *shop = self.shops[indexPath.item];
    
    CGFloat h = shop.h * width / shop.w;
    
    return h;
}
@end
