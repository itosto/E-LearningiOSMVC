//
//  AudioSelectOptions.h
//  Ipadsparrow2
//
//  Created by jperez-diaz on 5/24/11.
//  Copyright 2011 My Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interaction.h"//

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
