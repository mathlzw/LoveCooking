//
//  FoodMaterialManager.m
//  爱厨艺
//
//  Created by shengdai on 15/12/9.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "FoodMaterialManager.h"
#import "FoodMaterialModel.h"

@interface FoodMaterialManager ()

@property (nonatomic, strong)NSMutableArray *arrayM;

@end

static FoodMaterialManager *foodMaterial = nil;
@implementation FoodMaterialManager

+ (FoodMaterialManager *)shareManager{
    if(foodMaterial == nil){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            foodMaterial = [FoodMaterialManager new];
        });
    }
    return foodMaterial;
}

- (void)getdataWith:(NSString *)url{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        NSArray *array = dict[@"tngou"];
        [self.arrayM removeAllObjects];
        for (int i = 0; i < array.count; i ++) {
            NSDictionary *dictionary = array[i];
            FoodMaterialModel *model = [FoodMaterialModel new];
            [model setValuesForKeysWithDictionary:dictionary];
            NSString *str = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@", model.img];
            model.img = str;
            [self.arrayM addObject:model];
        }
        self.block();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (NSMutableArray *)arrayM{
    if (!_arrayM) {
        _arrayM = [NSMutableArray array];
    }
    return _arrayM;
}

- (NSArray *)dataArray{
    return self.arrayM;
}



@end
