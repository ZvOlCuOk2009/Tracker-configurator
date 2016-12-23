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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:text forKey:@"internet"];
    [userDefaults synchronize];
    
    NSString *comand = [NSString stringWithFormat:@"apn%@ %@", pin, text];
    return comand;
}


+ (NSString *)adminipComand:(NSString *)server port:(NSString *)port
{
    if ([server isEqualToString:@""]) {
        server = @"94.229.67.27";
    }
    
    if ([port isEqualToString:@""]) {
        port = @"11912";
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:server forKey:@"server"]; 
    [userDefaults setObject:port forKey:@"port"];
    [userDefaults synchronize];
    
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
        comand = [NSString stringWithFormat:@"​monitor%@", pin];
    } else {
        comand = [NSString stringWithFormat:@"tracker%@", pin];
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
        
        command = [NSString stringWithFormat:@"nostockade%@", pin];
    }
    
    return command;
}


+ (NSString *)phoneComand:(NSString *)phone
{
    NSString *comand = [NSString stringWithFormat:@"sos%@ %@", pin, phone];
    return comand;
}


+ (NSString *)sosComand:(BOOL)mode
{
    NSString *comand = nil;
    
    if (mode == YES) {
        comand = [NSString stringWithFormat:@"​soscall%@", pin];
    } else {
        comand = [NSString stringWithFormat:@"sossms%@", pin];
    }
    
    return comand;
}


+ (NSString *)pinComand:(NSString *)newPin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:newPin forKey:@"pin"];
    [userDefaults synchronize];
    
    NSString *comand = [NSString stringWithFormat:@"password%@ %@", pin, newPin];
    return comand;
}


+ (NSString *)resSetComand
{
    NSString *comand = [NSString stringWithFormat:@"begin%@", pin];
    return comand;
}


+ (NSString *)restoryFactorComand
{
    return @"format";
}


+ (NSString *)infoText
{
    return @"Configuration via Text Message (SMS)\nBefore using SIM Card, please turn off request of PIN code! Put the SIM card and battery in place. Turn on the unit by switching to“On”, the indicators is on./nStep1. admin123456+space+your phone number\nIf you want to use Web-based GPS-tracking:\nStep2. apn123456+ space+local apn content\nStep3. adminip123456 +space+94.229.65.15+space+11701\nStep4. gprs123456\nAfter 10 or 40 seconds, the unit will begin to work and acquire the GSM signals as well as the GPS signals. The indicator will keep flashing every 3 seconds when the unit has received the signals. When this unit receives GPS signals normally, you can use it and do any setting as the instructions of this manual.\nChange the password\nSet Password:\nSend sms:\npassword+old password+space+new password\n\nto the unit to change the password. For Example, send sms: “ password123456 000000” to terminal device, it will reply sms: “password OK”. New password 000000 changed in success.\nBe sure keep the new password in mind, you have to upload the software to restore the original setting in case of losing the new password. Make sure the new password is in 6 digits Arabic numbers, or the tracker can not recognize the password. Make sure that all the symbol“+”in sms commends is just for quick understanding, which don’t need to enter “+” in sms, and “space” means press the spacebar button of the cell phone.\n\n\nAuthorization\nSend SMS\nadmin+password+space+cell phone number\nto set up a authorized number. The other authorized numbers should be set by the first authorized number. If the number is successfully authorized, the unit will reply “admin ok!” in SMS.\nSend SMS：\nnoadmin+password+space+authorized number \nSingle Locating\nIf there is no authorized number, when any number dials up the unit, it will report a Geo-info; If there is already an authorized number, then it will not respond when an unauthorized number calls it up. Single message inquires the latitude and longitude information, any telephone number can send instruction where to the equipment, then the equipment will reply the latitude and longitude information to this telephone. Tracking location, When GPS signals is weak, the position of latitude and longitude included in the SMS is the position that the tracker received GPS signals at last. If it is different with its exact current location, pay attention to check the time included in the SMS you got. \nAuto Track\nSend SMS command:\nt030s005n+password\n\nto the tracker device, it will report the “no reply” at 30s intervals for 5 times. (s:second, m:minute, h:hour). This command setting must be in 3 digits and the maximum value is 255. Unlimited times auto track: Send SMS t030s***n+password to the tracker device, it will reply the “no reply” continuously at 30 seconds intervals. Cancellation: Send SMS notn+password\nto the tracker device, it will report the “notn ok”.\nNote: the interval must not less than 20s. Monitor (Voice Surveillance) The command to switch between Track and Monitor are tracker and monitor. The default mode is “tracker” (Track mode). Send SMS monitor+password to the unit, and it will reply “monitor ok!” and switch to“monitor” mode. Send SMS tracker+password to the unit, it will reply “tracker ok!” and restore to “track” mode. Geo-fence Set up a geo-fence for the unit to restrict its movements within a district. The unit will send the message to the authorized numbers when it breaches the district. Set up: When the unit stays immobile in a place for 3-10 minutes, the user can Send SMS: stockade+password+space+latitude,longitude; latitude,longitude to unit to set the restricted district. The first latitude&longitude is coordinate of the top left corner of the Geo-fence, while the second latitude&longitude is the coordinate of the bottom right corner. /n Example: stockade123456 49.329808N,11.554868E;49.322488N,11.574746E Cancel: Send SMS: nostockade+password to deactivate this function,tracker will reply “nostockade ok”. Movement alert Set up: When the unit stays immobile in a place for 3-10 minutes, the user can send SMS: move+password to the unit, then the unit will reply “move ok!”. In case of such a movement （the unit default distance is 500M, it will send SMS “Move ALARM+ latitude and longitude” to the authorized number \nCancel: Send SMS: nomove+password to deactivate the movement alert, tracker will reply “nomove ok”. Overspeed alert: Set up: Send SMS: speed+password+space+080 to the unit (suppose the speed is 80km/h), and it will reply “speed ok!”. When the target moves exceeding 80 km/h, the unit will send SMS :”speed ALARM !+ Latitude and longitude” to the authorized numbers every 5 minutes. Cancel: Send SMS nospeed+password to deactivate the overspeed alarm, tracker will reply “nospeed ok”. The recommended speed should be not less than 50km/h. For below that rate, it will beeffected the accuracy by gps signals drift etc. Low battery alert When GPS device battery is going to be about 3.7V, it will send SMS: “bat:l” at 30 minutes interval. /nTerminal (local) Time Setting Send SMS: time+space+zone+password+space+local time For example, Send SMS “time zone123456 1” (time zone for Europe). If the local time zone is negative as “-3”, then it should set as SMS: “time zone123456 -3”. Sleeping power-save mode On normal status, when the unit stoped over 10minutes, it will change to sleeping mode, on this mode, the power consumption is 4ma/h only. When it get any command or been moved, it will start GPS locating automatically. Forced sleeping mode setting: send SMS sleep+password the unit will reply “sleep ok”, it enter to forced sleeping power-save mode. Start devi It is effective sending by authorized number Send SMS command shock+password the unit will reply “shock ok.” Cancel: Send SMS command noshock+password the unit will reply “noshock ok.” \nGPRS setting This section need only if you plan to use Web-based GPS tracking. For GPRS data sending mobile operator can charge additional pay. User must send SMS via cell phone to set up IP, port and APN before starting GPRS. 7.16.1 Setting up APN APN standards for Access Point Name and differs from country to country. For more information about the local APN, inquire with your local GPRS network operator. Send to the tracker a SMS apn+password + Space + your local APN via a cell phone and if succeeded in setup, the tracker will return the message “apn ok”. Example: send SMS command “apn123456 internet”. If succeeded, “apn ok” is returned by the tracker in SMS. 7.16.1.4 Set IP: Send SMS command: adminip123456 94.229.65.15 11701 where 94.229.65.15 – IP address, 11701 – port of GPS-server.\nIf succeeded, adminip ok” Restore factory settings Send SMS format and all settings will be cleared.\nPAGE \nPAGE  4";
}




//+ (NSString *)infoText
//{
//    return @"Configuration via Text Message (SMS)\nBefore using SIM Card, please turn off request of PIN code! Put the SIM card and battery in place. Turn on the unit by switching to“On”, the indicators is on./nStep1. admin123456+space+your phone number\nIf you want to use Web-based GPS-tracking:\nStep2. apn123456+ space+local apn content\nStep3. adminip123456 +space+94.229.65.15+space+11701\nStep4. gprs123456
//    
//    After 10 or 40 seconds, the unit will begin to work and acquire the GSM signals as well as the GPS signals.
//    The indicator will keep flashing every 3 seconds when the unit has received the signals.
//    When this unit receives GPS signals normally, you can use it and do any setting as the instructions of this manual.
//        
//        Change the password
//        Set Password:
//        Send sms:
//        password+old password+space+new password
//        
//        to the unit to change the password.
//        For Example, send sms: “ password123456 000000” to terminal device, it will reply sms:
//        “password OK”. New password 000000 changed in success.
//        
//        Be sure keep the new password in mind, you have to upload the software to restore the
//        original setting in case of losing the new password. Make sure the new password is in 6 digits Arabic numbers, or the tracker can not recognize the password. Make sure that all the symbol“+”in sms commends is just for quick understanding, which don’t need to enter “+” in sms, and “space” means press the spacebar button of the cell phone.
//            
//            Authorization
//            Send SMS
//            admin+password+space+cell phone number
//            
//            to set up a authorized number. The other authorized numbers should be set by the first authorized number. If the number is successfully authorized, the unit will reply “admin ok!” in SMS.
//            Send SMS：
//            noadmin+password+space+authorized number
//            Single Locating
//            If there is no authorized number, when any number dials up the unit, it will report a Geo-info;
//    If there is already an authorized number, then it will not respond when an unauthorized number calls it up.
//    Single message inquires the latitude and longitude information, any telephone number can send instruction
//    where
//    
//    to the equipment, then the equipment will reply the latitude and longitude information to this telephone.
//    Tracking location, When GPS signals is weak, the position of latitude and longitude included in the SMS is the position that the tracker received GPS signals at last. If it is different with its exact current location, pay attention to check the time included in the SMS you got.
//    
//    Auto Track
//    Send SMS command:
//    t030s005n+password
//    
//    to the tracker device, it will report the “no reply” at 30s intervals for 5 times. (s:second, m:minute, h:hour). This command setting must be in 3 digits and the maximum value is 255.
//        Unlimited times auto track: Send SMS
//        t030s***n+password
//        
//        to the tracker device, it will reply the “no reply” continuously at 30 seconds intervals.
//        Cancellation: Send SMS
//        notn+password
//        
//        to the tracker device, it will report the “notn ok”.
//        Note: the interval must not less than 20s.
//        
//        Monitor (Voice Surveillance)
//        The command to switch between Track and Monitor are tracker and monitor.
//        The default mode is “tracker” (Track mode).
//        Send SMS
//        monitor+password
//        
//        to the unit, and it will reply “monitor ok!” and switch to“monitor” mode.
//        Send SMS
//        tracker+password
//        
//        to the unit, it will reply “tracker ok!” and restore to “track” mode. Geo-fence
//        Set up a geo-fence for the unit to restrict its movements within a district. The unit will send the
//            message to the authorized numbers when it breaches the district.
//            Set up: When the unit stays immobile in a place for 3-10 minutes, the user can Send SMS:
//                stockade+password+space+latitude,longitude; latitude,longitude
//    
//    to unit to set the restricted district.
//    The first latitude&longitude is coordinate of the top left corner of the Geo-fence, while
//        the second latitude&longitude is the coordinate of the bottom right corner.
//        
//        Example: stockade123456 49.329808N,11.554868E;49.322488N,11.574746E
//    
//Cancel: Send SMS:
//    nostockade+password
//    
//    to deactivate this function,tracker will reply “nostockade ok”.
//    
//    Movement alert
//    Set up: When the unit stays immobile in a place for 3-10 minutes, the user can send SMS:
//        move+password
//        to the unit, then the unit will reply “move ok!”. In case of such a movement （the unit default distance is 500M, it will send SMS “Move ALARM+ latitude and longitude” to the authorized number
//        Cancel: Send SMS:
//        nomove+password
//        
//        to deactivate the movement alert, tracker will reply “nomove ok”.
//        
//        Overspeed alert:
//        Set up: Send SMS:
//        speed+password+space+080
//        
//        to the unit (suppose the speed is 80km/h), and it will reply “speed ok!”. When the target moves exceeding 80 km/h, the unit will send SMS :”speed ALARM !+ Latitude and longitude” to the authorized numbers every 5 minutes.
//        Cancel: Send SMS
//        nospeed+password
//        
//        to deactivate the overspeed alarm, tracker will reply “nospeed ok”.
//        The recommended speed should be not less than 50km/h. For below that rate, it will beeffected the accuracy by gps signals drift etc.
//        
//        Low battery alert
//        When GPS device battery is going to be about 3.7V, it will send SMS: “bat:l” at 30 minutes
//        interval.
//        
//        Terminal (local) Time Setting
//        Send SMS:
//        time+space+zone+password+space+local time
//        
//        For example, Send SMS “time zone123456 1” (time zone for Europe).
//        If the local time zone is negative as “-3”, then it should set as SMS: “time zone123456 -3”.
//        
//        Sleeping power-save mode
//        On normal status, when the unit stoped over 10minutes, it will change to sleeping mode, on this
//        mode, the power consumption is 4ma/h only. When it get any command or been moved, it will start GPS locating automatically.
//        Forced sleeping mode setting: send SMS
//        sleep+password
//        
//        the unit will reply “sleep ok”, it enter to forced sleeping power-save mode.
//        Start device, send SMS
//        nosleep+password
//        
//        the unit will reply “nosleep ok”, it start GPRS and GPS locating.
//        
//        Shock alert
//        It is effective sending by authorized number
//        Send SMS command
//        shock+password
//        
//        the unit will reply “shock ok.”
//        Cancel: Send SMS command
//        noshock+password
//        
//        the unit will reply “noshock ok.”
//        
//        GPRS setting
//        This section need only if you plan to use Web-based GPS tracking. For GPRS data sending mobile operator can charge additional pay. User must send SMS via cell phone to set up IP, port and APN before starting GPRS.
//            7.16.1 Setting up APN
//            APN standards for Access Point Name and differs from country to country. For more information about the local APN, inquire with your local GPRS network operator.
//                Send to the tracker a SMS
//                apn+password + Space + your local APN
//                
//                via a cell phone and if succeeded in setup, the tracker will return the message “apn ok”.
//                    Example: send SMS command “apn123456 internet”. If succeeded, “apn ok” is returned by the tracker in SMS.
//                    7.16.1.4 Set IP: Send SMS command:
//                    adminip123456 94.229.65.15 11701
//                    
//                    where 94.229.65.15 – IP address, 11701 – port of GPS-server.
//                    If succeeded, adminip ok”
//                    
//                    Restore factory settings
//                    Send SMS
//                    
//                    format
//                    
//                    and all settings will be cleared.
//                    
//                    
//                    
//                    PAGE  
//                    
//                    
//                    PAGE  4";
//}
//
//
@end
