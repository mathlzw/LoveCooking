//
//  ZSDetailFoodManager.m
//  爱厨艺8
//
//  Created by shengdai on 15/12/7.
//  Copyright © 2015年 zsh. All rights reserved.
//

#import "ZSDetailFoodManager.h"
#import "ZSDetailFoodsModel.h"

#define kFoodsDisplayURLA @"http://cloud.99jkom.com/App.ashx?functionId=SKJ_GetDishDetail&action=%7B%22clientVersion%22%3A%221.2%22%2C%22userId%22%3A%22%22%2C%22clientGuid%22%3A%223DFA3C1F-70E9-4B62-82EB-D44694815CB4%22%2C%22DishID%22%3A"
#define kFoodDisplayUrlB @"%2C%22version%22%3A%221.2%22%2C%22clientType%22%3A%22YYS_iPhone%22%7D"

static ZSDetailFoodManager * dataManager = nil;
@implementation ZSDetailFoodManager

+ (ZSDetailFoodManager *)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager = [[ZSDetailFoodManager alloc]init];
        
    });
    return dataManager;
}

- (void)getDataWithUrlString:(NSString *)string{
    

    // 1、创建AFHTTPRequestOperationManager ---HTTP请求操作管理类的对象
    NSString *stringURl = [NSString stringWithFormat:@"%@%@%@",kFoodsDisplayURLA, string, kFoodDisplayUrlB];

   // NSLog(@"asdfasdfadsfasfasd%@",stringURl);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:stringURl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
     //   NSLog(@"JSON: %@", responseObject);
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSDictionary *diction = dict[@"resultValue"];
        ZSDetailFoodsModel *model = [[ZSDetailFoodsModel alloc]init];
        [model setValuesForKeysWithDictionary:diction];
        NSLog(@"%@",model);
        self.block(model);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误: %@", error);
    }];

}


@end
