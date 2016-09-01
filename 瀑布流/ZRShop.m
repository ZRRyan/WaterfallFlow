
//
//  ZRShop.m
//  瀑布流
//
//  Created by Ryan on 15/10/12.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import "ZRShop.h"

@implementation ZRShop
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
//        self.img = dict[@"img"];
//        self.price = dict[@"price"];
//        self.w = [dict[@"w"] floatValue];
//        self.h = [dict[@"h"] floatValue];
    }
    return self;
}

+ (instancetype)initWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end


