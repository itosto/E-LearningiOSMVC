#import "Interaction.h"

@class InteractionVo;
@class InteractionVoClick;

@interface RevealA : Interaction {
	SPSprite *interaction_sp;
	InteractionVo *data_obj;
	InteractionVoClick *dataClick_obj;
}

- (void) update;

@end
