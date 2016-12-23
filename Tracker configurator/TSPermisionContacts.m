//
//  TSPermisionContacts.m
//  Tracker configurator
//
//  Created by Mac on 23.12.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSPermisionContacts.h"

@implementation TSPermisionContacts

+ (TSPermisionContacts *)sharedPermission
{
    static TSPermisionContacts *permission = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        permission = [[TSPermisionContacts alloc] init];
    });
    
    return permission;
}


- (NSInteger)userPermissionToAccessYourContacts
{
    
    __block NSInteger permission;
    
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {
                permission = 1;
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[[UIAlertView alloc] initWithTitle:nil message:@"""Moby-click"" requests access to your contacts" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                });
                permission = 0;
            }
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        
        permission = 1;
    }
    else {
        
        [[[UIAlertView alloc] initWithTitle:nil message:@"""Moby-click"" requests access to your contacts. Go to privacy settings, and provide access" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        
        permission = 0;
    }
    
    return permission;
}

@end
