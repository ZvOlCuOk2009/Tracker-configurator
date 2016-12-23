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
#import "TSPermisionContacts.h"
#import "NSString+TSString.h"
#import "TSTrackerConfigurationPrefixHeader.pch"

#import <AddressBookUI/AddressBookUI.h>

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

@property (weak, nonatomic) IBOutlet UILabel *getLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *setAdminPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *setApnLabel;
@property (weak, nonatomic) IBOutlet UILabel *setServerAndPortLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeZoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTransDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *addSettingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *sleepModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shockLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackingIntervalLabel;
@property (weak, nonatomic) IBOutlet UILabel *modeLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackerLabel;
@property (weak, nonatomic) IBOutlet UILabel *monitorLabel;
@property (weak, nonatomic) IBOutlet UILabel *movementAlarmLabel;
@property (weak, nonatomic) IBOutlet UILabel *overspeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *chackSettingLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *parametersLabel;
@property (weak, nonatomic) IBOutlet UILabel *configurationLabel;

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
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (IS_IPHONE_4) {
            self.scrollView.frame = kScrollViewFrameIphone4;
            self.scrollView.contentSize = kMainScrollViewcontentSizeIphone4;
        } else if (IS_IPHONE_5) {
            self.scrollView.frame = kScrollViewFrameIphone5;
            self.scrollView.contentSize = kMainScrollViewcontentSizeIphone5;
        } else if (IS_IPHONE_6) {
            self.scrollView.frame = kScrollViewFrameIphone6;
            self.scrollView.contentSize = kMainScrollViewcontentSizeIphone6;
        } else if (IS_IPHONE_6_PLUS) {
            self.scrollView.frame = kScrollViewFrameIphone6plus;
            self.scrollView.contentSize = kMainScrollViewcontentSizeIphone6plus;
        }
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (IS_IPAD_2) {
            self.scrollView.frame = kScrollViewFrameIpad2;
            self.scrollView.contentSize = kMainScrollViewcontentSizeIpad2;
        } else if (IS_IPAD_AIR) {
            self.scrollView.frame = kScrollViewFrameIpadAir;
            self.scrollView.contentSize = kScrollViewcontentSizeIpadAir;
        } else if (IS_IPAD_PRO) {
            self.scrollView.frame = kScrollViewFrameIpadPro;
            self.scrollView.contentSize = kScrollViewcontentSizeIpadPro;
        }
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification object:nil];
    
    UITextField *internetTextField = [self.textFieldOutletCollection objectAtIndex:1];
    UITextField *serverTextField = [self.textFieldOutletCollection objectAtIndex:2];
    UITextField *portTextField = [self.textFieldOutletCollection objectAtIndex:3];
    
    internetTextField.placeholder = [self.userDefaults objectForKey:@"internet"];
    serverTextField.placeholder = [self.userDefaults objectForKey:@"server"];
    portTextField.placeholder = [self.userDefaults objectForKey:@"port"];
    
    [self setLaunguage];
}


- (void)configureController
{
    
    self.titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    self.titleImageView.frame = kLogoFrame;
    self.navigationItem.titleView = self.titleImageView;
    
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
    
    
    for (int i = - 12; i < 13; i++) {
        
        NSString *zoneString = nil;
        
        if (i > 0) {
            zoneString = [NSString stringWithFormat:@"+%d", i];
        } else {
            zoneString = [NSString stringWithFormat:@"%d", i];
        }
        
        [self.dataSourceTimeZone addObject:zoneString];
    }
    
    UIPickerView *timeZonePickerView = [self.pickerViewOutletCollection firstObject];
    [timeZonePickerView selectRow:12 inComponent:0 animated:NO];
    
    for (int i = 10; i < 180; i++) {
        NSString *intervalString = [NSString stringWithFormat:@"%d", i];
        [self.dataSourceTrackInterval addObject:intervalString];
    }
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];

    NSInteger counter = [self.userDefaults integerForKey:@"counter"];
    if (counter == 0) {
        
        NSString *defaultPin = @"123456";
        NSString *defaultApn = @"internet";
        NSString *defaultServer = @"94.229.67.27";
        NSString *defaultPort = @"11912";
        
        [self.userDefaults setObject:defaultPin forKey:@"pin"];
        [self.userDefaults setObject:defaultApn forKey:@"internet"];
        [self.userDefaults setObject:defaultServer forKey:@"server"];
        [self.userDefaults setObject:defaultPort forKey:@"port"];
        
        [self.userDefaults setInteger:1 forKey:@"counter"];
        [self.userDefaults synchronize];
    }
    
    UIButton *trackerButton = [self.buttonOutletCollection firstObject];
    [trackerButton setBackgroundImage:self.point forState:UIControlStateNormal];
    
    [self edgesForExtendedLayout];
}


- (void)edgesForExtendedLayout
{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.translucent = NO;
}


#pragma mark - Actions


- (IBAction)sharedAction:(UIButton *)sender
{
    NSInteger permission = [[TSPermisionContacts sharedPermission] userPermissionToAccessYourContacts];
    
    if (permission == 1)
    {
        self.curentTag = sender.tag;
        [self callContactPickerViewController];
    }
    
}


- (IBAction)trackerAction:(UIButton *)sender
{
    [sender setBackgroundImage:self.point forState:UIControlStateNormal];
    
    UIButton *monitorButton = [self.buttonOutletCollection lastObject];
    [monitorButton setBackgroundImage:self.background forState:UIControlStateNormal];
    
    self.mode = NO;
}


- (IBAction)monitorAction:(UIButton *)sender
{
    [sender setBackgroundImage:self.point forState:UIControlStateNormal];
    
    UIButton *trackerButton = [self.buttonOutletCollection firstObject];
    [trackerButton setBackgroundImage:self.background forState:UIControlStateNormal];
    
    self.mode = YES;
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
    return kHeightRowComponent;
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

        NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
        
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
        
        NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }
        
        if ([formatingString length] > serverNameMaxLength) {
            return NO;
        }

        NSString *convertString = nil;
        
        if ((range.location == 3) || (range.location == 7) || (range.location == 11)) {
            
            convertString = [NSString stringWithFormat:@"%@.", textField.text];
            
            textField.text = convertString;
        }
                
        return YES;
        
    }
    
    static const int ovSpeedAlarmMaxLength = 3;
    
    if ([textField isEqual:self.textFieldOvSpeedAlarm]) {
        
        NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if ([newString length] > ovSpeedAlarmMaxLength) {
            return NO;
        }
    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - set launguage

- (void)setLaunguage
{
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
    
    if ([language isEqualToString:@"English"]) {
        
        [self setEngleshLaunguage];
        
    } else if ([language isEqualToString:@"German"]) {
        
        [self setGermanLaunguage];
    }
}


- (void)setEngleshLaunguage
{
    [self.getLocationLabel setText:@"Get location"];
    [self.setAdminPhoneLabel setText:@"Set admin phone"];
    [self.setApnLabel setText:@"Set APN"];
    [self.setServerAndPortLabel setText:@"Server&port"];
    [self.timeZoneLabel setText:@"Timezone"];
    [self.startTransDataLabel setText:@"Start transmission data"];
    [self.addSettingsLabel setText:@"Additional settings"];
    [self.sleepModeLabel setText:@"Sleep mode"];
    [self.movieLabel setText:@"Move"];
    [self.timeLabel setText:@"Time"];
    [self.shockLabel setText:@"Shock"];
    [self.trackingIntervalLabel setText:@"Tracking interval"];
    [self.modeLabel setText:@"Mode"];
    [self.trackerLabel setText:@"Tracker"];
    [self.monitorLabel setText:@"Monitor"];
    [self.movementAlarmLabel setText:@"Movement alarm"];
    [self.overspeedLabel setText:@"Overspeed alarm"];
    [self.chackSettingLabel setText:@"Check settings"];
    [self.statusLabel setText:@"Status"];
    [self.parametersLabel setText:@"Parameters"];
    [self.configurationLabel setText:@"Configuration"];
}


- (void)setGermanLaunguage
{
    [self.getLocationLabel setText:@"Erhalten Sie Position"];
    [self.setAdminPhoneLabel setText:@"Admin-Telefon einstellen"];
    [self.setApnLabel setText:@"Setze APN"];
    [self.setServerAndPortLabel setText:@"Server&port"];
    [self.timeZoneLabel setText:@"Zeitzone"];
    [self.startTransDataLabel setText:@"Starten Übertragungsdaten"];
    [self.addSettingsLabel setText:@"Zusätzliche Einstellungen"];
    [self.sleepModeLabel setText:@"Schlafmodus"];
    [self.movieLabel setText:@"Bewegung"];
    [self.timeLabel setText:@"Zeit"];
    [self.shockLabel setText:@"Schlag"];
    [self.trackingIntervalLabel setText:@"Tracking-Intervall"];
    [self.modeLabel setText:@"Modus"];
    [self.trackerLabel setText:@"Tracker"];
    [self.monitorLabel setText:@"Monitor"];
    [self.movementAlarmLabel setText:@"Bewegungsalarm"];
    [self.overspeedLabel setText:@"Überdrehzahl"];
    [self.chackSettingLabel setText:@"Einstellungen überprüfen"];
    [self.statusLabel setText:@"Status"];
    [self.parametersLabel setText:@"Parameter"];
    [self.configurationLabel setText:@"Konfiguration"];
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
