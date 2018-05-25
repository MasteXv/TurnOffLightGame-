//
//  LightCollectionViewCell.h
//  OpenLightGame
//
//  Created by 鲜美生活 on 2017/7/31.
//  Copyright © 2017年 小旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightModel.h"
@interface LightCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *LightImageV;
@property (nonatomic, strong)LightModel *model;
@end
