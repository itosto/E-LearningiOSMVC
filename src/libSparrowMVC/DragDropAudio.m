//
//  DragDropAudio.m
//  Ipadsparrow2
//
//  Created by jperez-diaz on 5/25/11.
//  Copyright 2011 My Company. All rights reserved.
//

#import "DragDropAudio.h"
#import "Model.h"
#import "ViewControllerFactory.h"
#import "InteractionVo.h"
#import "InteractionVoClick.h"


// --- private interface ---------------------------------------------------------------------------

@interface DragDropAudio ()

- (void)setupSprite;
- (void) initializeInteraction;
-(void) showfeedback:(NSInteger*)correct;


@end


@implementation DragDropAudio

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
	
	NSLog(@"DragDropAudio::populateText %@", data_obj.bodyTextX);
	
	// textbox sprite
	
	interaction_sp.x=0;
	interaction_sp.y=0;
	
	[self addChild:interaction_sp];
	
	for (int i=0; i<=titles; ++i){
		
		SPTextField *title = [SPTextField textFieldWithWidth:400 height:100 text:[data_obj.titles objectAtIndex: i]];
		title.hAlign = SPHAlignCenter;
		title.vAlign = SPVAlignTop;
		title.fontSize = 18;
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
	
	NSLog(@"DragDropAudio::populateText B");
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
	
	
}


- (void) addInteractions{
	
	NSLog(@"DragDropAudio::addInteractions");
	
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
		
		SPSprite* clicks_sp = [[SPSprite alloc] init];
		
		SPTexture* clickTexture = [SPTexture textureWithContentsOfFile:[dataClick_obj.clickImage objectAtIndex: i]];
		
		SPButton* click = [SPButton buttonWithUpState:clickTexture text:[dataClick_obj.clickText objectAtIndex: i]];
		
		[click addEventListener:@selector(onMouseDown:) atObject:self forType:SP_EVENT_TYPE_TOUCH];   
		
		[click addEventListener:@selector(onMouseUp:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED]; 
		
		
		SPTexture* audioClickTexture = [SPTexture textureWithContentsOfFile:@"listenbtn.png"];
		
		SPButton* audioClick = [SPButton buttonWithUpState:audioClickTexture text:@""];
		
		audioClick.rotation=-1.57;
		audioClick.mId=i;
		audioClick.mType=@"audio";
		
		[audioClick addEventListener:@selector(onMouseDown:) atObject:self forType:SP_EVENT_TYPE_TOUCH];   
		
		audioClick.y=-5;
		
		
		//clicks_sp.x = [[dataClick_obj.clickX objectAtIndex: i] intValue];
		
		//clicks_sp.y =[[dataClick_obj.clickY objectAtIndex: i] intValue];
		
		
		click.fontSize=[[dataClick_obj.clickfontSize objectAtIndex: i] intValue];;
		click.fontName=@"Arial";
		click.fontColor=0xffffff;
		click.rotation=-1.57;
		click.mType= [dataClick_obj.clickType objectAtIndex: i];
		click.mCorrect=[[dataClick_obj.clickCorrect objectAtIndex: i] intValue];;
		click.oldX=[[dataClick_obj.clickX objectAtIndex: i] intValue];
		click.oldY=[[dataClick_obj.clickY objectAtIndex: i] intValue];
		click.mId=i;
		
		
		SPRectangle *rect=[[SPRectangle alloc ]initWithX:67 y:20 width:200 height:60];
		click.textBounds=  rect;
		
		NSString *str= @"click";
		NSString *converted = [NSString stringWithFormat:@"%d", i];
		
		str = [str stringByAppendingString:converted];
		
		click.name=str;
		
		[clicks_sp addChild:click];
		
		[clicks_sp addChild:audioClick];
	
		
		str=@"sheet";
		
		str = [str stringByAppendingString:converted];
		
		TouchSheet *sheet1 = [[TouchSheet alloc] initWithSprite:clicks_sp];  
		
		sheet1.x =  [[dataClick_obj.clickX objectAtIndex: i] intValue];
		
		sheet1.y = [[dataClick_obj.clickY objectAtIndex: i] intValue];  
		
		sheet1.name= str;
		
		[interaction_sp addChild:sheet1];
		
		[rect release];
		
		[clicks_sp release];
		
		
	}
	
	
}



- (void) addImage{
	NSLog(@"DragDropAudio::addImage");
	
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
		
	} else if ([type isEqualToString:@"audio"]){
		
		NSInteger val=[event.currentTarget mId];
		[self playPop:val];
		
	} else if ([type isEqualToString:@"drag"]){
		
		[self dragManager:event];

	}
	
}


- (void) onMouseUp:(SPEvent*) event{
	NSLog(@"DragDropAudio::onMouseUp %i", [event.currentTarget oldX]);
	SPDisplayObject *target_obj = (SPDisplayObject *)event.target;
	NSInteger xVal=[event.currentTarget oldX];
	NSInteger yVal=[event.currentTarget oldY];
	
	//target_obj.parent.parent.x=xVal;
	//target_obj.parent.parent.y=yVal;
	
	SPTween *tween = [SPTween tweenWithTarget:target_obj.parent.parent time:1.0f];
	
	[tween animateProperty:@"x"  targetValue:xVal];
	[tween animateProperty:@"y"  targetValue:yVal];
	
	[self.stage.juggler addObject:tween];
}


-(void) playPop:(NSInteger)next
{
	NSLog(@"DragDropAudio::playPop %@", [dataClick_obj.clickURL objectAtIndex:next]);
	
	[channel stop];
	
	sound = [SPSound soundWithContentsOfFile:[dataClick_obj.clickURL objectAtIndex:next]];
	
	channel= [[sound createChannel] retain];
	
	channel.volume = 0.6f;
	
	[channel addEventListener:@selector(onSoundCompleted:) atObject:self
					  forType:SP_EVENT_TYPE_SOUND_COMPLETED];
	
	[channel play];
	
	
}

-(void) playConclusion:(NSInteger)next
{
	NSLog(@"DragDropAudio::playPop %@", [dataClick_obj.clickPopText objectAtIndex:next]);
	
	[channel stop];
	
	sound = [SPSound soundWithContentsOfFile:[dataClick_obj.clickPopText objectAtIndex:next]];
	
	channel= [[sound createChannel] retain];
	
	channel.volume = 0.6f;
	
	[channel addEventListener:@selector(onSoundCompleted:) atObject:self
					  forType:SP_EVENT_TYPE_SOUND_COMPLETED];
	
	[channel play];
	
	
}


- (void) onSoundCompleted:(SPEvent*) event
{
	NSLog(@"DragDropAudio::onSoundCompleted");
	

}

- (void) initializeInteraction{
	
	NSLog(@"DragDropAudio::initializeInteraction");
	
	[[interaction_sp childByName:@"button0"] setVisible:NO];
	[[interaction_sp childByName:@"image5"] setVisible:YES];
	[interaction_sp swapChildAtIndex:[interaction_sp childIndex:[interaction_sp childByName:@"image5"]] 
					withChildAtIndex:[interaction_sp childIndex:[interaction_sp childByName:@"sheet5"]]];
	
	[[interaction_sp childByName:@"bodytext2"] setVisible:NO];
	[[interaction_sp childByName:@"bodytext3"] setVisible:NO];
	[[interaction_sp childByName:@"image5"] setVisible:NO];
	

}


-(void)dragManager:(SPEvent*) event{
	
	[event.target addEventListener:@selector(onEnterFrame:) atObject:self
				   forType:SP_EVENT_TYPE_ENTER_FRAME];
	
}

-(void) showfeedback:(NSInteger)correct
{
	[[interaction_sp childByName:@"image5"] setVisible:YES];
	[[interaction_sp childByName:@"button0"] setVisible:YES];
	
	if(correct==0){
		[[interaction_sp childByName:@"bodytext3"] setVisible:YES];
	}else{
		[[interaction_sp childByName:@"bodytext2"] setVisible:YES];
	}
	
	
}


// the corresponding event listener
- (void) onEnterFrame:(SPEnterFrameEvent *)event 
{
	
	SPRectangle *bounds1 = [event.target boundsInSpace: self];
	
	SPRectangle *bounds2 = [[interaction_sp childByName:@"image4"]boundsInSpace: self];
	 
	NSLog(@"Time passed since last frame: %f", [[interaction_sp childByName:@"image4"]x]);

	
	if ([bounds1 intersectsRectangle:bounds2]){
		
		SPDisplayObject *target_obj = (SPDisplayObject *)event.target;
		
		NSLog(@"------------------Collision %i", [target_obj.parent.parent.parent mCorrect] );
		
		//[event.target setX:[[interaction_sp childByName:@"image4"]x]];
	
		
		
		target_obj.parent.parent.parent.parent.parent.x=[[interaction_sp childByName:@"image4"]x]+50;
		target_obj.parent.parent.parent.parent.parent.y=[[interaction_sp childByName:@"image4"]y]+128;
		
		[event.currentTarget removeEventListenersAtObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
		[event.currentTarget removeEventListenersAtObject:self forType:SP_EVENT_TYPE_TOUCH];
	
		
		[self showfeedback:[target_obj.parent.parent.parent mCorrect]];
		[self playConclusion:[target_obj.parent.parent.parent mId]];
		
	} else {
		
		[event.target removeEventListenersAtObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
		//[event.target setY:100];

	}
	
}


- (void) update 
{
	NSLog(@"DragDropAudio::update");
	
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
	NSLog(@"DragDropAudio::dealloc");
	
	[interaction_sp release];
	[sound release];
	[channel release];
    [super dealloc];
}


@end
