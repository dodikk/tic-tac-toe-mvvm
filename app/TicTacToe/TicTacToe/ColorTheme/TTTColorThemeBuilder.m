//
//  TTTColorThemeBuilder.m
//  TicTacToe
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import "TTTColorThemeBuilder.h"

#import "TTTColorThemePOD.h"
#import "TTTMenuThemePOD.h"


@implementation TTTColorThemeBuilder

+(id<TTTColorTheme>)currentTheme
{
    // TODO : maybe configure depending on a target
    return [self basicControlsTheme];
}

+(id<TTTColorTheme>)basicControlsTheme
{
    TTTColorThemePOD* result = [TTTColorThemePOD new];
    {
        result.menuTheme = [TTTMenuThemePOD new];
    }
    
    
    return result;
}

@end
