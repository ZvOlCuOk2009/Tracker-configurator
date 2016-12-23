//
//  TSMainViewController.h
//  Tracker configurator
//
//  Created by Mac on 20.12.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ContactsUI/ContactsUI.h>
#import <Messages/Messages.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface TSMainViewController : UIViewController <MFMessageComposeViewControllerDelegate, CNContactPickerDelegate>

@property (strong, nonatomic) CNContactPickerViewController *contactPicker;

@property (strong, nonatomic) NSUserDefaults *userDefaults;
@property (strong, nonatomic) NSArray *recipient;

@property (strong, nonatomic) UIImage *point;
@property (strong, nonatomic) UIImage *background;

@property (strong, nonatomic) UIImageView *titleImageView;

@property (assign, nonatomic) NSInteger curentTag;

- (void)edgesForExtendedLayout;

@end
