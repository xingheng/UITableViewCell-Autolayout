//
//  Table2ViewController.m
//  TableCell-Autolayout
//
//  Created by WeiHan on 17/10/2017.
//  Copyright © 2017 WillHan. All rights reserved.
//

#import "Table2ViewController.h"

extern NSString * GetRandomString(NSUInteger length);

#pragma mark - MultipleLineLableWithButtonCell

@interface MultipleLineLableWithButtonCell : UITableViewCell

@property (nonatomic, strong) UILabel *theLabel;

@end

@implementation MultipleLineLableWithButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [UILabel new];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        self.theLabel = label;

        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:18];

        [button setTitle:@"Accessory Button" forState:UIControlStateNormal];

        [self.contentView addSubview:label];
        [self.contentView addSubview:button];

        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.top);
            make.centerX.width.equalTo(self.contentView);
            make.bottom.equalTo(button.top);
        }];

        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.bottom);
            make.bottom.equalTo(self.contentView.bottom);
            make.centerX.width.equalTo(self.contentView);
        }];
    }

    return self;
}

@end


#pragma mark - Table2ViewController

#define kCellIDKey @"MultipleLineLableWithButtonCell"

@interface Table2ViewController ()

@property (nonatomic, strong) NSArray<NSString *> *dataItems;

@end

@implementation Table2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[MultipleLineLableWithButtonCell class] forCellReuseIdentifier:kCellIDKey];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray<NSString *> *)dataItems
{
    if (!_dataItems) {
        NSMutableArray<NSString *> *array = [NSMutableArray new];

        for (NSUInteger i = 1; i < 50; i++) {
            [array insertObject:GetRandomString(i * 3) atIndex:arc4random_uniform((int)array.count)];
        }

        _dataItems = array;
    }

    return _dataItems;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MultipleLineLableWithButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIDKey forIndexPath:indexPath];

    cell.theLabel.text = self.dataItems[indexPath.row];
    cell.contentView.backgroundColor = LightRandomColor;

    return cell;
}

@end
