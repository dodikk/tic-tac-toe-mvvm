//
//  TTTAlertHelper.m
//  TicTacToe
//
//  Created by Oleksandr Dodatko on 22/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import "TTTAlertHelper.h"

@implementation TTTAlertHelper

+(UIAlertController*)alertWithTitle:(NSString*)title
                            message:(NSString*)message
                     buttonCallback:(UIAlertControllerButtonHandler)callback
{
    UIAlertController* alert = nil;
    {
        alert =
        [UIAlertController alertControllerWithTitle: title
                                            message: message
                                     preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton =
        [UIAlertAction actionWithTitle: NSLocalizedString(@"ALERT_BUTTON__OK", nil)
                                 style: UIAlertActionStyleDefault
                               handler: callback];
        [alert addAction: okButton];
    }
    
    return alert;

}

+(UIAlertController*)gameOverMessage:(NSString*)message
                  withButtonCallback:(UIAlertControllerButtonHandler)callback
{
    NSString* title = NSLocalizedString(@"GAME_OVER__ALERT_TITLE", nil);
    
    return [self alertWithTitle: title
                        message: message
                 buttonCallback: callback];
}

+(UIAlertController*)badTurnMessage:(NSString*)message
                 withButtonCallback:(UIAlertControllerButtonHandler)callback
{
    NSString* title = NSLocalizedString(@"BAD_TURN__ALERT_TITLE", nil);
    
    return [self alertWithTitle: title
                        message: message
                 buttonCallback: callback];
}

@end


