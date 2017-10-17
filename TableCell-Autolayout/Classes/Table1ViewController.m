//
//  Table1ViewController.m
//  TableCell-Autolayout
//
//  Created by WeiHan on 17/10/2017.
//  Copyright © 2017 WillHan. All rights reserved.
//

#import "Table1ViewController.h"

NSString * GetRandomString(NSUInteger length)
{
    NSMutableString *string = [NSMutableString new];

    for (NSUInteger i = 0; i < length; i++) {
        [string appendFormat:@"%c", arc4random_uniform(58) + 64];
    }

    return string;
}

#pragma mark - MultipleLineLableCell

@interface MultipleLineLableCell : UITableViewCell

@property (nonatomic, strong) UILabel *theLabel;

@end

@implementation MultipleLineLableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [UILabel new];
        self.theLabel = label;

        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:label];

        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }

    return self;
}

@end


#pragma mark - Table1ViewController

#define kCellIDKey @"MultipleLineLableCell"

@interface Table1ViewController ()

@property (nonatomic, strong) NSArray<NSString *> *dataItems;

@end

@implementation Table1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[MultipleLineLableCell class] forCellReuseIdentifier:kCellIDKey];
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

        for (NSUInteger i = 1; i < 100; i++) {
            [array insertObject:GetRandomString(i) atIndex:arc4random_uniform((int)array.count)];
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
    MultipleLineLableCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIDKey forIndexPath:indexPath];

    cell.theLabel.text = self.dataItems[indexPath.row];
    cell.contentView.backgroundColor = LightRandomColor;

    return cell;
}

@end
