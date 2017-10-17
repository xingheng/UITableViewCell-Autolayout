//
//  SettingViewController.m
//  TableCell-Autolayout
//
//  Created by WeiHan on 17/10/2017.
//  Copyright © 2017 WillHan. All rights reserved.
//

#import "SettingViewController.h"
#import "UIControl+BlockAction.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = RGB(240, 240, 240);

    UIStackView *stackview = [UIStackView new];
    UIButton *button = nil;

#define AddButtonToStackView(__title__, __expr__)              \
button = [UIButton buttonWithType:UIButtonTypeSystem];     \
[button setTitle:__title__ forState:UIControlStateNormal]; \
[button addEventBlock:^(id sender) {                       \
__expr__                                               \
}                                                          \
forControlEvents:UIControlEventTouchUpInside];        \
[stackview addArrangedSubview:button]

    AddButtonToStackView(@"Clear local cache of SDWebImage", {
        SDImageCache *imageCache = [SDImageCache sharedImageCache];

        [imageCache clearMemory];
        [imageCache clearDiskOnCompletion: ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Done!"
                                                                           message:nil
                                                                    preferredStyle:UIAlertControllerStyleAlert];

            [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                      style:UIAlertActionStyleDefault
                                                    handler:nil]];
            [self presentViewController:alert
                               animated:YES
                             completion:nil];
        }];
    });

    AddButtonToStackView(@"Dismiss", {
        [self dismissViewControllerAnimated:YES completion:nil];
    });

    AddButtonToStackView(@"About", {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Author: WeiHan" message:@"https://github.com/xingheng" preferredStyle:UIAlertControllerStyleAlert];

        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    });

    stackview.axis = UILayoutConstraintAxisVertical;
    stackview.distribution = UIStackViewDistributionFillEqually;

    [self.view addSubview:stackview];

    [stackview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).inset(20);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
