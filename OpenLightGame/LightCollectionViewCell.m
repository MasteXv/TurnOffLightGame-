//
//  LightCollectionViewCell.m
//  OpenLightGame
//
//  Created by 鲜美生活 on 2017/7/31.
//  Copyright © 2017年 小旭. All rights reserved.
//

#import "LightCollectionViewCell.h"

@implementation LightCollectionViewCell
- (void)setModel:(LightModel *)model{
    _model = model;
    if ([model.IsOpen isEqualToString:@"ON"]) {
        self.LightImageV.image = [UIImage imageNamed:@"002"];
    }else{
        self.LightImageV.image = [UIImage imageNamed:@"001"];
    }
    
}
@end
