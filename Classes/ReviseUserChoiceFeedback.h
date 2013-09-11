//
//  SummaryChoiceFeedback.h
//  Sparrow
//
//  Created by Jose D Perez-Diaz on 9/16/12.
//
//

#import "SPSprite.h"
#import "UserAnswerData.h"
#import "ReviseUserChoiceButton.h"
#import "AudioPlayerComponent.h"

@interface ReviseUserChoiceFeedback : ReviseUserChoiceButton{
    @protected
    AudioPlayerComponent *player;
}


@end
