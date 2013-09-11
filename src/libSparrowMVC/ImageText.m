//
//  ImageText.m
//  Ipadsparrow2
//
//  Created by Jose D Perez on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageText.h"
#import "Model.h"
#import "ViewControllerFactory.h"

// --- private interface 

@interface ImageText ()

- (void) populateText;
- (void) addInteractions;
- (void) addImage;


@end


@implementation ImageText


- (id)init
{
    if (self = [super init])
    {
		interaction_sp = [[SPSprite alloc] init];
    }
    return self;
}


- (void) populateText{
	
	NSLog(@"ImageText::populateText %@", data_obj.bodyTextX);

	// textbox sprite
	
	interaction_sp.x=0;
	interaction_sp.y=0;
	
	[self addChild:interaction_sp];
	
	for (int i=0; i<=titles; ++i){
		SPTextField *title = [SPTextField textFieldWithWidth:600 height:100 text:[data_obj.titles objectAtIndex: i]];
		title.hAlign = SPHAlignLeft;
		title.vAlign = SPVAlignTop;
		title.fontSize = 40;
		title.fontName = @"Arial"; 
		title.rotation=-1.57;
		title.color=0xffffff;
		title.x=[[data_obj.titlesX objectAtIndex: i] intValue];
		title.y=[[data_obj.titlesY objectAtIndex: i] intValue];
		[interaction_sp addChild:title];
	}
	 
	 
	// textbox text
	
	for (int i=0; i<=textfields; ++i){
		
		SPTextField *bodyText = [SPTextField textFieldWithWidth:[[data_obj.bodyTextWidth objectAtIndex: i]intValue] 
														 height:[[data_obj.bodyTextHeight objectAtIndex: i]intValue]  
														   text:[data_obj.bodyText objectAtIndex: i]];
		bodyText.hAlign = SPHAlignLeft;
		bodyText.vAlign = SPVAlignTop;
		bodyText.fontSize = [[data_obj.bodyTextSize objectAtIndex: i] intValue];
		bodyText.fontName = @"Arial"; 
		
		NSString *myUnsignedIntString=[data_obj.bodyTextColor objectAtIndex: i];
		long long myLongLong = [myUnsignedIntString longLongValue];
		NSNumber *myNSNumber= [NSNumber numberWithLongLong:myLongLong];
		
		bodyText.color=[myNSNumber unsignedIntValue];
		bodyText.rotation=-1.57;
		bodyText.x=[[data_obj.bodyTextX objectAtIndex: i] intValue];
		bodyText.y=[[data_obj.bodyTextY objectAtIndex: i] intValue];
		
		[interaction_sp addChild:bodyText];	
		
	}
	
}


- (void) addInteractions{
	
	NSLog(@"ImageText::addInteractions");
	
	for (int i=0; i<=buttons; ++i){
		SPTexture* nextButtonTexture = [SPTexture textureWithContentsOfFile:[data_obj.buttonImage objectAtIndex: i]];
		SPButton* button = [SPButton buttonWithUpState:nextButtonTexture text:[data_obj.buttonText objectAtIndex: i]];
		[button addEventListener:@selector(onMouseDown:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];  
		button.x = [[data_obj.buttonX objectAtIndex: i] intValue];
		button.y =[[data_obj.buttonY objectAtIndex: i] intValue];
		button.fontSize=20;
		button.fontName=@"Arial";
		button.rotation=-1.57;
		button.mType= [data_obj.buttonType objectAtIndex: i];
		
		[interaction_sp addChild:button];
	}

}


- (void) addImage{
	NSLog(@"ImageText::addImage");
	
	NSString *str= @"image";

	int objcount=([data_obj.imageUrl count]-1);
	
	for (int i=0; i<=objcount; ++i){
		SPImage* image = [SPImage imageWithContentsOfFile:[data_obj.imageUrl objectAtIndex: i]];
		image.x=[[data_obj.imageX objectAtIndex: i] intValue];
		image.y=[[data_obj.imageY objectAtIndex: i] intValue];
		image.rotation=[[data_obj.imageRotation objectAtIndex: i] floatValue];
		
		NSString *converted = [NSString stringWithFormat:@"%d", i];
		
		str = [str stringByAppendingString:converted];
		
		image.name=str;
		
		[interaction_sp addChild:image];
	}

}



- (void) onMouseDown:(SPEvent*) event
{
	NSString* type= [event.currentTarget getmType];
	
	if ([type isEqualToString:@"nextScenario"]) {
		
		[model nextScenario];
		[_superView removeCurrent];
		
	} else if ([type isEqualToString:@"previousScenario"]){
		[model previousScenario];
		[_superView removeCurrent];		
	} else if ([type isEqualToString:@"skipBack"]){
		
		[model cleanNotesArr];
		[model skipBack:6];
		[_superView removeCurrent];		
	}
	
}


- (void) update 
{
	NSLog(@"ImageText::update");
	
	data_obj=[model xml];
	
	titles=[data_obj.titles count]-1;
	buttons=[data_obj.buttonX count]-1;
	textfields=[data_obj.bodyText count]-1;
	[self addImage];
	[self addInteractions];
	[self populateText];

	[interaction_sp release];
	
}


- (void)dealloc
{
	NSLog(@"ImageText::dealloc::%d",[data_obj retainCount]);
	
	//[data_obj release];
	[interaction_sp release];
    [super dealloc];
	
}

@end

