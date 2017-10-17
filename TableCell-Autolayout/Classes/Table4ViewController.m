//
//  Table4ViewController.m
//  TableCell-Autolayout
//
//  Created by WeiHan on 17/10/2017.
//  Copyright © 2017 WillHan. All rights reserved.
//

#import "Table4ViewController.h"
#import "UIImageView+WebCache.h"

extern NSString * GetRandomString(NSUInteger length);

extern UIImage * GetImageWithColor(UIColor *color, CGFloat width, CGFloat height);

#pragma mark - MultipleLineLableWithNetworkImageCell

@interface MultipleLineLableWithNetworkImageCell : UITableViewCell

@property (nonatomic, strong) UILabel *theLabel;
@property (nonatomic, strong) UIImageView *theImageView;

@end

@implementation MultipleLineLableWithNetworkImageCell

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
            make.height.greaterThanOrEqualTo(@16);
        }];

        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.bottom);
            make.bottom.equalTo(self.contentView.bottom);
            make.centerX.width.equalTo(self.contentView);
            make.height.lessThanOrEqualTo(@200);
        }];
    }

    return self;
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)updateConstraints
{
    __unused UILabel *label = self.theLabel;
    __unused UIImageView *imageView = self.theImageView;

    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end


#pragma mark - Table4ViewController

#define kCellIDKey @"MultipleLineLableWithNetworkImageCell"

@interface Table4ViewController ()

@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *dataItems;

@end

@implementation Table4ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[MultipleLineLableWithNetworkImageCell class] forCellReuseIdentifier:kCellIDKey];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray<NSDictionary<NSString *, NSString *> *> *)dataItems
{
    if (!_dataItems) {
        NSMutableArray<NSDictionary<NSString *, NSString *> *> *array = [NSMutableArray new];

        // From http://imageshack.us/discover
        static NSArray *allImages = nil;

        if (!allImages) {
            allImages = @[@"http://imageshack.com/a/img743/382/Npsx4h.jpg",
                          @"http://imageshack.com/a/img540/7545/KQQN7U.jpg",
                          @"http://imageshack.com/a/img901/2240/KyWfgS.jpg",
                          @"http://imageshack.com/a/img903/1976/q5d7va.jpg",
                          @"http://imageshack.com/a/img661/6285/rCO0Ui.jpg",
                          @"http://imageshack.com/a/img661/4020/Nt07gm.jpg",
                          @"http://imageshack.com/a/img903/962/F6zEY5.jpg",
                          @"http://imageshack.com/a/img538/9889/xlMaV6.jpg",
                          @"http://imageshack.com/a/img538/4467/DpYdlq.jpg",
                          @"http://imageshack.com/a/img538/3316/n2zNjE.jpg",
                          @"http://imageshack.com/a/img538/6941/ATDxcC.jpg",
                          @"http://imageshack.com/a/img673/4539/Oa4R2C.jpg",
                          @"http://imageshack.com/a/img911/4058/6skK16.jpg",
                          @"http://imageshack.com/a/img537/949/xAgiLR.jpg",
                          @"http://imageshack.com/a/img904/2959/GkOKnP.jpg",
                          @"http://imageshack.com/a/img674/1857/Y5nXts.jpg",
                          @"http://imageshack.com/a/img538/9536/leHVhq.jpg",
                          ];
        }

        for (NSUInteger i = 1; i < 100; i++) {
            NSString *strText = GetRandomString(i);
            NSString *strImageURL = allImages[i % allImages.count];

            [array insertObject:@{ strText: strImageURL } atIndex:arc4random_uniform((int)array.count)];
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
    MultipleLineLableWithNetworkImageCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIDKey forIndexPath:indexPath];
    NSDictionary *dict = self.dataItems[indexPath.row];

    cell.theLabel.text = dict.allKeys.firstObject;
    cell.theLabel.backgroundColor = RGBA(30, 30, 30, 0.2);
    cell.contentView.backgroundColor = LightRandomColor;

    __weak __typeof(cell) weakCell = cell;

    [cell.theImageView sd_setImageWithURL:[NSURL URLWithString:dict.allValues.firstObject]
                         placeholderImage:nil//GetImageWithColor(DarkRandomColor, CGRectGetWidth(tableView.frame), 400)
                                  options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached // disable the local disk cache explictly
                                completed:^(UIImage *_Nullable image, NSError *_Nullable error, SDImageCacheType cacheType, NSURL *_Nullable imageURL) {
                                    __strong __typeof(cell) strongCell = weakCell;

                                    [strongCell setNeedsUpdateConstraints];
                                    [strongCell updateConstraintsIfNeeded];
                                }];

    return cell;
}

@end
