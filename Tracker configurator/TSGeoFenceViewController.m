
//
//  TSGeo-fenceViewController.m
//  Tracker configurator
//
//  Created by Mac on 20.12.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSGeoFenceViewController.h"
#import "TSTrackerConfigurationPrefixHeader.pch"

@interface TSGeoFenceViewController ()

@property(strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldOutletCollection;
@property (strong, nonatomic) IBOutletCollection(UIPickerView) NSArray *pickerViewOutletCollection;

@end

@implementation TSGeoFenceViewController

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
    
    for (UIPickerView *pickerView in self.pickerViewOutletCollection) {
        pickerView.layer.borderColor = [BLUE_COLOR CGColor];
    }
    
    [self.navigationItem.backBarButtonItem setTitle:@" "];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
