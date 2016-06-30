//
//  ZSTwoDetailTableViewCell.h
//  爱厨艺8
//
//  Created by shengdai on 15/12/8.
//  Copyright © 2015年 zsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSDetailFoodsModel.h"

@interface ZSTwoDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img4Picture;

@property (weak, nonatomic) IBOutlet UILabel *lab4Name;
@property (weak, nonatomic) IBOutlet UILabel *lab4Weight;



@property (nonatomic ,strong)  ZSDetailFoodsModel * model;

@end
