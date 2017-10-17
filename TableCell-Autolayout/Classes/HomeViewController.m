//
//  HomeViewController.m
//  TableCell-Autolayout
//
//  Created by WeiHan on 16/10/2017.
//  Copyright © 2017 WillHan. All rights reserved.
//

#import "HomeViewController.h"
#import "UIControl+BlockAction.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIStackView *stackview = [UIStackView new];
    UIButton *button = nil;

#define AddButtonToStackView(__title__, __vc_class__)          \
button = [UIButton buttonWithType:UIButtonTypeSystem];     \
[button setTitle:__title__ forState:UIControlStateNormal]; \
[button addEventBlock:^(id sender) {                       \
Class vccls = NSClassFromString(__vc_class__);         \
id obj = [vccls new];                                  \
[self presentViewController:obj                        \
animated:YES                        \
completion:nil];                      \
}                                                          \
forControlEvents:UIControlEventTouchUpInside];        \
[stackview addArrangedSubview:button]

    AddButtonToStackView(@"A single multiple line label", @"Table1ViewController");
    AddButtonToStackView(@"A multiple line label with a button", @"Table2ViewController");
    AddButtonToStackView(@"A multiple line label with a local image", @"Table3ViewController");
    AddButtonToStackView(@"A multiple line label with a network image", @"Table4ViewController");
    AddButtonToStackView(@"Settings", @"SettingViewController");

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
