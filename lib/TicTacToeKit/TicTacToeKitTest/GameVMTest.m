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
#import "TTKGameOverLocalizerStub.h"
#import "TTKNilImageProvider.h"

@interface GameVMTest : XCTestCase<TTKGameVMDelegate>
@end

@implementation GameVMTest
{
    TTKGameVMImpl* _sut;
    TTKMatrixFieldModel* _field;
    TTKGameOverLocalizerStub* _localizer;
    TTKNilImageProvider* _imageProvider;
    
    NSMutableArray* _callbacksLog;
    
    struct TTKCellPoint _lastModifiedCell;
    NSUInteger _turnCount;
    NSUInteger _turnFailureCount;
    
    NSUInteger _gameOverCount;
    NSUInteger _afterGameOverCount;
    
    NSUInteger _turnTransferCount;
}

-(void)cleanupCounters
{
    self->_lastModifiedCell = (struct TTKCellPoint){100, 100};
    self->_turnCount          = 0;
    self->_turnFailureCount   = 0;
    self->_gameOverCount      = 0;
    self->_afterGameOverCount = 0;
    self->_turnTransferCount  = 0;
}

-(void)setUp
{
    [super setUp];

    self->_localizer = [TTKGameOverLocalizerStub new];
    self->_imageProvider = [TTKNilImageProvider new];
    
    self->_callbacksLog = [NSMutableArray new];
    [self cleanupCounters];
    
    // To be initialized in test methods
    //
//    self->_field = [TTKMatrixFieldModel new];
//    self->_sut = [[TTKGameVMImpl alloc] initWithField: self->_field
//                                              xPlayer: YES];
}

-(void)tearDown
{
    self->_callbacksLog = nil;
    self->_localizer    = nil;
    self->_field        = nil;
    self->_sut          = nil;
 
    [self cleanupCounters];
    
    
    [super tearDown];
}


#pragma mark - Players Test
-(void)testPlayerInitializationX
{
    TTKMatrixFieldModel* field = [TTKMatrixFieldModel new];
    TTKGameVMImpl* sut = [[TTKGameVMImpl alloc] initWithField: field
                                                      xPlayer: YES
                                                    localizer: self->_localizer
                                                imageProvider: self->_imageProvider];
    
    
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
    
    XCTAssertEqualObjects(@"Turn of player X", sut.turnIndicatorMessage);
}


-(void)testPlayerInitializationO
{
    TTKMatrixFieldModel* field = [TTKMatrixFieldModel new];
    TTKGameVMImpl* sut = [[TTKGameVMImpl alloc] initWithField: field
                                                      xPlayer: NO
                                                    localizer: self->_localizer
                                                imageProvider: self->_imageProvider];
    
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
    
    XCTAssertEqualObjects(@"Turn of player O", sut.turnIndicatorMessage);
}

#pragma mark - Turn
-(void)testActivePlayerIsChangedAfterTurn
{
    // GIVEN
    self->_field = [TTKMatrixFieldModel new];
    self->_sut = [[TTKGameVMImpl alloc] initWithField: self->_field
                                              xPlayer: YES
                                            localizer: self->_localizer
                                        imageProvider: self->_imageProvider];
    self->_sut.vcDelegate = self;
    
    struct TTKCellPoint firstTurnPosition = {1, 1};
    
    id<TTKPlayer> activePlayerBefore = [self->_sut activePlayer];
    XCTAssertTrue(0 == self->_turnCount);
    XCTAssertTrue(0 == self->_turnTransferCount);
    XCTAssertEqualObjects(@"Turn of player X", self->_sut.turnIndicatorMessage);
    
    
    // WHEN
    [self->_sut view: self
        didTapOnCell: firstTurnPosition];
    
    
    
    // THEN
    //
    // TODO : introduce XCTest expectations
    // in case the code becomes asynchronous
    XCTAssertTrue(1 == self->_turnCount);
    XCTAssertTrue(1 == self->_turnTransferCount);
    XCTAssertTrue(0 == self->_turnFailureCount);
    XCTAssertTrue(0 == self->_gameOverCount);
    XCTAssertTrue(0 == self->_afterGameOverCount);
    
    id<TTKPlayer> activePlayerAfter = [self->_sut activePlayer];
    XCTAssertTrue(activePlayerAfter != activePlayerBefore);
    
    
    XCTAssertTrue([activePlayerBefore isPlayerX]);
    XCTAssertTrue([activePlayerAfter  isPlayerO]);
    
    XCTAssertEqualObjects(@"Turn of player O", self->_sut.turnIndicatorMessage);
}

-(void)testFieldIsTakenByActivePlayer
{
    // GIVEN
    self->_field = [TTKMatrixFieldModel new];
    self->_sut = [[TTKGameVMImpl alloc] initWithField: self->_field
                                              xPlayer: YES
                                            localizer: self->_localizer
                                        imageProvider: self->_imageProvider];
    self->_sut.vcDelegate = self;
    
    struct TTKCellPoint firstTurnPosition = {1, 1};
    
    XCTAssertTrue([self->_field isFieldEmpty: firstTurnPosition]);
    
    // WHEN
    [self->_sut view: self
        didTapOnCell: firstTurnPosition];
    
    
    // THEN
    XCTAssertTrue([self->_field isFieldTakenByX: firstTurnPosition]);
}

-(void)testDelegateIsNotifiedAfterTurn
{
    // GIVEN
    self->_field = [TTKMatrixFieldModel new];
    self->_sut = [[TTKGameVMImpl alloc] initWithField: self->_field
                                              xPlayer: YES
                                            localizer: self->_localizer
                                        imageProvider: self->_imageProvider];
    self->_sut.vcDelegate = self;
    
    struct TTKCellPoint firstTurnPosition = {1, 1};
    XCTAssertTrue(0 == self->_turnCount);
    XCTAssertTrue(0 == self->_turnTransferCount);
    XCTAssertTrue(0 == self->_turnFailureCount);
    XCTAssertTrue(0 == self->_gameOverCount);
    XCTAssertTrue(0 == self->_afterGameOverCount);
    
    
    // WHEN
    [self->_sut view: self
        didTapOnCell: firstTurnPosition];
    
    
    
    // THEN
    //
    // TODO : introduce XCTest expectations
    // in case the code becomes asynchronous
    XCTAssertTrue(1 == self->_turnCount);
    XCTAssertTrue(1 == self->_turnTransferCount);
    XCTAssertTrue(0 == self->_turnFailureCount);
    XCTAssertTrue(0 == self->_gameOverCount);
    XCTAssertTrue(0 == self->_afterGameOverCount);
    XCTAssertNil([self->_sut gameOverMessage]);
    
    XCTAssertTrue(self->_lastModifiedCell.row == firstTurnPosition.row);
    XCTAssertTrue(self->_lastModifiedCell.column == firstTurnPosition.column);
}

// ! x x
// 0 x -
// 0 - -
-(void)testGameOverNotificationForWin
{
    // GIVEN
    self->_field = [TTKMatrixFieldModel new];
    {
//        [self->_field takeField: (struct TTKCellPoint){0, 0} byX: NO];
        [self->_field takeField: (struct TTKCellPoint){1, 0} byX: NO];
        [self->_field takeField: (struct TTKCellPoint){2, 0} byX: NO];
        
        [self->_field takeField: (struct TTKCellPoint){0, 1} byX: YES];
        [self->_field takeField: (struct TTKCellPoint){0, 2} byX: YES];
        [self->_field takeField: (struct TTKCellPoint){1, 1} byX: YES];
    }
    
    self->_sut = [[TTKGameVMImpl alloc] initWithField: self->_field
                                              xPlayer: NO
                                            localizer: self->_localizer
                                        imageProvider: self->_imageProvider];
    self->_sut.vcDelegate = self;
    
    struct TTKCellPoint gameOverTurnPosition = {0, 0};

    // WHEN
    [self->_sut view: self
        didTapOnCell: gameOverTurnPosition];
    
    XCTAssertTrue([self->_field isFieldTakenByY: gameOverTurnPosition]);
    
    XCTAssertTrue(1 == self->_turnCount);
    XCTAssertTrue(1 == self->_turnTransferCount);
    XCTAssertTrue(0 == self->_turnFailureCount);
    XCTAssertTrue(1 == self->_gameOverCount);
    XCTAssertTrue(0 == self->_afterGameOverCount);
    
    XCTAssertEqualObjects(self->_callbacksLog[0], @"Turn success by |O| : {0, 0}");
    XCTAssertEqualObjects(self->_callbacksLog[1], @"Game Over");
    
    
    XCTAssertEqualObjects([self->_sut gameOverMessage], @"O wins");
    XCTAssertEqualObjects(@"O wins", self->_sut.turnIndicatorMessage);
}


// ! x o
// o x x
// x o o
-(void)testGameOverNotificationForDraw
{
    // GIVEN
    self->_field = [TTKMatrixFieldModel new];
    {
    //    [self->_field takeField: (struct TTKCellPoint){0, 0} byX: YES];
        [self->_field takeField: (struct TTKCellPoint){0, 1} byX: YES];
        [self->_field takeField: (struct TTKCellPoint){0, 2} byX: NO ];
        
        [self->_field takeField: (struct TTKCellPoint){1, 0} byX: NO ];
        [self->_field takeField: (struct TTKCellPoint){1, 1} byX: YES];
        [self->_field takeField: (struct TTKCellPoint){1, 2} byX: YES];
        
        [self->_field takeField: (struct TTKCellPoint){2, 0} byX: YES];
        [self->_field takeField: (struct TTKCellPoint){2, 1} byX: NO ];
        [self->_field takeField: (struct TTKCellPoint){2, 2} byX: NO ];
    }
    
    self->_sut = [[TTKGameVMImpl alloc] initWithField: self->_field
                                              xPlayer: YES
                                            localizer: self->_localizer
                                        imageProvider: self->_imageProvider];
    self->_sut.vcDelegate = self;
    
    struct TTKCellPoint gameOverTurnPosition = {0, 0};
    
    
    // WHEN
    [self->_sut view: self
        didTapOnCell: gameOverTurnPosition];
    
    XCTAssertTrue([self->_field isFieldTakenByX: gameOverTurnPosition]);
    
    XCTAssertTrue(1 == self->_turnCount);
    XCTAssertTrue(1 == self->_turnTransferCount);
    XCTAssertTrue(0 == self->_turnFailureCount);
    XCTAssertTrue(1 == self->_gameOverCount);
    XCTAssertTrue(0 == self->_afterGameOverCount);
    
    XCTAssertEqualObjects(self->_callbacksLog[0], @"Turn success by |X| : {0, 0}");
    XCTAssertEqualObjects(self->_callbacksLog[1], @"Game Over");
    
    
    XCTAssertEqualObjects([self->_sut gameOverMessage], @"A draw");
    XCTAssertEqualObjects(@"A draw", self->_sut.turnIndicatorMessage);
}


// - - -
// - ! -
// - - -
-(void)testUserIsNotifiedAboutTurnFailure
{
    // GIVEN
    self->_field = [TTKMatrixFieldModel new];
    self->_sut = [[TTKGameVMImpl alloc] initWithField: self->_field
                                              xPlayer: YES
                                            localizer: self->_localizer
                                        imageProvider: self->_imageProvider];
    self->_sut.vcDelegate = self;
    
    struct TTKCellPoint firstTurnPosition = {1, 1};
    XCTAssertTrue(0 == self->_turnCount);
    XCTAssertTrue(0 == self->_turnTransferCount);
    XCTAssertEqualObjects(@"Turn of player X", self->_sut.turnIndicatorMessage);
    
    
    // WHEN
    [self->_sut view: self
        didTapOnCell: firstTurnPosition];
    XCTAssertTrue(1 == self->_turnCount);
    XCTAssertTrue(1 == self->_turnTransferCount);
    XCTAssertEqualObjects(@"Turn of player O", self->_sut.turnIndicatorMessage);
    
    id<TTKPlayer> activePlayerBefore = [self->_sut activePlayer];
    [self->_sut view: self
        didTapOnCell: firstTurnPosition];
    
    
    // THEN
    //
    // TODO : introduce XCTest expectations
    // in case the code becomes asynchronous
    XCTAssertTrue(1 == self->_turnCount);
    XCTAssertTrue(1 == self->_turnTransferCount);
    XCTAssertTrue(1 == self->_turnFailureCount);
    XCTAssertTrue(0 == self->_gameOverCount);
    XCTAssertTrue(0 == self->_afterGameOverCount);
    
    
    
    id<TTKPlayer> activePlayerAfter = [self->_sut activePlayer];
    XCTAssertTrue(activePlayerAfter == activePlayerBefore);
    
    
    XCTAssertTrue([activePlayerBefore isPlayerO]);
    XCTAssertTrue([activePlayerAfter  isPlayerO]);
    
    XCTAssertTrue(2 == [self->_callbacksLog count]);
    XCTAssertEqualObjects(self->_callbacksLog[0], @"Turn success by |X| : {1, 1}");
    XCTAssertEqualObjects(self->_callbacksLog[1], @"Turn failed by |O| : {1, 1}");
    
    XCTAssertEqualObjects(@"Turn of player O", self->_sut.turnIndicatorMessage);
}


// x x o
// o x x
// x o o
-(void)testNoTurnNotificationAfterGameOverDraw
{
    // GIVEN
    self->_field = [TTKMatrixFieldModel new];
    {
        [self->_field takeField: (struct TTKCellPoint){0, 0} byX: YES];
        [self->_field takeField: (struct TTKCellPoint){0, 1} byX: YES];
        [self->_field takeField: (struct TTKCellPoint){0, 2} byX: NO ];
        
        [self->_field takeField: (struct TTKCellPoint){1, 0} byX: NO ];
        [self->_field takeField: (struct TTKCellPoint){1, 1} byX: YES];
        [self->_field takeField: (struct TTKCellPoint){1, 2} byX: YES];
        
        [self->_field takeField: (struct TTKCellPoint){2, 0} byX: YES];
        [self->_field takeField: (struct TTKCellPoint){2, 1} byX: NO ];
        [self->_field takeField: (struct TTKCellPoint){2, 2} byX: NO ];
    }
    
    self->_sut = [[TTKGameVMImpl alloc] initWithField: self->_field
                                              xPlayer: YES
                                            localizer: self->_localizer
                                        imageProvider: self->_imageProvider];
    self->_sut.vcDelegate = self;
    
    struct TTKCellPoint gameOverTurnPosition = {0, 0};
    
    
    // WHEN
    {
        [self->_sut view: self
            didTapOnCell: gameOverTurnPosition];
        
        XCTAssertTrue([self->_field isFieldTakenByX: gameOverTurnPosition]);
        
        
        // TODO : maybe failure should be reported
        XCTAssertTrue(0 == self->_turnCount);
        XCTAssertTrue(0 == self->_turnTransferCount);
        XCTAssertTrue(0 == self->_turnFailureCount);
        XCTAssertTrue(0 == self->_gameOverCount);
        XCTAssertTrue(1 == self->_afterGameOverCount);
        
        XCTAssertEqualObjects(self->_callbacksLog[0], @"Turn after GameOver by |X| : {0, 0}");
        XCTAssertEqualObjects([self->_sut gameOverMessage], @"A draw");
        
        XCTAssertEqualObjects(@"A draw", self->_sut.turnIndicatorMessage);
    }
    
    // and again
    {
        [self->_sut view: self
            didTapOnCell: gameOverTurnPosition];
        
        XCTAssertTrue([self->_field isFieldTakenByX: gameOverTurnPosition]);
        
        XCTAssertTrue(0 == self->_turnCount);
        XCTAssertTrue(0 == self->_turnTransferCount);
        XCTAssertTrue(0 == self->_turnFailureCount);
        XCTAssertTrue(0 == self->_gameOverCount);
        XCTAssertTrue(2 == self->_afterGameOverCount);
        
        XCTAssertEqualObjects(self->_callbacksLog[1], @"Turn after GameOver by |X| : {0, 0}");
        XCTAssertEqualObjects([self->_sut gameOverMessage], @"A draw");
        
        XCTAssertEqualObjects(@"A draw", self->_sut.turnIndicatorMessage);
    }
}

#pragma mark - TTKGameVMDelegate
-(void)viewModelDidDetectGameOver:(id<TTKGameVM>)viewModel
{
    [self->_callbacksLog addObject: @"Game Over"];
    ++self->_gameOverCount;
}

-(void)viewModel:(id<TTKGameVM>)viewModel
didChangeCellState:(struct TTKCellPoint)cellPosition
{
    {
        NSString* turnDescription = [self logMessageForEvent: @"Turn success"
                                                        cell: cellPosition];
        
        [self->_callbacksLog addObject: turnDescription];
    }
    
    ++self->_turnCount;
    self->_lastModifiedCell = cellPosition;
}

-(void)viewModel:(id<TTKGameVM>)viewModel
didTapOnPosessedCell:(struct TTKCellPoint)cellPosition
{
    ++self->_turnFailureCount;
    
    NSString* turnDescription = [self logMessageForEvent: @"Turn failed"
                                                    cell: cellPosition];
    
    [self->_callbacksLog addObject: turnDescription];
}

-(void)viewModel:(id<TTKGameVM>)viewModel
didTapCellAfterGameOver:(struct TTKCellPoint)cellPosition
{
    ++self->_afterGameOverCount;
    
    NSString* turnDescription = [self logMessageForEvent: @"Turn after GameOver"
                                                    cell: cellPosition];
    
    [self->_callbacksLog addObject: turnDescription];
}

-(void)viewModelDidTransferTurn:(id<TTKGameVM>)viewModel
{
    ++self->_turnTransferCount;
}


#pragma mark - Utils
-(NSString*)logMessageForEvent:(NSString*)eventName
                          cell:(struct TTKCellPoint)cellPosition
{
    NSString* playerId = [[self->_sut activePlayer] isPlayerX] ? @"X" : @"O";
    
    NSString* turnDescription =
        [NSString stringWithFormat: @"%@ by |%@| : {%@, %@}",
             eventName,
             playerId,
             @(cellPosition.row),
             @(cellPosition.column)];

    return turnDescription;
}


@end


// - - -
// - - -
// - - -

