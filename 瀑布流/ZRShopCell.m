
//
//  ZRShopCell.m
//  瀑布流
//
//  Created by Ryan on 15/10/12.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import "ZRShopCell.h"
#import "UIImageView+WebCache.h"

@interface ZRShopCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ZRShopCell

/**
 * <#content#>
 */
- (void)setShop:(ZRShop *)shop
{
    _shop = shop;
      // 1.图片
    NSURL *url = [NSURL URLWithString:shop.img];
//    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loading"]];
    self.label.text = shop.price;
} 
@end
