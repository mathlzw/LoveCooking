//
//  ZHTableViewCell.m
//  爱厨艺
//
//  Created by shengdai on 15/12/4.
//  Copyright © 2015年 zsh. All rights reserved.
//

#import "ZHTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ZHTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *lab4Name;
@property (weak, nonatomic) IBOutlet UILabel *lab4hot;
@property (weak, nonatomic) IBOutlet UILabel *lab4Number;
@property (weak, nonatomic) IBOutlet UIImageView *view4Image;

@end


@implementation ZHTableViewCell

- (void)setModel:(ZSFoodsModel *)model{
    _model = model;
    
    [_view4Image sd_setImageWithURL:[NSURL URLWithString:model.ImgUrl] placeholderImage:[UIImage imageNamed:@"imgbg.png"]];
    _lab4Name.text = model.DishName;
    _lab4hot.text = [NSString stringWithFormat:@"热量：%ld/100克",(long)model.ReLiang];
    _lab4Number.text = [NSString stringWithFormat:@"数量：%ld克",(long)model.FenLiang];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
