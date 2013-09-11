#import "ViewControllerFactory.h"
#import "Interaction.h"
#import "Model.h"
#import "VideoPlayer.h"
#import "AudioPlayerMultipleChoice.h"
#import "SummaryOfResults.h"


@interface ViewControllerFactory ()

- (void) instantiateImageText;
- (void) remove;
- (void)showScene:(SPSprite *)scene;


@end


@implementation ViewControllerFactory

@synthesize mCurrentScene;

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


- (void) update
{
	NSLog(@"ViewControllerFactory::update");
	
	if(firstTime){
		firstTime=FALSE;
		[_app addViews:self]; 
		 NSMutableArray *arr=[[NSMutableArray alloc]init];
		[arr addObject: @"Zero"];
		[model pushClass:arr];
		[arr release];
	} else {
		InteractionVo *specificNode_obj=[model xml];
		NSString *className= specificNode_obj.classID;
		[self construct: className];
		specificNode_obj=nil;
		[specificNode_obj release];
	}
}


- (void) construct:(NSString*)classStr
{
	NSLog(@"ViewControllerFactory::construct::%@", classStr);
	
	if ([classStr isEqualToString:@"ImageText"]) {
		
		[self instantiateImageText];
	

	} else if ([classStr isEqualToString:@"RevealA"]){
		
		[self instantiateRevealA];	
		
	} else if ([classStr isEqualToString:@"AudioSelectOptions"]){
		
		[self instantiateAudioSelect];	
		
	} else if ([classStr isEqualToString:@"DragDropAudio"]){
        
		[self instantiateDragDropAudio];	
		
	
	} else if ([classStr isEqualToString:@"VideoPlayer"]){
		
		[self instantiateVideoPlayer];
		
        
	} else if ([classStr isEqualToString:@"AudioPlayerMultipleChoice"]){
		
		[self instantiateAudioPlayerMultipleChoice];
        
    } else if ([classStr isEqualToString:@"SummaryOfResults" ]){
		[self instantiateSummaryOfResults];
		
	} else if ( classStr==NULL ){
		
        
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
	
	Interaction *scene =[[ImageText alloc]init];
	[scene injectData:self model:model mAppMain:_app];
    [self showScene:scene];
    [scene release];
}


- (void) instantiateVideoPlayer
{
	NSLog(@"ViewControllerFactory::instantiateVideoPlayer");
	
	Interaction *scene =[[VideoPlayer alloc]init];
	[scene injectData:self model:model mAppMain:_app];
    [self showScene:scene];
    [scene release];
}

- (void) instantiateRevealA
{
	NSLog(@"ViewControllerFactory::instantiateRevealA");
	
	Interaction *scene =[[RevealA alloc]init];
	[scene injectData:self model:model  mAppMain:_app];
    [self showScene:scene];
    [scene release];
}


- (void) instantiateAudioSelect
{
	NSLog(@"ViewControllerFactory::instantiateAudioSelect");
	
	Interaction *scene =[[AudioSelectOptions alloc]init];
	[scene injectData:self model:model  mAppMain:_app];
    [self showScene:scene];
    [scene release];
}


- (void) instantiateDragDropAudio 
{
	
	NSLog(@"ViewControllerFactory::instantiateDragDropAudio");
	
	Interaction *scene =[[DragDropAudio alloc]init];
	[scene injectData:self model:model mAppMain:_app];
    [self showScene:scene];
    [scene release];
	
}

- (void) instantiateAudioPlayerMultipleChoice
{
    Interaction *scene =[[AudioPlayerMultipleChoice alloc]init];
	[scene injectData:self model:model mAppMain:_app];
    [self showScene:scene];
    [scene release];
    
}

- (void) instantiateSummaryOfResults
{
    Interaction *scene =[[SummaryOfResults alloc]init];
	[scene injectData:self model:model mAppMain:_app];
    [self showScene:scene];
    [scene release];
    
}


- (void)showScene:(Interaction *)scene
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

