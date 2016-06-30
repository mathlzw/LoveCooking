//
//  FirstScrollManager.m
//  爱厨艺
//
//  Created by shengdai on 15/12/4.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import "FirstScrollManager.h"
#import "FirstScrollModel.h"

#define kScrllURL @"http://api.izhangchu.com/?methodName=HomeIndex&user_id=0&version=1.0"
#define kScrllURL1 @"http://api.izhangchu.com/?"
#define kScrllURL2  @"methodName=HomeIndex&user_id=0&version=1.0"

@interface FirstScrollManager ()
@property(nonatomic,retain)NSMutableArray *scrollArray;

@end

static FirstScrollManager *dataManager = nil;
@implementation FirstScrollManager

+(FirstScrollManager *)shareMnager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager =[[FirstScrollManager alloc] init];
        [dataManager parseData];
    });
    return dataManager;
}

//解析
-(void)parseData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __weak typeof(self)temp =self ;
  [manager GET:kScrllURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"请求成功");
        NSDictionary *data = responseObject[@"data"];
        NSDictionary *banner = data[@"banner"];
        NSArray *array = banner[@"data"];
        for (NSDictionary *dic in array) {
            FirstScrollModel *model = [FirstScrollModel new];
            [model setValuesForKeysWithDictionary:dic];
            [temp.scrollArray addObject:model];
        }
        NSLog(@"----------%lu",(unsigned long)_scrollArray.count);
            self.myUpdataUI();
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@",error);
    }];
}

//懒加载
-(NSMutableArray *)scrollArray{
    if (!_scrollArray) {
        _scrollArray = [NSMutableArray new];
    }
    return _scrollArray;
}

//桥接
-(NSMutableArray *)allScroll{
    return self.scrollArray;
}

@end
