//
//  FirstSeasonFoodDetailVC.h
//  爱厨艺
//
//  Created by shengdai on 15/12/5.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstSeasonDetailModel.h"

@interface FirstSeasonFoodDetailVC : UITableViewController

@property(nonatomic, strong)FirstSeasonDetailModel *model;

@property (nonatomic, strong)NSString *isCollect;

@end
