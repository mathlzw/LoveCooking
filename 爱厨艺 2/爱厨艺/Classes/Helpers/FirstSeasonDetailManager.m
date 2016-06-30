//
//  FirstSeasonDetailManager.m
//  爱厨艺
//
//  Created by shengdai on 15/12/5.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "FirstSeasonDetailManager.h"
#import "FirstSeasonDetailModel.h"

@interface FirstSeasonDetailManager ()

@property (nonatomic, strong)NSMutableArray *dataArrayM;
@end

static FirstSeasonDetailManager *seasonDetailManager = nil;
@implementation FirstSeasonDetailManager

+ (FirstSeasonDetailManager *)shareManager{
    if (seasonDetailManager == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            seasonDetailManager = [FirstSeasonDetailManager new];
        });
    }
    return seasonDetailManager;
}

- (void)getWithUrlStr:(NSString *)urlStr{
    NSLog(@"%@",[urlStr  URLEncodedString]);
    // 将传进来的字符串拼接
    NSString *urlString = [NSString stringWithFormat:@"http://apis.juhe.cn/cook/query?key=ea5cadbd452e78137174ea88d7bdd946&menu=%@&rn=10&pn=1",[urlStr  URLEncodedString]];
    [self.dataArrayM removeAllObjects];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSLog(@"%@", urlString);
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *diction = responseObject;
        NSDictionary *dict1 = diction[@"result"];
        
        NSLog(@"%@",dict1 , diction);
//        NSArray *array = dict1[@"data"];
//        for (int i = 0; i < array.count; i ++) {
//            NSDictionary *dict = array[i];
//            FirstSeasonDetailModel *model = [FirstSeasonDetailModel new];
//            [model setValuesForKeysWithDictionary:dict];
//            model.imageUrl = [dict[@"albums"] lastObject];
//            [self.dataArrayM addObject:model];
//            self.block();
//        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"错误：%@",error);
    }];
}
// 懒加载
- (NSMutableArray *)dataArrayM{
    if (!_dataArrayM) {
        _dataArrayM = [NSMutableArray array];
    }
    return _dataArrayM;
}
// 桥接
- (NSArray *)dataArray{
    return _dataArrayM;
}

@end
