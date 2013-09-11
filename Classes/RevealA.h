//
//  RevealA.h
//  Ipadsparrow2
//
//  Created by jperez-diaz on 5/11/11.
//  Copyright 2011 JDTechSolutions. All rights reserved.
//

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
