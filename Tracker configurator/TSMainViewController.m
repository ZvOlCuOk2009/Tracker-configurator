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
#import "TSPostingMessagesManager.h"
#import "NSString+TSString.h"
#import "TSTrackerConfigurationPrefixHeader.pch"

@interface TSMainViewController () 

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldOutletCollection;
@property (strong, nonatomic) IBOutletCollection(UIPickerView) NSArray *pickerViewOutletCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonOutletCollection;

@property (weak, nonatomic) IBOutlet UIPickerView *timeZonePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *trackIntervalPickerView;

@property (weak, nonatomic) IBOutlet UISwitch *switchTransmissionData;
@property (weak, nonatomic) IBOutlet UISwitch *switchMove;
@property (weak, nonatomic) IBOutlet UISwitch *switchTime;
@property (weak, nonatomic) IBOutlet UISwitch *switchShock;
@property (weak, nonatomic) IBOutlet UISwitch *switchMovAlarm;
@property (weak, nonatomic) IBOutlet UISwitch *switchOverspAlarm;
@property (weak, nonatomic) IBOutlet UITextField *textFieldOvSpeedAlarm;

@property (strong, nonatomic) NSMutableArray *dataSourceTimeZone;
@property (strong, nonatomic) NSMutableArray *dataSourceTrackInterval;

@property (strong, nonatomic) NSUserDefaults *userDefaults;

@property (assign, nonatomic) NSInteger curentTag;
@property (assign, nonatomic) BOOL mode;

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


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    NSString *nameDevice = [self.userDefaults objectForKey:@"nameDevice"];
//    [self.deviceButton setTitle:nameDevice forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification object:nil];
    
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
    
    self.dataSourceTimeZone = [NSMutableArray array];
    self.dataSourceTrackInterval = [NSMutableArray array];
    
    
    for (int i = - 12; i < 12; i++) {
        NSString *zoneString = [NSString stringWithFormat:@"%d", i];
        [self.dataSourceTimeZone addObject:zoneString];
    }
    
    for (int i = 10; i < 180; i++) {
        NSString *intervalString = [NSString stringWithFormat:@"%d", i];
        [self.dataSourceTrackInterval addObject:intervalString];
    }
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];

    NSInteger counter = [self.userDefaults integerForKey:@"counter"];
    if (counter == 0) {
        
        NSString *defaultPin = @"123456";
        NSString *nameDevice = @"11912";
        [self.userDefaults setObject:defaultPin forKey:@"pin"];
        [self.userDefaults setObject:nameDevice forKey:@"nameDevice"];
        [self.userDefaults setInteger:1 forKey:@"counter"];
        [self.userDefaults synchronize];
    }
    
}


#pragma mark - Actions


- (IBAction)sharedAction:(UIButton *)sender
{
    self.curentTag = sender.tag;
    [self callContactPickerViewController];
    NSLog(@"curentTag %ld", (long)self.curentTag);
}


- (IBAction)trackerAction:(UIButton *)sender
{
    [sender setBackgroundImage:self.point forState:UIControlStateNormal];
    
    UIButton *monitorButton = [self.buttonOutletCollection lastObject];
    [monitorButton setBackgroundImage:self.background forState:UIControlStateNormal];
    
    self.mode = YES;
}


- (IBAction)monitorAction:(UIButton *)sender
{
    [sender setBackgroundImage:self.point forState:UIControlStateNormal];
    
    UIButton *trackerButton = [self.buttonOutletCollection firstObject];
    [trackerButton setBackgroundImage:self.background forState:UIControlStateNormal];
    
    self.mode = NO;
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


- (void)callContactPickerViewController
{
    self.contactPicker = [[CNContactPickerViewController alloc] init];
    self.contactPicker.delegate = self;
    
    [self presentViewController:self.contactPicker animated:YES completion:nil];
}


#pragma mark - UIPickerViewDataSource


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    
    switch (thePickerView.tag) {
        case 1:
            return self.dataSourceTimeZone.count;
            break;
        case 2:
            return self.dataSourceTrackInterval.count;
            break;
        default:
            return 0;
            break;
    }
    
}


- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    switch (thePickerView.tag) {
        case 1:
            return [self.dataSourceTimeZone objectAtIndex:row];
            break;
        case 2:
            return [self.dataSourceTrackInterval objectAtIndex:row];
            break;
        default:
            return 0;
            break;
    }
}


#pragma mark - UIPickerViewDelegate


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}


#pragma mark - CNContactPickerDelegate


- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    
    NSArray *phoneNumbers = [contact phoneNumbers];
    CNLabeledValue *number = [phoneNumbers objectAtIndex:0];
    NSString *numberPhone = [[number value] stringValue];
    self.recipient = @[numberPhone];
    
    [self sendMessage:self.recipient];
    
}


#pragma mark - MFMessageComposeViewController


- (void)sendMessage:(NSArray *)recipients
{
    
    MFMessageComposeViewController *messageComposeViewController = [[TSPostingMessagesManager sharedManager] messageComposeViewController:recipients bodyMessage:[self configureComand]];
    messageComposeViewController.messageComposeDelegate = self;
    
    
    [self dismissViewControllerAnimated:NO completion:nil];
    [self presentViewController:messageComposeViewController animated:YES completion:nil];
    
}


- (NSString *)configureComand
{
    
    NSString *currentComand = nil; 
    
    switch (self.curentTag) {
        case 1:
            currentComand = [NSString whereComand];
            break;
        case 2:
            currentComand = [NSString adminPhoneComand:[[self.textFieldOutletCollection objectAtIndex:0] text]];
            break;
        case 3:
            currentComand = [NSString apnComand:[[self.textFieldOutletCollection objectAtIndex:1] text]];
            break;
        case 4:
            currentComand = [NSString adminipComand:[[self.textFieldOutletCollection objectAtIndex:2] text]
                                               port:[[self.textFieldOutletCollection objectAtIndex:3] text]];
            break;
        case 5:
            currentComand = [NSString timeZoneComand:[self pickerView:self.timeZonePickerView
                                                          titleForRow:[self.timeZonePickerView selectedRowInComponent:0]
                                                         forComponent:0]];
            break;
        case 6:
            currentComand = [NSString gprsComand:[self.switchTransmissionData isOn]];
            break;
        case 7:
            currentComand = [NSString moveComand:[self.switchMove isOn]];
            break;
        case 8:
            currentComand = [NSString timeComand:[self.switchTime isOn]];
            break;
        case 9:
            currentComand = [NSString shockComand:[self.switchShock isOn]];
            break;
        case 10:
            currentComand = [NSString trackingIntervalComand:[self pickerView:self.trackIntervalPickerView
                                                                  titleForRow:[self.trackIntervalPickerView selectedRowInComponent:0]
                                                                 forComponent:0]];
            break;
        case 11:
            currentComand = [NSString modeComand:self.mode];
            break;
        case 12:
            currentComand = [NSString moveAlarmComand:[self.switchMovAlarm isOn]];
            break;
        case 13:
            currentComand = [NSString overspeedAlarmComand:[self.switchOverspAlarm isOn]
                                                       kmh:self.textFieldOvSpeedAlarm.text];
            break;
        case 14:
            currentComand = [NSString statusComand];
            break;
        case 15:
            currentComand = [NSString parametersComand];
            break;
        case 16:
            currentComand = [NSString configurationComand];
            break;
            
        default:
            break;
    }
    
    return currentComand;
    
}


#pragma mark - MFMessageComposeViewControllerDelegate


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    if (result == MessageComposeResultCancelled) {
        NSLog(@"Message cancelled");
    } else if (result == MessageComposeResultSent) {
        NSLog(@"Message sent");
    } else {
        NSLog(@"Message failed");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITextFieldDelegate


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    UITextField *textFieldAdminPhone = [self.textFieldOutletCollection firstObject];
    UITextField *textFieldServerPort = [self.textFieldOutletCollection objectAtIndex:2];
    
    if ([textField isEqual:textFieldAdminPhone]) {

        NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }
        
        NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSArray* validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
        
        newString = [validComponents componentsJoinedByString:@""];
        
        static const int localNumberMaxLength = 7;
        static const int areaCodeMaxLength = 3;
        static const int countryCodeMaxLength = 2;
        
        if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
            return NO;
        }
        
        
        NSMutableString* resultString = [NSMutableString string];
        
        
        NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
        
        
        if (localNumberLength > 0) {
            
            NSString* number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
            
            [resultString appendString:number];
            
        }
        
        if ([newString length] > localNumberMaxLength) {
            
            NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
            
            NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
            
            NSString* area = [newString substringWithRange:areaRange];
            
            [resultString insertString:area atIndex:0];
        }
        
        
        if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
            
            NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
            
            NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
            
            NSString *countryCode = [newString substringWithRange:countryCodeRange];
            
            countryCode = [NSString stringWithFormat:@"+%@", countryCode];
            
            [resultString insertString:countryCode atIndex:0];
        }
        
        
        textField.text = resultString;
        
        return NO;
    }
    
    static const int serverNameMaxLength = 15;
    
    if ([textField isEqual:textFieldServerPort]) {
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSMutableString *formatingString = [NSMutableString stringWithString:newString];
        
        NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }
        
        if ([formatingString length] > 2) {
            [formatingString insertString:@"." atIndex:3];
        }
        
        if ([formatingString length] > 6) {
            [formatingString insertString:@"." atIndex:7];
        }
        
        if ([formatingString length] > 10) {
            [formatingString insertString:@"." atIndex:11];
        }
        
        if ([formatingString length] > serverNameMaxLength) {
            return NO;
        }
        
        NSLog(@"newString %@", formatingString);
    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Keyboard notification


- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.view.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.view.frame.origin.y - kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
    
}


- (void)keyboardDidHide:(NSNotification *)notification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
