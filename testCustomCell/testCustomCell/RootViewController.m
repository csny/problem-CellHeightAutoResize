//
//  RootViewController.m
//  testCustomCell
//
//  Created by macbook on 2015/03/22.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

static NSString * const TableViewCustomCellIdentifier = @"XibCustomCell";

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // editボタンの設置
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    // addボタンの設置と動作
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    /* まとめちゃう
    UINib *nib = [UINib nibWithNibName:TableViewCustomCellIdentifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell1"];
    */
    // カスタマイズしたセルをテーブルビューにセット
    [self.tableView registerNib:[UINib nibWithNibName:TableViewCustomCellIdentifier bundle:nil]
     forCellReuseIdentifier:@"Cell"];
    // セルのプロトタイプを高さ計算用の変数に入れておく
    //_stubCell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    // UITableViewAutomaticDimensionはiOS8から
    // セルの高さの計算は Autolayout に任せる
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40.0;
    
    // 文字列の配列の作成
    _textArray = @[@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sodales diam sed turpis mattis dictum. In laoreet porta eleifend. Ut eu nibh sit amet est iaculis faucibus.",@"initWithBitmapDataPlanes:pixelsWide:pixelsHigh:bitsPerSample:samplesPerPixel:hasAlpha:isPlanar:colorSpaceName:bitmapFormat:bytesPerRow:bitsPerPixel:", @"祇辻飴葛蛸鯖鰯噌庖箸", @"Nam in vehicula mi.", @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.", @"あのイーハトーヴォの\nすきとおった風、\n夏でも底に冷たさをもつ青いそら、\nうつくしい森で飾られたモーリオ市、\n郊外のぎらぎらひかる草の波。"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// addボタンで呼ばれる動作
- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    // 追加
    // データ作成
    int dataIndex = arc4random() % _textArray.count;
    NSString *string = _textArray[dataIndex];
    //NSDate *date = [NSDate date];
    NSDictionary *dataDictionary = @{@"string": string};
    
    // データ挿入
    [_objects insertObject:dataDictionary atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    // テーブルビュー更新
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

// テーブルビュー更新で呼ばれる
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *customCell = (CustomTableViewCell *)cell;
    
    // メインラベルに文字列を設定
    NSDictionary *dataDictionary = _objects[indexPath.row];
    customCell.bodyLabel.text = dataDictionary[@"string"];
    
    /*
    // サブラベルに文字列を設定
    NSDate *date = dataDictionary[@"date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy年MM月dd日 HH時mm分ss秒";
    customCell.subLabel.text = [dateFormatter stringFromDate:date];
     */
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

/* UITableViewAutomaticDimensionで代替
// セルの高さを可変にする
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 計測用のプロパティ"_stubCell"を使って高さを計算する
    [self configureCell:_stubCell atIndexPath:indexPath];
    [_stubCell layoutSubviews];
    CGFloat height = [_stubCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    //NSLog(@"heightForRow:%f", height);
    return height + 1;
}
*/

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.estimatedRowHeight;
}

// 指定したパスが、編集可能かどうかを返す
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// 指定したパスに対して、編集が行われたことを通知する
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
