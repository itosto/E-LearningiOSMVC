//
//  AudioSelectOptions.m
//  Ipadsparrow2
//
//  Created by jperez-diaz on 5/24/11.
//  Copyright 2011 My Company. All rights reserved.
//

#import "AudioSelectOptions.h"
#import "Model.h"
#import "ViewControllerFactory.h"
#import "InteractionVo.h"
#import "InteractionVoClick.h"



// --- private interface ---------------------------------------------------------------------------

@interface AudioSelectOptions ()

- (void)setupSprite;
- (void) initializeInteraction;
- (void) clickManager: (SPEvent*) event;

@end


@implementation AudioSelectOptions


@synthesize nextPop;

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
	
	NSLog(@"AudioSelectOptions::populateText %@", data_obj.bodyTextX);
	
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
	
	NSLog(@"AudioSelectOptions::populateText B");
	// textbox text
	
	for (int i=0; i<=textfields; ++i){
		
		SPTextField *bodyText = [SPTextField textFieldWithWidth:[[data_obj.bodyTextWidth objectAtIndex: i]intValue] 
														 height:[[data_obj.bodyTextHeight objectAtIndex: i]intValue]  
														   text:[data_obj.bodyText objectAtIndex: i]];
		bodyText.hAlign = SPHAlignCenter;
		bodyText.vAlign = SPVAlignTop;
		bodyText.fontSize = [[data_obj.bodyTextSize objectAtIndex: i] intValue];
		bodyText.fontName = @"Arial"; 
		
		//NSString *myUnsignedIntString=[data_obj.bodyTextColor objectAtIndex: i];
		//long long myLongLong = [myUnsignedIntString longLongValue];
		//NSNumber *myNSNumber= [NSNumber numberWithLongLong:myLongLong];
		
		bodyText.color=0x003366;
		
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
	
	NSArray *a=[model notes_arr];
	
	NSInteger l=[a count];
	
	
	NSLog(@"AudioSelectOptions::populate text array %@", a);
	
	for (int i=0; i<l;i++){
		NSMutableString *text = [[NSMutableString alloc] init];
		
		NSString* str=[[interaction_sp childByName:@"bodytext1"] text];
		
		NSLog(@"AudioSelectOptions::populate text stringText %@", str);
		
		[text appendString:[NSString stringWithFormat:@"%@ \r%@",str,[a objectAtIndex:i]]];
		
		[[interaction_sp childByName:@"bodytext1"] setText: text];
		
		//[text release];
		
		
		
	}
	
}


- (void) addInteractions{
	
	NSLog(@"AudioSelectOptions::addInteractions");
	
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
		click.fontColor=0xffffff;
		click.rotation=-1.57;
		click.mType= [dataClick_obj.clickType objectAtIndex: i];
		
		SPRectangle *rect=[[SPRectangle alloc ]initWithX:50 y:20 width:200 height:50];
		click.textBounds=  rect;
		
		NSString *str= @"click";
		NSString *converted = [NSString stringWithFormat:@"%d", i];
		
		str = [str stringByAppendingString:converted];
		
		click.name=str;
		
		[interaction_sp addChild:click];
		
		//[rect release];
		
	}
	
	
}


- (void) addImage{
	NSLog(@"AudioSelectOptions::addImage");
	
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
		
		NSLog(@"AudioSelectOptions::addImage %@", image.name);
		
		[interaction_sp addChild:image];
		
	}
	
}



- (void) onMouseDown:(SPEvent*) event
{
	NSString* type= [event.currentTarget getmType];
	
	if ([type isEqualToString:@"nextScenario"]) {
		
		[channel stop];
		channel=nil;
		sound=nil;
		[model nextScenario];
		[_superView removeCurrent];		
		
	} else if ([type isEqualToString:@"previousScenario"]){
		
		[channel stop];
		channel=nil;
		sound=nil;
		[model previousScenario];
		[_superView removeCurrent];		
		
	} else if ([type isEqualToString:@"save"]){
		
		[self clickManager:event];
		
	}
	
}


- (void) clickManager: (SPEvent*) event
{
	[event.currentTarget removeEventListenersAtObject:self forType:SP_EVENT_TYPE_TRIGGERED];
	
	[model notesArr:[dataClick_obj.clickPopText objectAtIndex:nextPop]];
	
	NSMutableString *text = [[NSMutableString alloc] init];
	
	NSString* str=[[interaction_sp childByName:@"bodytext1"] text];
	
	[text appendString:[NSString stringWithFormat:@"%@ \r%@",str,[dataClick_obj.clickPopText objectAtIndex:nextPop]]];
	
	[[interaction_sp childByName:@"bodytext1"] setText: text];
	
	//[text release];
	
	
}

-(void) playPop:(NSInteger)next
{
	NSLog(@"AudioSelectOptions::playPop");
	
	NSString *str= @"click";
	
	NSString *converted = [NSString stringWithFormat:@"%d", next];
	
	str = [str stringByAppendingString:converted];

	[[interaction_sp childByName:str] setVisible:YES];
	
	sound = [SPSound soundWithContentsOfFile:[dataClick_obj.clickURL objectAtIndex:next]];
	
	channel= [[sound createChannel] retain];
	
    //channel= [ sound createChannel ];
	channel.volume = 0.6f;
	
	[channel addEventListener:@selector(onSoundCompleted:) atObject:self
					 forType:SP_EVENT_TYPE_SOUND_COMPLETED];
	
	[channel play];
	
	
}


- (void) onSoundCompleted:(SPEvent*) event
{
	NSLog(@"AudioSelectOptions::onSoundCompleted");
	
	NSString *str= @"click";
	
	NSString *converted = [NSString stringWithFormat:@"%d", nextPop];
	
	str = [str stringByAppendingString:converted];
	
	nextPop++;
	[channel stop];
	[channel removeEventListenersAtObject:self forType:SP_EVENT_TYPE_SOUND_COMPLETED];
	
	if(nextPop>=(clicks+1)){
		
		[[interaction_sp childByName:@"button0"] setVisible:YES];
		
	} else {
	
		[self playPop:nextPop];
	}
	
	if(nextPop>=2){
		
		SPTween *tween = [SPTween tweenWithTarget:[interaction_sp childByName:str] time:0.5f];
		
		[tween animateProperty:@"alpha"  targetValue:0.0f];
		
		[self.stage.juggler addObject:tween];
	}
}

- (void) initializeInteraction{
	
	NSLog(@"AudioSelectOptions::initializeInteraction");
	[[interaction_sp childByName:@"image0"] setAlpha:1];
	[[interaction_sp childByName:@"click1"] setVisible:NO];
	[[interaction_sp childByName:@"click2"] setVisible:NO];
	[[interaction_sp childByName:@"click3"] setVisible:NO];
	[[interaction_sp childByName:@"click4"] setVisible:NO];
	[[interaction_sp childByName:@"button0"] setVisible:NO];
	[[interaction_sp childByName:@"bodytext1"] setRotation:-1.54];
	[[interaction_sp childByName:@"bodytext1"] setX:[[interaction_sp childByName:@"image2"]x]+70];
	[[interaction_sp childByName:@"bodytext1"] setHAlign: SPHAlignLeft];
	
	nextPop=0;
	
	[self playPop:nextPop];
	
	
}




- (void) update 
{
	NSLog(@"AudioSelectOptions::update");
	
	data_obj=[model xml];
	dataClick_obj=[model xmlClick];
	
	
	titles=[data_obj.titles count]-1;
	buttons=[data_obj.buttonX count]-1;
	textfields=[data_obj.bodyText count]-1;
	
	clicks=[dataClick_obj.clickX count]-1;
	
	[self addImage];
	[self populateText];
	[self addInteractions];
	[interaction_sp release];
	[self initializeInteraction ];
	
}


- (void)dealloc {
	NSLog(@"AudioSelectOptions::dealloc");
	
	[interaction_sp release];
	[sound release];
	[channel release];
    [super dealloc];
}


@end
