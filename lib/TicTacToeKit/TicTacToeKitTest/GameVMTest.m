//
//  GameVMTest.m
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 21/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <TicTacToeKit/TicTacToeKit.h>
#import "TTKGameVMImpl.h"
#import "TTKMatrixFieldModel.h"


@interface GameVMTest : XCTestCase<TTKGameVMDelegate>
@end

@implementation GameVMTest
{
    TTKGameVMImpl* _sut;
    TTKMatrixFieldModel* _field;
}


-(void)setUp
{
    [super setUp];

    self->_field = [TTKMatrixFieldModel new];
    self->_sut = [[TTKGameVMImpl alloc] initWithField: self->_field
                                              xPlayer: YES];
}

-(void)tearDown
{
    self->_field = nil;
    self->_sut   = nil;
    
    [super tearDown];
}

-(void)testPlayerInitializationX
{
    TTKMatrixFieldModel* field = [TTKMatrixFieldModel new];
    TTKGameVMImpl* sut = [[TTKGameVMImpl alloc] initWithField: field
                                                      xPlayer: YES];
    
    
    id<TTKPlayer> activePlayer = [sut activePlayer];
    {
        XCTAssertTrue([activePlayer isPlayerX]);
        XCTAssertFalse([activePlayer isPlayerO]);
    }
    
    id<TTKPlayer> otherPlayer = [sut players][1];
    {
        XCTAssertFalse([otherPlayer isPlayerX]);
        XCTAssertTrue([otherPlayer isPlayerO]);
    }
    
    // TODO : check image
    XCTAssertTrue(2 == [[sut players] count]);
    XCTAssertTrue([sut players][0] == activePlayer);
}


-(void)testPlayerInitializationO
{
    TTKMatrixFieldModel* field = [TTKMatrixFieldModel new];
    TTKGameVMImpl* sut = [[TTKGameVMImpl alloc] initWithField: field
                                                      xPlayer: NO];
    
    id<TTKPlayer> activePlayer = [sut activePlayer];
    {
        XCTAssertFalse([activePlayer isPlayerX]);
        XCTAssertTrue([activePlayer isPlayerO]);
    }

    
    id<TTKPlayer> otherPlayer = [sut players][1];
    {
        XCTAssertTrue([otherPlayer isPlayerX]);
        XCTAssertFalse([otherPlayer isPlayerO]);
    }
    
    // TODO : check image
    XCTAssertTrue(2 == [[sut players] count]);
    XCTAssertTrue([sut players][0] == activePlayer);
}




#pragma mark - TTKGameVMDelegate
-(void)viewModelDidDetectGameOver:(id<TTKGameVM>)viewModel
{
    // IDLE
}

-(void)viewModel:(id<TTKGameVM>)viewModel
didChangeCellState:(struct TTKCellPoint)cellPosition
{
    // IDLE
}

-(void)viewModel:(id<TTKGameVM>)viewModel
didTapOnPosessedCell:(struct TTKCellPoint)cellPosition
{
    // IDLE
}

@end