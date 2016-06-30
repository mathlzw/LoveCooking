//
//  DataParseManager.m
//  ClassHealth
//
//  Created by shengdai on 15/12/8.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import "DataParseManager.h"
#import "ClassModel.h"
#define URL @"http://www.ecook.cn/public/selectRecipeHome.shtml?machine=Oc1cd5a9eb17e5574e491e1affb90b93a74da9efb&vession=11.4.0.7"

@interface DataParseManager ()

@end


static DataParseManager *dataManager = nil;
@implementation DataParseManager

+(DataParseManager *)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        dataManager = [DataParseManager new];
        //数据解析
        [dataManager data];
    });
    return dataManager;
}
-(void)data{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        __weak typeof(self)temp =self ;
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
           
            NSMutableArray *arrayList = responseObject[@"list"];
            for (NSDictionary *dic in arrayList) {
                NSArray *listarr = dic[@"list"];
                self.dicDataArray = [NSMutableArray array];
                for (NSDictionary *dicc in listarr) {
                    ClassModel *model = [ClassModel new];
                    [model setValuesForKeysWithDictionary:dicc];
                    [temp.dicDataArray addObject:model];
                }
                [self.dic setObject:_dicDataArray forKey:dic[@"tagspo"][@"name"]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                temp.myUpdataUI();
            });
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"请求失败");
        }];
}

- (NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [[NSMutableDictionary alloc]init];
    }
    return _dic;
}



@end
