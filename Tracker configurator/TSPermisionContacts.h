//
//  TSPermisionContacts.h
//  Tracker configurator
//
//  Created by Mac on 23.12.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBookUI/AddressBookUI.h>

@interface TSPermisionContacts : NSObject

@property (strong, nonatomic) NSUserDefaults *userDefaults;

+ (TSPermisionContacts *)sharedPermission;

- (NSInteger)userPermissionToAccessYourContacts;

@end
