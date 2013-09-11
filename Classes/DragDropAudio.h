#import <Foundation/Foundation.h>
#import "Interaction.h"
#import "SPSound.h"
#import "SPSoundChannel.h"

@class InteractionVo;
@class InteractionVoClick;


@interface DragDropAudio : Interaction
{
	
	SPSprite *interaction_sp;
	InteractionVo *data_obj;
	InteractionVoClick *dataClick_obj;
	SPSound *sound;
	SPSoundChannel *channel;

}

- (void) update;


@end