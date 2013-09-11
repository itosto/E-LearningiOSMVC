#import <Foundation/Foundation.h>
#import "Interaction.h"
#import "SPSound.h"

@class InteractionVo;
@class InteractionVoClick;

@interface AudioSelectOptions : Interaction {
	
	SPSprite *interaction_sp;
	InteractionVo *data_obj;
	InteractionVoClick *dataClick_obj;
	SPSound *sound;
	SPSoundChannel *channel;
	NSInteger nextPop;
}

- (void) update;



@property (nonatomic,assign) NSInteger nextPop;

@end
