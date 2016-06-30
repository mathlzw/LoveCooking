//
//  ZSDetailTableViewCell.m
//  爱厨艺8
//
//  Created by shengdai on 15/12/7.
//  Copyright © 2015年 zsh. All rights reserved.
//

#import "ZSDetailTableViewCell.h"
#import "UIImageView+WebCache.h"


@interface ZSDetailTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *lab4Show;

@end


@implementation ZSDetailTableViewCell


- (void)setModel:( ZSDetailFoodsModel *)model{
    
//    _lab4Number.text = [NSString stringWithFormat:@"数量：%ld克",model.FenLiang];
    
    _lab4Show.text = [NSString stringWithFormat:@"营养功效：\n%@\n\n适宜人群：\n%@\n\n步骤：\n%@\n\n食材：",model.GongXiao,model.ShiYiRenQun,model.CookingStep];
    

}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
