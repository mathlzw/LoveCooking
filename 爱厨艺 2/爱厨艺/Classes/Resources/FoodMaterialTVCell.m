//
//  FoodMaterialTVCell.m
//  爱厨艺
//
//  Created by shengdai on 15/12/9.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "FoodMaterialTVCell.h"

@interface FoodMaterialTVCell ()

@property (weak, nonatomic) IBOutlet UILabel *lab4Detail;
@property (weak, nonatomic) IBOutlet UILabel *lab4Title;
@property (weak, nonatomic) IBOutlet UILabel *lab4KeyWord;


@property (weak, nonatomic) IBOutlet UIImageView *imgV4food;



@end

@implementation FoodMaterialTVCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setValueWithImgeUrl:(NSString *)imageUrl
                  titleText:(NSString *)titleText
                 detailText:(NSString *)detailText
                keyWordText:(NSString *)keyWord{
    [self.imgV4food sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"imgbg.png"]];
    self.lab4Title.text = titleText;
    self.lab4Detail.text = [NSString stringWithFormat:@"详细：%@",detailText];
    self.lab4Detail.font = [UIFont systemFontOfSize:13];
    self.lab4KeyWord.text = [NSString stringWithFormat:@"关键字：%@",keyWord];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
