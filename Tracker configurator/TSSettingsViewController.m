//
//  TSSettingsViewController.m
//  Tracker configurator
//
//  Created by Mac on 20.12.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSSettingsViewController.h"
#import "TSInfoViewController.h"
#import "TSTrackerConfigurationPrefixHeader.pch"

@interface TSSettingsViewController ()

@property(strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldOutletCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonOutletCollection;

@end

@implementation TSSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureController];
    
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (IS_IPHONE_4) {
        self.scrollView.frame = CGRectMake(0, 0, 320, 480);
        self.scrollView.contentSize = CGSizeMake(320, 568);
    } else if (IS_IPHONE_5) {
        self.scrollView.frame = CGRectMake(0, 0, 320, 568);
        self.scrollView.contentSize = CGSizeMake(320, 568);
    } else if (IS_IPHONE_6) {
        self.scrollView.frame = CGRectMake(0, 0, 375, 667);
    } else if (IS_IPHONE_6_PLUS) {
        self.scrollView.frame = CGRectMake(0, 0, 414, 736);
        self.scrollView.contentSize = CGSizeMake(414, 1320);
    }
}


- (void)configureController
{
    
    for (UITextField *textField in self.textFieldOutletCollection) {
        textField.layer.borderColor = [BLUE_COLOR CGColor];
    }
    
    for (UIButton *button in self.buttonOutletCollection) {
        button.layer.borderColor = [BLUE_COLOR CGColor];
    }
    
    [self.navigationItem.backBarButtonItem setTitle:@" "];
    
    UIBarButtonItem *infoButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Info"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(actionInfoButton)];
    
    self.navigationItem.rightBarButtonItem = infoButton;
    
    self.point = [UIImage imageNamed:@"point"];
    self.background = [UIImage imageNamed:@"backButton"];
}


#pragma mark - Actions


- (IBAction)smsAction:(UIButton *)sender
{
    [sender setBackgroundImage:self.point forState:UIControlStateNormal];
    
    UIButton *callButton = [self.buttonOutletCollection lastObject];
    [callButton setBackgroundImage:self.background forState:UIControlStateNormal];
}


- (IBAction)callAction:(UIButton *)sender
{
    
    [sender setBackgroundImage:self.point forState:UIControlStateNormal];
    
    UIButton *smsButton = [self.buttonOutletCollection firstObject];
    [smsButton setBackgroundImage:self.background forState:UIControlStateNormal];
}


- (void)actionInfoButton
{
    TSInfoViewController *settingsViewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"TSInfoViewController"];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
