//
//  ImageText.h
//  Ipadsparrow2
//
//  Created by Jose D Perez on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interaction.h"//;
#import "InteractionVo.h"//;


@interface ImageText : Interaction {

	
@private
	SPSprite *interaction_sp;
	InteractionVo *data_obj;


}


- (void) update;


@end
