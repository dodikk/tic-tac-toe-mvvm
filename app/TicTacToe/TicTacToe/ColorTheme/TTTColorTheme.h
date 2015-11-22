//
//  TTTColorTheme.h
//  TicTacToe
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TTTMenuTheme;
@protocol TTKCellImageProvider;


@protocol TTTColorTheme <NSObject>

-(id<TTTMenuTheme>)menuTheme;
-(id<TTKCellImageProvider>)cellTheme;

@end
