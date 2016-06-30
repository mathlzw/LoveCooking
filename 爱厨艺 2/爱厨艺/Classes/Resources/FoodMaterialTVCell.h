//
//  FoodMaterialTVCell.h
//  爱厨艺
//
//  Created by shengdai on 15/12/9.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodMaterialTVCell : UITableViewCell

- (void)setValueWithImgeUrl:(NSString *)imageUrl
                  titleText:(NSString *)titleText
                 detailText:(NSString *)detailText
                keyWordText:(NSString *)keyWord;

@end
