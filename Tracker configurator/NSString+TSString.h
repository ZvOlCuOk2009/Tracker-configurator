//
//  NSString+TSString.h
//  Tracker configurator
//
//  Created by Mac on 21.12.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TSString)

+ (NSString *)whereComand;
+ (NSString *)adminPhoneComand:(NSString *)phone;
+ (NSString *)apnComand:(NSString *)text;
+ (NSString *)adminipComand:(NSString *)server port:(NSString *)port;
+ (NSString *)timeZoneComand:(NSString *)zone;   
+ (NSString *)gprsComand:(BOOL)gprs;
+ (NSString *)moveComand:(BOOL)move;
+ (NSString *)timeComand:(BOOL)time;
+ (NSString *)shockComand:(BOOL)shock;
+ (NSString *)trackingIntervalComand:(NSString *)interval;
+ (NSString *)modeComand:(BOOL)mode;
+ (NSString *)moveAlarmComand:(BOOL)alarm;
+ (NSString *)overspeedAlarmComand:(BOOL)alarm kmh:(NSString *)kmh;
+ (NSString *)statusComand;
+ (NSString *)parametersComand;
+ (NSString *)configurationComand;
+ (NSString *)setGpsCoordinateComand:(NSDictionary *)dictionaryValue determinant:(NSInteger)determinant;

@end
