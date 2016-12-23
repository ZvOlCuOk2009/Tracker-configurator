//
//  TSInfoViewController.m
//  Tracker configurator
//
//  Created by Mac on 22.12.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSInfoViewController.h"
#import "NSString+TSString.h"
#import "TSTrackerConfigurationPrefixHeader.pch"

@interface TSInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property(strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation TSInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoLabel.text = [NSString infoText];
    [self.infoLabel sizeToFit];

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (IS_IPHONE_4) {
        self.scrollView.frame = CGRectMake(0, 0, 320, 480);
        self.scrollView.contentSize = CGSizeMake(320, 3500);
    } else if (IS_IPHONE_5) {
        self.scrollView.frame = CGRectMake(0, 0, 320, 568);
        self.scrollView.contentSize = CGSizeMake(320, 3500);
    } else if (IS_IPHONE_6) {
        self.scrollView.frame = CGRectMake(0, 0, 375, 667);
        self.scrollView.contentSize = CGSizeMake(375, 3500);
    } else if (IS_IPHONE_6_PLUS) {
        self.scrollView.frame = CGRectMake(0, 0, 414, 736);
        self.scrollView.contentSize = CGSizeMake(414, 3500);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
