//
//  ImageText.h
//  Ipadsparrow2
//
//  Created by Jose D Perez on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

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
