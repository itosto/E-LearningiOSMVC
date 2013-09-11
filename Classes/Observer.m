//
//  Observer.m
//  Ipadsparrow2
//
//  Created by Jose D Perez on 3/7/11.
//  Copyright 2011 __AllenIteractions__. All rights reserved.
//

#import "Observer.h"


@implementation Observer
//---
	- (id)initWithsubscribersArray:(NSMutableArray*) msubscriberarrArray {
	
		if (self = [super init])
		{
			subscribers= [[NSMutableArray alloc] init];
			objects_arr=[[NSMutableArray alloc] init];
		}
	
		return self;
	
	}

//---
	- (id)init
	{

		return [self initWithsubscribersArray:nil];
	}

//---
	- (BOOL) addSubscriber:(id)classInstance
	{
		
		for (int i=0; i<[subscribers count]; i++) {
			if ([subscribers objectAtIndex: i]==classInstance) 
			{
				return 0;
			}
		}
		
		[subscribers addObject: classInstance];
		return 1;
		
	
	}

//---	
	-(void)storeObjects: (id) obj
	{
		
		
		[objects_arr addObject: obj];
		
	}


//---
	-(void) removeSubscriber:(id)classInstance
	{

		
		for (int i=0; i<([subscribers count]-1); i++) {

			
				
				if ([subscribers objectAtIndex: i]==classInstance) 
				{

					[subscribers removeObjectAtIndex: i];
				}
		}
	
	}

//---
	- (void) removeState:(NSMutableArray*) mc_arr
	{
		NSLog(@"Observer::removeState");
		for (int j=0; j<=([mc_arr count]-1); j++) {
			
			for (int i=0; i<=([subscribers count]-1); i++) {
				
				NSString *className=NSStringFromClass([[subscribers objectAtIndex:i] class]); 
				NSString *className2= [mc_arr objectAtIndex:j];
				
				NSLog(@"Observer::removeState 2a %@", className);
				
				if ([className2 isEqualToString:className]) {
					NSLog(@"Observer::removeState 2b %@", className);
					[[subscribers objectAtIndex:i] removeFromStage];
					[self removeSubscriber:[subscribers objectAtIndex:i]];
				}
			}
		}
	}

//---

	- (void) addState:(NSMutableArray*) mc_arr
	{
		int objcount=([objects_arr count]-1);
		int arraycount=([mc_arr count]-1);
		
	
		for (int j=0; j<= arraycount; ++j) {
			
			for (int i=0; i<=objcount; ++i) {
				
				NSString *className=NSStringFromClass([[objects_arr objectAtIndex:i] class]); 
				NSString *className2= [mc_arr objectAtIndex:j];
				
			
				
				if ([className2 isEqualToString:className]) {
				
					[self addSubscriber:[objects_arr objectAtIndex:i]];

					break;
				}
			}
		}

		[self notifyChanges];
		
		
	}




//---

	- (void) notifyChanges{
		
		NSLog(@"Observer::notifyChanges");
		
		for (int i=0; i<=([subscribers count]-1); i++) {
			
			NSLog(@"Observer::notifyChanges for %@ ", [subscribers objectAtIndex:i]);
			[[subscribers objectAtIndex:i] update];
		}
		
	}


- (void)dealloc
{
	[subscribers release];
	[objects_arr release];

    [super dealloc];
}

@end
