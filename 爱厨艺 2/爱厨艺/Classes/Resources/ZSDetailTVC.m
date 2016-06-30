//
//  ZSDetailTVC.m
//  爱厨艺8
//
//  Created by shengdai on 15/12/7.
//  Copyright © 2015年 zsh. All rights reserved.
//

#import "ZSDetailTVC.h"
#import "ZSDetailTableViewCell.h"
#import "ZSDetailFoodManager.h"
#import "ZSDetailFoodsModel.h"
#import "UIImageView+WebCache.h"
#import "ZSTwoDetailTableViewCell.h"
#import "ZSFoodsModel.h"


@interface ZSDetailTVC ()
@property (nonatomic, strong) ZSDetailFoodsModel * models;
@end

@implementation ZSDetailTVC

static NSString * ident = @"cell";
static NSString * identifier = @"cellReuse";

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"12%@",self.urlString);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.839 green:0.141 blue:0.157 alpha:1.000];
  
    self.tableView.estimatedRowHeight = 30.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ZSDetailTableViewCell" bundle:nil] forCellReuseIdentifier:ident];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZSTwoDetailTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    // 设置分割线的颜色
    self.tableView.separatorColor = [UIColor whiteColor];
    // 设置UINavigationBar 的标题
//    ZSFoodsModel * model = [[ZSFoodsModel alloc]init];
//    self.title = @"你好";
    self.navigationItem.title = _text;
    
    // 设置头视图的图片
    UIImageView * headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 270)];
    
    [[ZSDetailFoodManager shareManager] getDataWithUrlString:self.urlString];
    __weak typeof(self) temp = self;
    [ZSDetailFoodManager shareManager].block = ^(ZSDetailFoodsModel *model){
        temp.models = model;
        [headerView sd_setImageWithURL:[NSURL URLWithString:self.models.ImgUrl]];
        [temp.tableView reloadData];
        
    };
    // 添加头视图
    self.tableView.tableHeaderView = headerView;
    
    // 设置返回按钮

    UIBarButtonItem * BI = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickBackBI:)];
    self.navigationItem.leftBarButtonItem = BI;
    
}
- (void)clickBackBI:(UIBarButtonItem *)sender{
    
    // 模态返回
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
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

    return self.models.IngredientList.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZSDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
        cell.model = self.models;
        cell.selectionStyle = 0;
        return cell;
    }else{
        ZSTwoDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        NSDictionary *dic = _models.IngredientList[indexPath.row - 1];
//        [cell.img4Picture sd_setImageWithURL:dic[@"IngreImgUrl"]];
        [cell.img4Picture sd_setImageWithURL:dic[@"IngreImgUrl"] placeholderImage:[UIImage imageNamed:@"zhanweitu.png"]];
        cell.lab4Name.text = dic[@"Ingrename"];
        // int 类型需要转化为string类型的才能显示
        cell.lab4Weight.text = [NSString stringWithFormat:@"%@",dic[@"IngreWeight"]];
        cell.selectionStyle = 0;
        cell.model = self.models;
        return cell;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
