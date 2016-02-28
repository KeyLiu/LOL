//
//  LQFindPicTableViewCell.h
//  LOL
//
//  Created by LQ on 16/2/25.
//  Copyright © 2016年 LIUQI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQFindModel.h"

@interface LQFindPicTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *newsLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

- (void)loadDataFromModel:(LQFindModel *)model;

@end
