//
//  LQFindViewController.m
//  LOL
//
//  Created by LQ on 16/2/25.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import "LQFindViewController.h"

#import "LQFindNormalTableViewCell.h"
#import "LQFindPicTableViewCell.h"

#import "LQFindModel.h"

@interface LQFindViewController ()

@property(nonatomic,strong)NSMutableArray * dataSource;


@end

@implementation LQFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [[NSMutableArray alloc]init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LQFindNormalTableViewCell" bundle:nil] forCellReuseIdentifier:@"normal"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LQFindPicTableViewCell" bundle:nil] forCellReuseIdentifier:@"pic"];
    
    //加载数据
    [self startRequest];
}

- (void)startRequest{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:kSinaUrlString parameters:self success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dic[@"data"];
        
        NSArray *listArr = dataDic[@"list"];
        
        //forin得到每条新闻
        for (NSDictionary * newsDic in listArr) {
            
            //建立数据模型
            
            LQFindModel *model = [[LQFindModel alloc]init];
            [model setValuesForKeysWithDictionary:newsDic];
            
            //加载数据源
            [self.dataSource addObject:model];
            
            [self.tableView reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"%@",error.localizedDescription);
        
    }];
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
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //得到该行数据，根据数据判断定制
    
    LQFindModel *model = self.dataSource[indexPath.row];
    
    if (!model.pics.count) {
        LQFindNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normal" forIndexPath:indexPath];
        
        [cell loadDataFromModel:model];
        
        return cell;
    }else{
        
        LQFindPicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pic" forIndexPath:indexPath];
        
        [cell loadDataFromModel:model];
        
        return cell;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LQFindModel *model = self.dataSource[indexPath.row];
    
    if (!model.pics.count) {
        return 100;
    }
    return 150;
    
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
