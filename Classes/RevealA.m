//
//  RevealA.m
//  Ipadsparrow2
//
//  Created by jperez-diaz on 5/11/11.
//  Copyright 2011 JDTechSolutions. All rights reserved.
//

#import "RevealA.h"
#import "Model.h"
#import "ViewControllerFactory.h"




// --- private interface ---------------------------------------------------------------------------

@interface RevealA ()

- (void)setupSprite;
- (void) initializeInteraction;

@end

// --- class implementation ------------------------------------------------------------------------

@implementation RevealA

- (id)init {
    if (self = [super init]) {
        [self setupSprite];        
    }
    return self;
}

- (void)setupSprite {
	
	interaction_sp = [[SPSprite alloc] init];
}




- (void) populateText{
	
	NSLog(@"RevealA::populateText %@", data_obj.bodyTextX);
	
	// textbox sprite
	
	interaction_sp.x=0;
	interaction_sp.y=0;
	
	[self addChild:interaction_sp];
	
	for (int i=0; i<=titles; ++i){
		SPTextField *title = [SPTextField textFieldWithWidth:600 height:50 text:[data_obj.titles objectAtIndex: i]];
		title.hAlign = SPHAlignLeft;
		title.vAlign = SPVAlignTop;
		title.fontSize = 40;
		title.fontName = @"Arial"; 
		title.rotation=-1.57;
		title.color=0xffffff;
		title.x=[[data_obj.titlesX objectAtIndex: i] intValue];
		title.y=[[data_obj.titlesY objectAtIndex: i] intValue];
		
		NSString *str= @"title";
		NSString *converted = [NSString stringWithFormat:@"%d", i];
		
		str = [str stringByAppendingString:converted];
		
		title.name=str;
		
		
		[interaction_sp addChild:title];
	}
	
	NSLog(@"RevealA::populateText B");
	// textbox text
	
	for (int i=0; i<=textfields; ++i){
		
		SPTextField *bodyText = [SPTextField textFieldWithWidth:[[data_obj.bodyTextWidth objectAtIndex: i]intValue] 
														 height:[[data_obj.bodyTextHeight objectAtIndex: i]intValue]  
														   text:[data_obj.bodyText objectAtIndex: i]];
		bodyText.hAlign = SPHAlignLeft;
		bodyText.vAlign = SPVAlignTop;
		bodyText.fontSize = [[data_obj.bodyTextSize objectAtIndex: i] intValue];
		bodyText.fontName = @"Arial"; 
		
		//NSString *myUnsignedIntString=[data_obj.bodyTextColor objectAtIndex: i];
		//long long myLongLong = [myUnsignedIntString longLongValue];
		//NSNumber *myNSNumber= [NSNumber numberWithLongLong:myLongLong];
		
		bodyText.color=0xffffff;
		
		//[myNSNumber unsignedIntValue];
		
		bodyText.rotation=-1.57;
		bodyText.x=[[data_obj.bodyTextX objectAtIndex: i] intValue];
		bodyText.y=[[data_obj.bodyTextY objectAtIndex: i] intValue];
		
		
		NSString *str= @"bodytext";
		NSString *converted = [NSString stringWithFormat:@"%d", i];
		
		str = [str stringByAppendingString:converted];
		
		bodyText.name=str;
		
		[interaction_sp addChild:bodyText];	
		
	}
	
	//NSLog(@"RevealA::populateText ------------------------ %@",[[interaction_sp childByName:@"bodytext1"] text]);
	//[[interaction_sp childByName:@"bodytext1"] setText:@"My text"];
	
}


- (void) addInteractions{
	
	NSLog(@"RevealA::addInteractions");
	
	
	
	
	//mNextButton = [[SPButton alloc] initWithUpState:nextButtonTexture text:[data_obj.buttonText objectAtIndex: 0]];
	
	
	for (int i=0; i<=buttons; ++i){
		SPTexture* nextButtonTexture = [SPTexture textureWithContentsOfFile:[data_obj.buttonImage objectAtIndex: i]];
		SPButton* button = [SPButton buttonWithUpState:nextButtonTexture text:[data_obj.buttonText objectAtIndex: i]];
		[button addEventListener:@selector(onMouseDown:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];   
		
		button.x = [[data_obj.buttonX objectAtIndex: i] intValue];
		button.y =[[data_obj.buttonY objectAtIndex: i] intValue];
		button.fontSize=15;
		button.fontName=@"Arial";
		button.rotation=-1.57;
		button.mType= [data_obj.buttonType objectAtIndex: i];
		
		NSString *str= @"button";
		NSString *converted = [NSString stringWithFormat:@"%d", i];
		
		str = [str stringByAppendingString:converted];
		
		button.name=str;
		
		[interaction_sp addChild:button];
		
	}
	
	
	for (int i=0; i<=clicks; ++i){
		SPTexture* clickTexture = [SPTexture textureWithContentsOfFile:[dataClick_obj.clickImage objectAtIndex: i]];
		SPButton* click = [SPButton buttonWithUpState:clickTexture text:[dataClick_obj.clickText objectAtIndex: i]];
		[click addEventListener:@selector(onMouseDown:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];   
		
		click.x = [[dataClick_obj.clickX objectAtIndex: i] intValue];
		click.y =[[dataClick_obj.clickY objectAtIndex: i] intValue];
		click.fontSize=[[dataClick_obj.clickfontSize objectAtIndex: i] intValue];;
		click.fontName=@"Arial";
		click.rotation=-1.57;
		click.mType= [dataClick_obj.clickType objectAtIndex: i];
		
		NSString *str= @"button";
		NSString *converted = [NSString stringWithFormat:@"%d", i];
		
		str = [str stringByAppendingString:converted];
		
		click.name=str;
		
		[interaction_sp addChild:click];
		
	}
	
}


- (void) addImage{
	NSLog(@"RevealA::addImage");
	
	int objcount=([data_obj.imageUrl count]-1);
	
	for (int i=0; i<=objcount; ++i){
		SPImage* image = [SPImage imageWithContentsOfFile:[data_obj.imageUrl objectAtIndex: i]];
		
		
		image.x=[[data_obj.imageX objectAtIndex: i] intValue];
		image.y=[[data_obj.imageY objectAtIndex: i] intValue];
		image.rotation=[[data_obj.imageRotation objectAtIndex: i] floatValue];
		
		NSString *str= @"image";
		NSString *converted = [NSString stringWithFormat:@"%d", i];
		
		str = [str stringByAppendingString:converted];
		
		image.name=str;
		
		NSLog(@"RevealA::addImage %@", image.name);
		
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
		
	} else if ([type isEqualToString:@"save"]){

		[self clickManager:event];
		
		
	}
	
}


- (void) clickManager: (SPEvent*) event
{
	[[interaction_sp childByName:@"image1"] setVisible:YES];
	[[interaction_sp childByName:@"bodytext2"] setVisible:YES];
	[[interaction_sp childByName:@"title0"] setVisible:YES];
	[[interaction_sp childByName:@"bodytext2"] setText:[event.currentTarget text]];
	[[interaction_sp childByName:@"bodytext2"] setColor:0x000000];
	[[interaction_sp childByName:@"bodytext2"] setX:[[interaction_sp childByName:@"title0"] x]+75];
	[model notesArr:[event.currentTarget text]];
	
	
}


- (void) initializeInteraction{
	
	[[interaction_sp childByName:@"image1"] setVisible:NO];
	[[interaction_sp childByName:@"bodytext2"] setVisible:NO];
	[[interaction_sp childByName:@"title0"] setVisible:NO];
	[interaction_sp swapChildAtIndex:[interaction_sp childIndex:[interaction_sp childByName:@"image1"]] withChildAtIndex:[interaction_sp childIndex:[interaction_sp childByName:@"bodytext1"]]];
	[interaction_sp swapChildAtIndex:[interaction_sp childIndex:[interaction_sp childByName:@"image1"]] withChildAtIndex:[interaction_sp childIndex:[interaction_sp childByName:@"title0"]]];
	[[interaction_sp childByName:@"bodytext2"] setRotation:[[interaction_sp childByName:@"image1"] rotation]];
	[[interaction_sp childByName:@"title0"] setRotation:[[interaction_sp childByName:@"image1"] rotation]];
	
	NSLog(@"RevealA::initializeInteraction %f", [[interaction_sp childByName:@"image1"] rotation]);
	
}


- (void) update 
{
	NSLog(@"RevealA::update");
	
	data_obj=[model xml];
	dataClick_obj=[model xmlClick];
	
	
	titles=[data_obj.titles count]-1;
	buttons=[data_obj.buttonX count]-1;
	textfields=[data_obj.bodyText count]-1;
	
	clicks=[dataClick_obj.clickX count]-1;
	
	[self addImage];
	[self addInteractions];
	[self populateText];
	
	[interaction_sp release];
	[self initializeInteraction ];
	
}


- (void)dealloc {
	[interaction_sp release];
    [super dealloc];
}

@end

