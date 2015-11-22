//
//  TTTAlertHelper.h
//  TicTacToe
//
//  Created by Oleksandr Dodatko on 22/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "UIKitTypes.h"

@interface TTTAlertHelper : NSObject

+(UIAlertController*)gameOverMessage:(NSString*)message
                  withButtonCallback:(UIAlertControllerButtonHandler)callback;

+(UIAlertController*)badTurnMessage:(NSString*)message
                 withButtonCallback:(UIAlertControllerButtonHandler)callback;

@end
