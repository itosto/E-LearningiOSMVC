//
//  AudioPlayerMultipleChoice.m
//  Sparrow
//
//  Created by Jose D Perez-Diaz on 9/3/12.
//
//

#import "AudioPlayerMultipleChoice.h"
#import "SPSound.h"
#import "SPSoundChannel.h"
#import "AudioPlayerComponent.h"
#import "Model.h"
#import "ViewControllerFactory.h"
#import "UserAnswerData.h"


@implementation AudioPlayerMultipleChoice

- (void) initializeInteraction{

    player = [[AudioPlayerComponent alloc] init];
    [player injectData:[dataClick_obj.clickURL objectAtIndex:0] ];
    [interaction_sp addChild:player];
    
    player.x = 100;
    player.y = 400;
    
	//[self playAudio:nextPop];
}
- (void) willLeavetoAnotherModule{
    NSLog(@"AudioPlayerMultipleChoice::willLeavetoAnotherModule");
    [self release];
}


- (void) onMouseDown:(SPEvent*) event
{
	NSString* type= [event.currentTarget getmType];
    
	
	if ([type isEqualToString:@"nextScenario"]) {
        
        UserAnswerData * obj = [[[UserAnswerData alloc] init] autorelease];
        obj.audio_file = [dataClick_obj.clickURL objectAtIndex:event.currentTarget.mId];
        obj.your_answer = [dataClick_obj.clickText objectAtIndex:event.currentTarget.mId];
        obj.correct_answer_eval = [dataClick_obj.clickCorrect objectAtIndex:event.currentTarget.mId];
        obj.feedback = [dataClick_obj.clickPopText objectAtIndex:event.currentTarget.mId];
        
        for (int i=0; i<=clicks; ++i){
            NSString * str = [dataClick_obj.clickCorrect objectAtIndex:i];
            if ( [str isEqualToString: @"1" ]){
                obj.correct_answer_text = [dataClick_obj.clickText objectAtIndex:i];
            }
        }
        
        NSString *str= @"obj";
        NSString *converted = [NSString stringWithFormat:@"%d", model.currentScenario];
        str = [str stringByAppendingString:converted];
        
        [model dataArr:obj withName: str];
		[model nextScenario];
		[_superView removeCurrent];
		
	} else if ([type isEqualToString:@"previousScenario"]){
		[model previousScenario];
		[_superView removeCurrent];
        
	} else if ([type isEqualToString:@"skipBack"]){
		
		[model cleanDataArr];
		[model skipBack:6];
		[_superView removeCurrent];
        
	}  else if ([type isEqualToString:@"nextActivity"]){
        
        [interaction_sp removeAllChildren];
        int n = [[interaction_data_obj.buttonURL objectAtIndex: [event.currentTarget index]] intValue];
        [appMain remove:n];
	}
}


- (void)dealloc
{
	NSLog(@"AudioPlayerMultipleChoice::dealloc");
    [player release];
    [super dealloc];
	
}
@end
