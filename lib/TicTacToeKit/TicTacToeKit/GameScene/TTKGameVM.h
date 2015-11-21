//
//  TTKGameVM.h
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TicTacToeKit/Types/TTKCellPoint.h>

@protocol TTKPlayer;
@protocol TTKGameVMDelegate;

@protocol TTKGameVM <NSObject>

-(void)view:(id)view
didTapOnCell:(struct TTKCellPoint)cellPosition;




-(id<TTKPlayer>)activePlayer;

-(NSString*)gameOverMessage;

/**
 Typically a weak property
 */
-(id<TTKGameVMDelegate>)vcDelegate;
-(void)setVcDelegate:(id<TTKGameVMDelegate>)value;


@end
