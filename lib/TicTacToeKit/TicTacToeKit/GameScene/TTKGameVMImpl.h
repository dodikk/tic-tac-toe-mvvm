//
//  TTKGameVMImpl.h
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TicTacToeKit/GameScene/TTKGameVM.h>

@interface TTKGameVMImpl : NSObject<TTKGameVM>

@property (nonatomic)       id<TTKPlayer>         activePlayer;
@property (nonatomic, weak) id<TTKGameVMDelegate> vcDelegate  ;

@end
