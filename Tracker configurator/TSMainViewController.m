//
//  TSMainViewController.m
//  Tracker configurator
//
//  Created by Mac on 20.12.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSMainViewController.h"
#import "TSGeoFenceViewController.h"
#import "TSSettingsViewController.h"
#import "TSTrackerConfigurationPrefixHeader.pch"

@interface TSMainViewController ()

@property(strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldOutletCollection;
@property (strong, nonatomic) IBOutletCollection(UIPickerView) NSArray *pickerViewOutletCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonOutletCollection;

@end

@implementation TSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureController];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (IS_IPHONE_4) {
        self.scrollView.frame = CGRectMake(0, 0, 320, 480);
        self.scrollView.contentSize = CGSizeMake(320, 1320);
    } else if (IS_IPHONE_5) {
        self.scrollView.frame = CGRectMake(0, 0, 320, 568);
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
    
    for (UIPickerView *pickerView in self.pickerViewOutletCollection) {
        pickerView.layer.borderColor = [BLUE_COLOR CGColor];
    }
    
    for (UIButton *button in self.buttonOutletCollection) {
        button.layer.borderColor = [BLUE_COLOR CGColor];
    }

    self.point = [UIImage imageNamed:@"point"];
    self.background = [UIImage imageNamed:@"backButton"];
}


#pragma mark - Actions


- (IBAction)trackerAction:(UIButton *)sender
{
    [sender setBackgroundImage:self.point forState:UIControlStateNormal];
    
    UIButton *monitorButton = [self.buttonOutletCollection lastObject];
    [monitorButton setBackgroundImage:self.background forState:UIControlStateNormal];
}


- (IBAction)monitorAction:(UIButton *)sender
{
    
    [sender setBackgroundImage:self.point forState:UIControlStateNormal];
    
    UIButton *trackerButton = [self.buttonOutletCollection firstObject];
    [trackerButton setBackgroundImage:self.background forState:UIControlStateNormal];
}


- (IBAction)menuButtonAction:(id)sender
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Menu"
                                                                             message:@""
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAtionGeoFence = [UIAlertAction actionWithTitle:@"Geo-fence"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   
    TSGeoFenceViewController *geoFenceViewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"TSGeoFenceViewController"];
    [self.navigationController pushViewController:geoFenceViewController animated:YES];
                                                                   
                                                               }];
    
    UIAlertAction *alertAtionSettings = [UIAlertAction actionWithTitle:@"Settings"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   
    TSSettingsViewController *settingsViewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"TSSettingsViewController"];
    [self.navigationController pushViewController:settingsViewController animated:YES];
                                                                   
                                                               }];
    
    UIAlertAction *alertAtionCancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   
                                                                   
                                                               }];
    
    [alertController addAction:alertAtionGeoFence];
    [alertController addAction:alertAtionSettings];
    [alertController addAction:alertAtionCancel];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
