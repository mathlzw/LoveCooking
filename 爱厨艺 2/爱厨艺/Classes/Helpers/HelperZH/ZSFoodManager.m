//
//  ZSFoodManager.m
//  爱厨艺8
//
//  Created by shengdai on 15/12/5.
//  Copyright © 2015年 zsh. All rights reserved.
//

#import "ZSFoodManager.h"
#import "ZSFoodsModel.h"
// 早中晚推荐接口
#define kFoodsDisplayURL @"http://cloud.99jkom.com/App.ashx?functionId=YYPC_CateringList&action=%7B%22clientVersion%22%3A%221.2%22%2C%22CaterID%22%3A0%2C%22userId%22%3A%22%22%2C%22clientGuid%22%3A%223DFA3C1F-70E9-4B62-82EB-D44694815CB4%22%2C%22version%22%3A%221.2%22%2C%22clientType%22%3A%22YYS_iPhone%22%2C%22IsNew%22%3Atrue%7D"

@interface ZSFoodManager ()
// 创建一个可变数组存放解析好的数据
// 早餐数组
@property (nonatomic,strong)NSMutableArray * zaoFoodsArray;
// 中餐数组
@property (nonatomic,strong)NSMutableArray * zhongFoodsArray;
// 晚餐数组
@property (nonatomic,strong)NSMutableArray * wanFoodsArray;

@end


static ZSFoodManager * dataManager = nil;
@implementation ZSFoodManager

+(ZSFoodManager *)shareManager{
   // 快捷代码块  dispatch
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager = [[ZSFoodManager alloc] init];
        //[dataManager getData];
    });
    return dataManager;

}

// 解析
- (void)getData{
    // 1、创建AFHTTPRequestOperationManager ---HTTP请求操作管理类的对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    // 2、发送get请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 3、
    [manager GET:kFoodsDisplayURL parameters:nil
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
          //   NSLog(@"%@",responseObject);
             // 开始解析
             // 因为最外层是个字典，所以先把data类型的responseObject转化为字典
             NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil]; // 这句话不能省
             
             NSDictionary * resultValue = dict[@"resultValue"];
             
             // 早餐
            [self.zaoFoodsArray removeAllObjects];
             NSArray * ZaoCanArray = resultValue[@"ZaoCan"];
             for (NSDictionary * dic in ZaoCanArray) {
                 ZSFoodsModel * model = [ZSFoodsModel new];
                 [model setValuesForKeysWithDictionary:dic];
                 [self.zaoFoodsArray addObject:model];
            //     NSLog(@"sssss%ld",_zaoFoodsArray.count);
             }
             // 中餐
             [self.zhongFoodsArray removeAllObjects];
             NSArray * ZhongCanArray = resultValue[@"ZhongCan"];
             for (NSDictionary * dic in ZhongCanArray) {
                 ZSFoodsModel * model = [ZSFoodsModel new];
                 [model setValuesForKeysWithDictionary:dic];
                 [self.zhongFoodsArray addObject:model];
            //     NSLog(@"sssss%ld",_zhongFoodsArray.count);
             }
             
             // 晚餐
            [self.wanFoodsArray removeAllObjects];
             NSArray * WanCanArray = resultValue[@"WanCan"];
             for (NSDictionary * dic in WanCanArray) {
                 ZSFoodsModel * model = [ZSFoodsModel new];
                 [model setValuesForKeysWithDictionary:dic];
                 [self.wanFoodsArray addObject:model];
              //   NSLog(@"sssss%ld",_wanFoodsArray.count);
             }
             
             // 设置主线程更新UI界面
//             __weak typeof(self)temp = self;
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.myUpdataUI(self.zaoFoodsArray,self.zhongFoodsArray,self.wanFoodsArray);
             });

           //  NSLog(@"数据请求成功");
             
         } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
             // 这里写错误处理
          //   NSLog(@"请求失败：%@",error);
         }];
 
}

// 懒加载
- (NSMutableArray *)zaoFoodsArray{
    // 如果不存在就创建
    if (!_zaoFoodsArray) {
        _zaoFoodsArray = [[NSMutableArray alloc] init];
        
    }
    return _zaoFoodsArray;
}

- (NSMutableArray *)zhongFoodsArray{
    // 如果不存在就创建
    if (!_zhongFoodsArray) {
        _zhongFoodsArray = [[NSMutableArray alloc] init];
        
    }
    return _zhongFoodsArray;
}

- (NSMutableArray *)wanFoodsArray{
    // 如果不存在就创建
    if (!_wanFoodsArray) {
        _wanFoodsArray = [[NSMutableArray alloc] init];
        
    }
    return _wanFoodsArray;
}






@end
