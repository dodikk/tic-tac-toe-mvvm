//
//  TTTMenuTheme.h
//  TicTacToe
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIColor;

@protocol TTTMenuTheme <NSObject>

-(UIColor*)buttonBackgroundColor;
-(UIColor*)buttonTextColor;

@end
