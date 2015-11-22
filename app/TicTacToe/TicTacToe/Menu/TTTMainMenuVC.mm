//
//  ViewController.m
//  TicTacToe
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import "TTTMainMenuVC.h"

#import "TTTMainMenuLocalizer.h"

// TODO : extract to router class during refactoring
#import "TTTGameVC.h"
#import <TicTacToeKit/GameScene/Field/TTKMatrixFieldModel.h>
#import <TicTacToeKit/GameScene/TTKGameVMImpl.h>

@interface TTTMainMenuVC ()

@property (nonatomic, weak) IBOutlet UIButton* firstPlayerButton ;
@property (nonatomic, weak) IBOutlet UIButton* secondPlayerButton;
@property (nonatomic, weak) IBOutlet UIView  * buttonsContainer  ;

@end

@implementation TTTMainMenuVC


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self cleanupStoryboardStubs];
    [self setupColours];
    [self setupLocalizations];
}

-(void)setupColours
{
    id<TTTMenuTheme> theme = [[TTTColorThemeBuilder currentTheme] menuTheme];
    {
        UIColor* buttonBack = [theme buttonBackgroundColor];
        self.firstPlayerButton .backgroundColor = buttonBack;
        self.secondPlayerButton.backgroundColor = buttonBack;

        // Keeping default tint color for now
        //
        //
//        UIColor* fontColor = [theme buttonTextColor];
//        self.firstPlayerButton.tintColor = fontColor;
//        self.secondPlayerButton.tintColor = fontColor;
    }
}

-(void)setupLocalizations
{
    [self.firstPlayerButton setTitle: NSLocalizedString(@"MENU_BUTTON_X", nil)
                            forState: UIControlStateNormal];
    
    [self.secondPlayerButton setTitle: NSLocalizedString(@"MENU_BUTTON_O", nil)
                             forState: UIControlStateNormal];
}

-(void)cleanupStoryboardStubs
{
    self.view              .backgroundColor = [UIColor whiteColor];
    self.firstPlayerButton .backgroundColor = [UIColor clearColor];
    self.secondPlayerButton.backgroundColor = [UIColor clearColor];
    self.buttonsContainer  .backgroundColor = [UIColor clearColor];
}


#pragma mark - actions
-(void)prepareForSegue:(UIStoryboardSegue*)segue
                sender:(id)sender
{
    BOOL isXSelected = NO;
    
    NSString* segueName = segue.identifier;
    if ([segueName isEqualToString: @"PlayerXSeg"])
    {
        isXSelected = YES;
    }
    else if ([segueName isEqualToString: @"PlayerOSeg"])
    {
        isXSelected = NO;
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu-zero-variadic-macro-arguments"
        NSAssert(NO, @"Unexpected segue");
#pragma clang diagnostic pop
        return;
    }
    
    
    // TODO : extract to router class if more destinations come up
    TTTGameVC* gameScreen = objc_member_of_cast<TTTGameVC>(segue.destinationViewController);
    id<TTKFieldState, TTKMutableFieldState> fieldModel = [TTKMatrixFieldModel new];
    id<TTKGameOverLocalizer> localizer = [TTTMainMenuLocalizer new];
    id<TTKCellImageProvider> imageProvider = [[TTTColorThemeBuilder currentTheme] cellTheme];
    
    TTKGameVMImpl* viewModel = [[TTKGameVMImpl alloc] initWithField: fieldModel
                                                            xPlayer: isXSelected
                                                          localizer: localizer
                                                      imageProvider: imageProvider];
    
    gameScreen.viewModel = viewModel;
}

-(IBAction)onFirstPlayerButtonTapped:(id)sender
{
//    NSAssert(NO, @"not implemented");
}

-(IBAction)secondPlayerButtonTapped:(id)sender
{
//    NSAssert(NO, @"not implemented");
}

@end
