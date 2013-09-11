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


- (void) injectData:(id)_msuperView model:(id )mModel;
		
	{
		
		NSLog(@"Interaction::InjectData:: %@",_msuperView );
		_superView=_msuperView;
		model=mModel;
		//[model pushObj: self];

	}



- (void)dealloc
{
	NSLog(@" +++++++ ______-------Interaction::dealloc::%i", [model retainCount] );
	
	[model release];
	//[titles release];
	
	//[_superView release];
   //[super dealloc];
	
}

@end



/*
 
 
 

 
 
 
 
 */