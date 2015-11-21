//
//  TTKGameVMImpl.h
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TicTacToeKit/GameScene/TTKGameVM.h>

@protocol TTKFieldState;
@protocol TTKMutableFieldState;

@interface TTKGameVMImpl : NSObject<TTKGameVM>

-(instancetype)init NS_UNAVAILABLE;
+(instancetype)new NS_UNAVAILABLE;

-(instancetype)initWithField:(id<TTKFieldState, TTKMutableFieldState>)fieldModel
                     xPlayer:(BOOL)isPlayerXSelectedFromMenu
NS_DESIGNATED_INITIALIZER
NS_REQUIRES_SUPER
__attribute__((nonnull));


@property (nonatomic, readonly) NSArray* players;

@property (nonatomic)       id<TTKPlayer>         activePlayer;
@property (nonatomic, weak) id<TTKGameVMDelegate> vcDelegate  ;

@end
