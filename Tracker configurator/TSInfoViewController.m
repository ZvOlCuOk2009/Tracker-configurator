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
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TSInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    self.titleImageView.frame = kLogoFrame;
    self.navigationItem.titleView = self.titleImageView;
    
    self.textView.text = [NSString infoText];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
