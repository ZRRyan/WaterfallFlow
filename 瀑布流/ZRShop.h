//
//  ZRShop.h
//  瀑布流
//
//  Created by Ryan on 15/10/12.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRShop : NSObject
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *price;

- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)initWithDict:(NSDictionary*)dict;
@end
