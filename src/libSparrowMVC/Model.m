//
//  Model.m
//  Ipadsparrow2
//
//  Created by Jose Perez on 3/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Model.h"


@implementation Model

@synthesize currentScenario;
@synthesize XML;
@synthesize notes_arr;

	- (id)initWithVars:(NSInteger*) mcurrentScenario {
	
		if (self = [super init])
		{
			currentScenario=0;
			notes_arr=[[NSMutableArray alloc] init];
			
		}
	
		return self;
		
	}
//---

	- (id)init
	{
	
		return [self initWithVars:nil];
	}

//---

	- (void) registerView: (id) view
	{
		[super addSubscriber:view];
	
	}

//---

	- (void) unregisterView: (id) view
	{
		[super removeSubscriber:view];
	
	}

//---

	- (id) xml
	{
		NSLog(@"Model::xml::currentScene %d", currentScenario);
		NSString *str= @"Activity";
		NSString *converted = [NSString stringWithFormat:@"%d", currentScenario];
		str = [str stringByAppendingString:converted];
		return [XML contentAt:str];
		
	}


- (id) xmlClick
{
	NSLog(@"Model::xml::currentScene %d", currentScenario);
	NSString *str= @"ClickActivity";
	NSString *converted = [NSString stringWithFormat:@"%d", currentScenario];
	str = [str stringByAppendingString:converted];
	return [XML contentAtClick:str];
	
}
//---

	- (void) loadXML: (NSString*) xmlFile 
	{
		NSLog(@"Model::loadXML %@ ",xmlFile);
		XML=[[XMLParser alloc] initWithContentsOfFile:xmlFile];
		[self startApp];
			
	}	



//---


	-(void) startApp 
	{
		NSLog(@"Model::startApp");
		currentScenario=0;
		[super notifyChanges];
	}


//--- Add a view to the  model's state

	- (void) pushClass: (NSMutableArray*) classNames
	{
		[super addState:classNames];
	
	}

//--- Remove a view from the model's state 

	- (void) removeClass: (NSMutableArray*) classNames
	{
		NSLog(@"Model::removeClass");
		[super removeState:classNames];
	}

//--- Add objects to the Views pool 

	- (void) pushObj: (id) obj
	{
		NSLog(@"Model::pushObj");
		[super storeObjects:obj];
	}


- (void) nextScenario{
	
	NSLog(@"Model::nextScenario %d", currentScenario);
	currentScenario=currentScenario+1;
	

}


- (void) notesArr: (NSString*)string{
	
	[notes_arr addObject:string];
	
	NSLog(@"Model::notesArr %@", notes_arr);
	
}


- (void) cleanNotesArr{
	
	notes_arr=nil;
	
}


- (void) previousScenario{
	
	currentScenario=currentScenario-1;	
}

- (void) skipBack:(NSInteger)n{
	
	currentScenario=currentScenario-n;	
}


- (void) notify {
	
	[super notifyChanges];
}
//---

- (void)dealloc
{
	NSLog(@"Model::dealloc");
	[XML release];
	[notes_arr release];
    [super dealloc];
}

@end
