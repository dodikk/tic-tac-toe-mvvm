//
//  TTTColorThemeBuilder.h
//  TicTacToe
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TTTColorTheme;


@interface TTTColorThemeBuilder : NSObject

+(instancetype)new NS_UNAVAILABLE;
-(instancetype)init NS_UNAVAILABLE;

+(id<TTTColorTheme>)currentTheme;

@end
