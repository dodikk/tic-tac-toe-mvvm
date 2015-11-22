//
//  TTTColorThemePOD.h
//  TicTacToe
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTColorTheme.h"


@interface TTTColorThemePOD : NSObject<TTTColorTheme>

@property (nonatomic) id<TTTMenuTheme> menuTheme;
@property (nonatomic) id<TTKCellImageProvider> cellTheme;

@end
