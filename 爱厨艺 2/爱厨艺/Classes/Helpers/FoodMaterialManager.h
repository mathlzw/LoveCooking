//
//  FoodMaterialManager.h
//  爱厨艺
//
//  Created by shengdai on 15/12/9.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^myblock) ();

@interface FoodMaterialManager : NSObject

@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, copy)myblock block;

+ (FoodMaterialManager *)shareManager;

- (void)getdataWith:(NSString *)url;



@end
