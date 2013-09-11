//
//  Interaction.m
//  Ipadsparrow2
//
//  Created by Jose D Perez on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Interaction.h"
#import "Model.h"


@implementation Interaction

@synthesize titles;
@synthesize buttons;
@synthesize textfields;
@synthesize clicks;

	- (void) removeFromStage 
	{
		model=nil;
		[model release];
		[_superView removeChild:self];
	
	}


- (void) injectData:(id)_msuperView
                    model:(id)mModel
                    mAppMain:(id) _appMain;
		
	{
		
		NSLog(@"Interaction::InjectData:: %@",_msuperView );
		_superView=_msuperView;
		model=mModel;
        appMain = _appMain;
		//[model pushObj: self];

	}

- (void) orientationChanged{
    
}

- (void) willLeavetoAnotherModule{
    
}

- (void) initializeInteraction{
    
}

- (void)dealloc
{
    [super dealloc];
	
}

@end