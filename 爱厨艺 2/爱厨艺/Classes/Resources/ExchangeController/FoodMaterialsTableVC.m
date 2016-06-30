//
//  FoodMaterialsTableVC.m
//  爱厨艺
//
//  Created by shengdai on 15/12/15.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "FoodMaterialsTableVC.h"
#import "FoodMaterialTVCell.h"
#import "FoodMaterialModel.h"
#import "ExchangMaterialTableVC.h"

@interface FoodMaterialsTableVC ()

@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong)AVQuery *query;

@end

static NSString *identi =@"cellsource";

@implementation FoodMaterialsTableVC


- (instancetype)init{
    if (self = [super init]) {
        // 在网络中learnCloud中请求数据
        AVUser *currentUser = [AVUser currentUser];
        self.query = [AVQuery queryWithClassName:@"shicai"];
        NSArray *arrayQuery = [_query findObjects];
        for (AVObject *object in arrayQuery) {
            if ([[object objectForKey:@"userID"] isEqualToString:currentUser.objectId]) {
                FoodMaterialModel *model = [FoodMaterialModel new];
                model.name = [object objectForKey:@"name"];
                model.keywords = [object objectForKey:@"keywords"];
                model.img = [object objectForKey:@"img"];
                model.descrip = [object objectForKey:@"descrip"];
                // 将AVObject的id赋值给model的id，删除时用
                model.id = [object objectId];
                model.summary = [object objectForKey:@"shicai"];
                [self.dataArray addObject:model];
            }
        }
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(action4Back)];
    // 修改导航条上方的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.800 green:0.059 blue:0.125 alpha:1.000];
    // 修改字体的颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = self.titleString;
    [self.tableView registerNib:[UINib nibWithNibName:@"FoodMaterialTVCell" bundle:nil] forCellReuseIdentifier:identi];

}

// 返回事件
- (void)action4Back{
    [self dismissViewControllerAnimated:YES completion:^{
       
    }];
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodMaterialTVCell *cell = [tableView dequeueReusableCellWithIdentifier:identi forIndexPath:indexPath];
    if (_dataArray.count != 0) {
        FoodMaterialModel *foodModel = _dataArray[indexPath.row];
        NSString *stringImg = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@", foodModel.img];
        [cell setValueWithImgeUrl:stringImg titleText:foodModel.name detailText:foodModel.descrip keyWordText:foodModel.keywords];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenWitdh*5/16;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ExchangMaterialTableVC *foodMaterial = [[ExchangMaterialTableVC alloc] init];
    if (self.dataArray != nil) {
        FoodMaterialModel *model = self.dataArray[indexPath.row];
        foodMaterial.urlstring = model.summary;
        [self.navigationController pushViewController:foodMaterial animated:YES];
    }

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        FoodMaterialModel *model = self.dataArray[indexPath.row];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        // 从数据库中删除object
        AVObject *object = [AVObject objectWithoutDataWithClassName:@"shicai" objectId:model.id];
        [object deleteInBackground];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
