//
//  DetailClassVC.m
//  ClassHealth
//
//  Created by shengdai on 15/12/8.
//  Copyright © 2015年 SYROberser. All rights reserved.
//

#import "DetailClassVC.h"
#import "DeatailWebView.h"
#import "DetailClassCell.h"
#import "TableModel.h"


@interface DetailClassVC ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger start;

@end

static NSString *identifier = @"cell";
//上拉加载
static int start = 0;

@implementation DetailClassVC

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *left1 = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(backBeforePage:)];
        self.navigationItem.leftBarButtonItem = left1;
    }
    return self;
}
-(void)backBeforePage:(UIBarButtonItem *)sender{
    // 发送消息
    UIView *aview = [[UIView alloc]initWithFrame:self.view.frame];
    aview.backgroundColor = [UIColor blackColor];
    aview.alpha = 0.8;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:nil userInfo:@{@"color":aview}];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (start != 0) {
        start = 0;
    }
    NSLog(@"%d",start);
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailClassCell" bundle:nil] forCellReuseIdentifier:identifier];
    [_dataArray removeAllObjects];
    //数据解析
    [self parse];
    
    //上拉加载
    [self loading];
    //刷新
    [self refresh];
    
    //检测网络连接
    [self reach];
}

#pragma mark --数据解析

-(void)parse{
    NSLog(@"%ld",(long)self.tagid);
    NSString *URLstring = [NSString string];
    if (_array.count > 10) {
        URLstring = [NSString stringWithFormat:@"http://www.ecook.cn/public/selectOneTwoThreeTags.shtml?machine=7e7a5fcaf52bdc3ed872d20690f41cde&start=%ld&tags=%ld&version=11.4.0.7",(long)start*10,(long)self.tagid];
        NSLog(@"%@",URLstring);
    }else{
        URLstring = [NSString stringWithFormat:@"http://www.ecook.cn/public/selectOneTwoThreeTags.shtml?machine=7e7a5fcaf52bdc3ed872d20690f41cde&start=%ld&tags=%ld&version=11.4.0.7",(long)start*10,(long)self.tagid+1];
        NSLog(@"%@",URLstring);
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URLstring parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        for (NSDictionary *dic in responseObject[@"list"]) {
            TableModel *model = [TableModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    
    
}


-(void)loading {
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            // 结束刷新
            
            start++;
            if (start >= 10) {
                [self.tableView.mj_footer endRefreshing];
                return;
            }
            [self parse];
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
        });
    }];
}
-(void)refresh{
    
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self.tableView reloadData];
        
        [self.tableView.mj_header beginRefreshing];
        
        
        if (_dataArray.count != 0) {
            [self.tableView.mj_header endRefreshing];
        }else{
            
            self.tableView.backgroundColor = [UIColor redColor];
        }
        
        
        
    }];
    
    
    
}
#pragma mark - 检测网络连接
- (void)reach
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld", (long)status);
    }];
}


//--------懒加载
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailClassCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    TableModel *model = _dataArray[indexPath.row];
    cell.lab4Name.text = model.name;
    cell.lab4Content.text = model.content;
    cell.lab4Content.numberOfLines = 0;
    if (model.imageid != nil) {
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg",model.imageid]]];
    }
    if([model.imageid isEqualToString:@""]){
        cell.imgView.image = [UIImage imageNamed:@"nonPic"];
    }
    return cell;
}

//cell跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DeatailWebView *detail = [[DeatailWebView alloc]init];
    TableModel *model = _dataArray[indexPath.row];
    if (model.url !=nil) {
        detail.id = model.id;
        detail.title = model.name;
    }
    [self.navigationController pushViewController:detail animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.height*0.18;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
