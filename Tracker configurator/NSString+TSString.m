//
//  NSString+TSString.m
//  Tracker configurator
//
//  Created by Mac on 21.12.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "NSString+TSString.h"

static NSString *pin;

@implementation NSString (TSString)

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        pin = [userDefaults objectForKey:@"pin"];
    }
    return self;
}


+ (NSString *)whereComand
{
    NSString *comand = @"where";
    return comand;
}


+ (NSString *)adminPhoneComand:(NSString *)phone
{
    NSString *comand = [NSString stringWithFormat:@"admin%@ %@", pin, phone];
    return comand;
}


+ (NSString *)apnComand:(NSString *)text
{
    NSString *comand = [NSString stringWithFormat:@"apn%@ %@", pin, text];
    return comand;
}


+ (NSString *)adminipComand:(NSString *)server port:(NSString *)port
{
    NSString *comand = [NSString stringWithFormat:@"adminip%@ %@ %@", pin, server, port];
    return comand;
}


+ (NSString *)timeZoneComand:(NSString *)zone
{
    NSString *comand = [NSString stringWithFormat:@"timezone%@ %@", pin, zone];
    return comand;
}


+ (NSString *)gprsComand:(BOOL)gprs
{
    NSString *comand = nil;
    
    if (gprs == YES) {
        comand = [NSString stringWithFormat:@"gprs%@", pin];
    } else {
        comand = [NSString stringWithFormat:@"nogprs%@", pin];
    }
    
    return comand;
}


+ (NSString *)moveComand:(BOOL)move
{
    NSString *comand = nil;
    
    if (move == YES) {
        comand = [NSString stringWithFormat:@"​sleep%@ shock", pin];
    } else {
        comand = [NSString stringWithFormat:@"nosleep%@", pin];
    }
    
    return comand;
}


+ (NSString *)timeComand:(BOOL)time
{
    NSString *comand = nil;
    
    if (time == YES) {
        comand = [NSString stringWithFormat:@"sleep%@ time", pin];
    } else {
        comand = [NSString stringWithFormat:@"nosleep%@", pin];
    }
    
    return comand;
}


+ (NSString *)shockComand:(BOOL)shock
{
    NSString *comand = nil;
    
    if (shock == YES) {
        comand = [NSString stringWithFormat:@"shock%@", pin];
    } else {
        comand = [NSString stringWithFormat:@"​noshock%@", pin];
    }
    
    return comand;
}


+ (NSString *)trackingIntervalComand:(NSString *)interval
{
    NSString *comand = [NSString stringWithFormat:@"upload%@ %@", pin, interval];
    return comand;
}


+ (NSString *)modeComand:(BOOL)mode
{
    NSString *comand = nil;
    
    if (mode == YES) {
        comand = [NSString stringWithFormat:@"tracker%@", pin];
    } else {
        comand = [NSString stringWithFormat:@"​monitor%@", pin];
    }
    
    return comand;
}


+ (NSString *)moveAlarmComand:(BOOL)alarm
{
    NSString *comand = nil;
    
    if (alarm == YES) {
        comand = [NSString stringWithFormat:@"move%@", pin];
    } else {
        comand = [NSString stringWithFormat:@"​nomove%@", pin];
    }
    
    return comand;
}


+ (NSString *)overspeedAlarmComand:(BOOL)alarm kmh:(NSString *)kmh
{
    NSString *comand = nil;
    
    if (alarm == YES) {
        comand = [NSString stringWithFormat:@"speed%@ %@", pin, kmh];
    } else {
        comand = [NSString stringWithFormat:@"​nospeed%@", pin];
    }
    
    return comand;
}


+ (NSString *)statusComand
{
    NSString *comand = @"status";
    return comand;
}


+ (NSString *)parametersComand
{
    NSString *comand = @"param1";
    return comand;
}


+ (NSString *)configurationComand
{
    NSString *comand = @"param2";
    return comand;
}


+ (NSString *)setGpsCoordinateComand:(NSDictionary *)dictionaryValue determinant:(NSInteger)determinant
{
    NSString *command = nil;
    
    if (determinant == 1) {
        
        NSString *nsOnePV = [dictionaryValue objectForKey:@"nsOne"];
        NSString *ewOnePV = [dictionaryValue objectForKey:@"ewOne"];
        NSString *nsTwoPV = [dictionaryValue objectForKey:@"nsTwo"];
        NSString *ewTwoPV = [dictionaryValue objectForKey:@"ewTwo"];
        NSString *lattitudeOneTF = [dictionaryValue objectForKey:@"lattitudeOne"];
        NSString *longtittudeOneTF = [dictionaryValue objectForKey:@"longtittudeOne"];
        NSString *lattitudeTwoTF = [dictionaryValue objectForKey:@"lattitudeTwo"];
        NSString *longtittudeTwoTF = [dictionaryValue objectForKey:@"longtittudeTwo"];
        
        command = [NSString stringWithFormat:@"stockade%@ %@%@,%@%@;%@%@,%@%@", pin, lattitudeOneTF, nsOnePV, longtittudeOneTF, ewOnePV, lattitudeTwoTF, nsTwoPV, longtittudeTwoTF, ewTwoPV];
        
    } else if (determinant == 2) {
        
        command = [NSString stringWithFormat:@"RESET GPSZONE #%@", pin];
        
    } else if (determinant == 3) {
        
        command = [NSString stringWithFormat:@"TEST GPSZONE #%@", pin];
    }
    
    return command;
}


@end
