//
//  TSSettingsViewController.m
//  Tracker configurator
//
//  Created by Mac on 20.12.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSSettingsViewController.h"
#import "TSInfoViewController.h"
#import "TSPostingMessagesManager.h"
#import "TSPermisionContacts.h"
#import "NSString+TSString.h"
#import "TSTrackerConfigurationPrefixHeader.pch"

#import <AddressBookUI/AddressBookUI.h>

@interface TSSettingsViewController ()

@property(strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldsOutletCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonOutletCollection;

@property (weak, nonatomic) IBOutlet UIPickerView *launguagePickerView;

@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) NSString *launguage;

@property (weak, nonatomic) IBOutlet UILabel *launguageLabel;
@property (weak, nonatomic) IBOutlet UILabel *sosNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *smsLabel;
@property (weak, nonatomic) IBOutlet UILabel *callLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *resetSettingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *restoreFactoreSettingsLabel;

@property (assign, nonatomic) BOOL mode;

@end

@implementation TSSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.launguage = [userDefaults objectForKey:@"language"];
    NSInteger row;
    if ([self.launguage isEqualToString:@"English"]) {
        row = 0;
    } else if ([self.launguage isEqualToString:@"German"]) {
        row = 1;
    }
    
    [self.launguagePickerView selectRow:row inComponent:0 animated:NO];
    
    UITextField *pinTextField = [self.textFieldsOutletCollection objectAtIndex:1];
    NSString *pin = [userDefaults objectForKey:@"pin"];
    pinTextField.placeholder = pin;

    [self setLaunguage];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (IS_IPHONE_4) {
            self.scrollView.frame = kScrollViewFrameIphone4;
            self.scrollView.contentSize = kSettingsScrollViewcontentSizeIphone4;
        } else if (IS_IPHONE_5) {
            self.scrollView.frame = kScrollViewFrameIphone5;
            self.scrollView.contentSize = kSettingsScrollViewcontentSizeIphone5;
        } else if (IS_IPHONE_6) {
            self.scrollView.frame = kScrollViewFrameIphone6;
            self.scrollView.contentSize = kSettingsScrollViewcontentSizeIphone6;
        } else if (IS_IPHONE_6_PLUS) {
            self.scrollView.frame = kScrollViewFrameIphone6plus;
            self.scrollView.contentSize = kSettingsScrollViewcontentSizeIphone6plus;
        }
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (IS_IPAD_2) {
            self.scrollView.frame = kScrollViewFrameIpad2;
            self.scrollView.contentSize = kSettingsScrollViewcontentSizeIpad2;
        } else if (IS_IPAD_AIR) {
            self.scrollView.frame = kScrollViewFrameIpadAir;
            self.scrollView.contentSize = kScrollViewcontentSizeIpadAir;
        } else if (IS_IPAD_PRO) {
            self.scrollView.frame = kScrollViewFrameIpadPro;
            self.scrollView.contentSize = kScrollViewcontentSizeIpadPro;
        }
    }
}


- (void)configureController
{
    
    self.titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    self.titleImageView.frame = kLogoFrame;
    self.navigationItem.titleView = self.titleImageView;
    
    for (UITextField *textField in self.textFieldsOutletCollection) {
        textField.layer.borderColor = [BLUE_COLOR CGColor];
    }
    
    for (UIButton *button in self.buttonOutletCollection) {
        button.layer.borderColor = [BLUE_COLOR CGColor];
    }
    
    self.launguagePickerView.layer.borderColor = [BLUE_COLOR CGColor];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:self.navigationItem.backBarButtonItem.style
                                                                            target:nil
                                                                            action:nil];
    
    UIBarButtonItem *infoButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Info"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(actionInfoButton)];
    
    self.navigationItem.rightBarButtonItem = infoButton;
    
    self.point = [UIImage imageNamed:@"point"];
    self.background = [UIImage imageNamed:@"backButton"];
    
    self.dataSource = @[@"English", @"German"];
    
    UIButton *smsButton = [self.buttonOutletCollection firstObject];
    [smsButton setBackgroundImage:self.point forState:UIControlStateNormal];
    
    [self edgesForExtendedLayout];
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



- (IBAction)smsAction:(UIButton *)sender
{
    [sender setBackgroundImage:self.point forState:UIControlStateNormal];
    
    UIButton *callButton = [self.buttonOutletCollection lastObject];
    [callButton setBackgroundImage:self.background forState:UIControlStateNormal];
    
    self.mode = NO;
}


- (IBAction)callAction:(UIButton *)sender
{
    
    [sender setBackgroundImage:self.point forState:UIControlStateNormal];
    
    UIButton *smsButton = [self.buttonOutletCollection firstObject];
    [smsButton setBackgroundImage:self.background forState:UIControlStateNormal];
    
    self.mode = YES;
}


- (void)actionInfoButton
{
    TSInfoViewController *settingsViewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"TSInfoViewController"];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}


- (void)callContactPickerViewController
{
    self.contactPicker = [[CNContactPickerViewController alloc] init];
    self.contactPicker.delegate = self;
    
    [self presentViewController:self.contactPicker animated:YES completion:nil];
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
            currentComand = [NSString phoneComand:[[self.textFieldsOutletCollection objectAtIndex:0] text]];
            break;
        case 2:
            currentComand = [NSString sosComand:self.mode];
            break;
        case 3:
            currentComand = [NSString pinComand:[[self.textFieldsOutletCollection objectAtIndex:1] text]];
            break;
        case 4:
            currentComand = [NSString resSetComand];
            break;
        case 5:
            currentComand = [NSString restoryFactorComand];
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


#pragma mark - UIPickerViewDataSource


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataSource.count;
}


//установка языка


- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (row == 0) {
        [self setEngleshLaunguage];
        [userDefaults setObject:@"English" forKey:@"language"];
        [userDefaults synchronize];
    } else {
        [self setGermanLaunguage];
        [userDefaults setObject:@"German" forKey:@"language"];
        [userDefaults synchronize];
    }
        
    return [self.dataSource objectAtIndex:row];
}


- (NSInteger)selectedRowInComponent:(NSInteger)component
{
    return component;
}


#pragma mark - UIPickerViewDelegate



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return kHeightRowComponent;
}


#pragma mark - UITextFieldDelegate


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    UITextField *phoneTextField = [self.textFieldsOutletCollection firstObject];
    UITextField *passwordTextField = [self.textFieldsOutletCollection objectAtIndex:1];
    
    if ([textField isEqual:phoneTextField]) {
        
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
    
    static const int passwordMaxLength = 6;
    
    if ([textField isEqual:passwordTextField]) {
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if ([newString length] > passwordMaxLength) {
            
            return NO;
        }
    }
    
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
    [self.launguageLabel setText:@"Language"];
    [self.sosNumberLabel setText:@"SOS number"];
    [self.smsLabel setText:@"SMS"];
    [self.callLabel setText:@"Call"];
    [self.passwordLabel setText:@"Password"];
    [self.resetSettingsLabel setText:@"Reset settings"];
    [self.restoreFactoreSettingsLabel setText:@"Restore factory settings"];
    
    UITextField *phoneTF = [self.textFieldsOutletCollection firstObject];
    phoneTF.placeholder = @"Phone number";
}


- (void)setGermanLaunguage
{
    [self.launguageLabel setText:@"Sprache"];
    [self.sosNumberLabel setText:@"SOS-Nummer"];
    [self.smsLabel setText:@"SMS"];
    [self.callLabel setText:@"Anruf"];
    [self.passwordLabel setText:@"Passwort"];
    [self.resetSettingsLabel setText:@"Einstellungen zurücksetzen"];
    [self.restoreFactoreSettingsLabel setText:@"Werkseinstellungen wiederherstellen"];
    
    UITextField *phoneTF = [self.textFieldsOutletCollection firstObject];
    phoneTF.placeholder = @"Telefonnummer";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
