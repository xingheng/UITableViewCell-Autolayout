//
//  Table3ViewController.m
//  TableCell-Autolayout
//
//  Created by WeiHan on 17/10/2017.
//  Copyright © 2017 WillHan. All rights reserved.
//

#import "Table3ViewController.h"

extern NSString * GetRandomString(NSUInteger length);

UIImage *GetImageWithColor(UIColor *color, CGFloat width, CGFloat height)
{
    CGRect rect = CGRectMake(0.0f, 0.0f, width, height);

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

#pragma mark - MultipleLineLableWithLocalImageCell

@interface MultipleLineLableWithLocalImageCell : UITableViewCell

@property (nonatomic, strong) UILabel *theLabel;
@property (nonatomic, strong) UIImageView *theImageView;

@end

@implementation MultipleLineLableWithLocalImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [UILabel new];
        UIImageView *imageView = [UIImageView new];
        self.theLabel = label;
        self.theImageView = imageView;

        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:18];

        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;

        [self.contentView addSubview:label];
        [self.contentView addSubview:imageView];

        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.top);
            make.centerX.width.equalTo(self.contentView);
            make.bottom.equalTo(imageView.top);
        }];

        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.bottom);
            make.bottom.equalTo(self.contentView.bottom);
            make.centerX.width.equalTo(self.contentView);
        }];
    }

    return self;
}

@end


#pragma mark - Table3ViewController

#define kCellIDKey @"MultipleLineLableWithLocalImageCell"

@interface Table3ViewController ()

@property (nonatomic, strong) NSArray<NSString *> *dataItems;

@end

@implementation Table3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[MultipleLineLableWithLocalImageCell class] forCellReuseIdentifier:kCellIDKey];
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
    MultipleLineLableWithLocalImageCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIDKey forIndexPath:indexPath];

    NSInteger height = arc4random_uniform(50) * 2 + 50;
    cell.theLabel.text = [NSString stringWithFormat:@"%@\n\nImage height:%ld", self.dataItems[indexPath.row], height];
    cell.theLabel.backgroundColor = RGBA(30, 30, 30, 0.2);

    UIColor *color = LightRandomColor;
    cell.theImageView.image = GetImageWithColor(color, CGRectGetWidth(tableView.frame), height);
    cell.contentView.backgroundColor = color;

    return cell;
}

@end
