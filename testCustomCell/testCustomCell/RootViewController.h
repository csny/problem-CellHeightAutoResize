//
//  RootViewController.h
//  testCustomCell
//
//  Created by macbook on 2015/03/22.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"

@interface RootViewController : UITableViewController
{
    NSMutableArray *_objects;
    NSArray *_textArray;    // 追加
    CustomTableViewCell *_stubCell;  // 追加
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
