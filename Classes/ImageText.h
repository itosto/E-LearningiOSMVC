#import <Foundation/Foundation.h>
#import "InteractionVo.h"
#import "Interaction.h"

@interface ImageText : Interaction {

	
@protected
	SPSprite *interaction_sp;
	InteractionVo *interaction_data_obj;
    InteractionVo *data_obj;
	InteractionVoClick *dataClick_obj;


}


- (void) update;


@end
