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

@property NSMutableArray *outputArray;
@property NSArray *textPool;    // 追加
@property CustomTableViewCell *stubCell;  // 追加

@end
