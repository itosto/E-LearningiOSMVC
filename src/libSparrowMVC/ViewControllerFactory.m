//
//  SuperView.m
//  Ipadsparrow2
//
//  Created by Jose D Perez on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerFactory.h"
#import "Interaction.h"
#import "Model.h"

// --- private interface ---------------------------------------------------------------------------

@interface ViewControllerFactory ()

- (void) instantiateImageText;

- (void) remove;

- (void)showScene:(SPSprite *)scene;


@end


@implementation ViewControllerFactory


//---
- (id)initWithObjects:(id)_mapp model:(Model* )mModel;
		
{
	
	if (self = [super init])
	{

		_app=_mapp;
		model=mModel;
		[model registerView:self];
		firstTime=YES;
	}
	
	return self;
	
}


- (void) update{
	
	NSLog(@"ViewControllerFactory::update");
	
	if(firstTime){
		
		NSLog(@"ViewControllerFactory::update if");
		firstTime=FALSE;
		[_app addViews:self]; 
		NSMutableArray *arr=[[NSMutableArray alloc]init];
		[arr addObject: @"Zero"];
		[model pushClass:arr];
		[arr release];
		
	} else {
		
		NSLog(@"ViewControllerFactory::update else");
		
		InteractionVo *specificNode_obj=[model xml];
		
		NSString *className= specificNode_obj.classID;
		
		[self construct: className];
		specificNode_obj=nil;
		[specificNode_obj release];
		
	}
	 
	
}
 
- (void) construct:(NSString*)classStr {
	
	NSLog(@"ViewControllerFactory::construct::%@", classStr);
	
	if ([classStr isEqualToString:@"ImageText"]) {
		
		[self instantiateImageText];
	

	} else if ([classStr isEqualToString:@"RevealA"]){
		
		[self instantiateRevealA];	
		
	} else if ([classStr isEqualToString:@"AudioSelectOptions"]){
		
		[self instantiateAudioSelect];	
		
	} else if ([classStr isEqualToString:@"DragDropAudio"]){
		
		[self instantiateDragDropAudio];	
		
	
	} else if (classStr=NULL){
		
		
	}
		
	classStr=nil;
	[classStr release];

}


- (void) remove
{
	
	[mCurrentScene removeFromStage];
	
	[mCurrentScene removeFromParent];
	
	mCurrentScene = nil;
	
	[mCurrentScene release];
	
	[model notify];
	
	
}

- (void) instantiateImageText
{
	NSLog(@"ViewControllerFactory::instantiateImageText");
	
	SPSprite *scene =[[ImageText alloc]init];
	[scene injectData:self model:model];
    [self showScene:scene];
    [scene release];
}

- (void) instantiateRevealA
{
	NSLog(@"ViewControllerFactory::instantiateRevealA");
	
	SPSprite *scene =[[RevealA alloc]init];
	[scene injectData:self model:model];
    [self showScene:scene];
    [scene release];
}




- (void) instantiateAudioSelect
{
	NSLog(@"ViewControllerFactory::instantiateAudioSelect");
	
	SPSprite *scene =[[AudioSelectOptions alloc]init];
	[scene injectData:self model:model];
    [self showScene:scene];
    [scene release];
}


- (void) instantiateDragDropAudio 
{
	
	NSLog(@"ViewControllerFactory::instantiateDragDropAudio");
	
	SPSprite *scene =[[DragDropAudio alloc]init];
	[scene injectData:self model:model];
    [self showScene:scene];
    [scene release];
	
}


- (void)showScene:(SPSprite *)scene
{
    mCurrentScene = scene;
    [self addChild:scene];
	[mCurrentScene update];

}


- (void)removeCurrent {
	
	[mCurrentScene removeFromStage];
	
	[mCurrentScene removeFromParent];
	
	mCurrentScene = nil;
	
	[mCurrentScene release];
	
	[model notify];
}

- (void)dealloc
{
	
	NSLog(@"ViewControllerFactory::dealloc");
	[mCurrentScene release];
	[model release];
	[_app release];
    [super dealloc];
}

@end

