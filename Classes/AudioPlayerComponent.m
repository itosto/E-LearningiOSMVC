#import <QuartzCore/QuartzCore.h> // for CACurrentMediaTime


#import "AudioPlayerComponent.h"
#import "SPSound.h"
#import "SPSoundChannel.h"
#import "SPImage.h"
#import "SPButton.h"
#import "SPTexture.h"
#import "SPTextField.h"
#import "SPEnterFrameEvent.h"

@implementation AudioPlayerComponent
@synthesize channel;

- (id)init {
    if (self = [super init]) {
        [self setupSprite];
    }
    return self;
}

- (void)setupSprite {

	interaction_sp = [[SPSprite alloc] init];
    
    SPImage* image = [SPImage imageWithContentsOfFile:@"audio_player_bg.png"];
	
    [self addChild:interaction_sp];
    [interaction_sp addChild:image];
    
    SPTexture* playButtonTexture = [SPTexture textureWithContentsOfFile:@"play.png"];
    SPButton* play_btn = [SPButton buttonWithUpState:playButtonTexture];
    [play_btn addEventListener:@selector(playAudio:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    play_btn.x = 5;
    play_btn.y = 75;
    play_btn.mType = @"play";
    [interaction_sp addChild:play_btn];
    
    SPTexture* pauseButtonTexture = [SPTexture textureWithContentsOfFile:@"pause.png"];
    SPButton* pause_btn = [SPButton buttonWithUpState:pauseButtonTexture];
    [pause_btn addEventListener:@selector(playAudio:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    pause_btn.x = 75;
    pause_btn.y = 73;
    pause_btn.mType = @"pause";
    [interaction_sp addChild:pause_btn];
    
    SPTexture* replayButtonTexture = [SPTexture textureWithContentsOfFile:@"replay.png"];
    SPButton* replay_btn = [SPButton buttonWithUpState:replayButtonTexture];
    [replay_btn addEventListener:@selector(playAudio:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    replay_btn.x = 140;
    replay_btn.y = 78;
    replay_btn.mType = @"replay";
    [interaction_sp addChild:replay_btn];
    
    SPTextField *bodyText = [SPTextField textFieldWithWidth:400 height:60 text:@"0.0"];
    bodyText.hAlign = SPHAlignLeft;
    bodyText.vAlign = SPVAlignTop;
    bodyText.fontSize = 30;
    bodyText.fontName = @"Arial";
    bodyText.name = @"timer";
    

    bodyText.color= 0xFFFFFF;
    bodyText.x = 15;
    bodyText.y = 5;
    
    
    SPTextField *bodyText_sec = [SPTextField textFieldWithWidth:400 height:60 text:@"seconds"];
    bodyText_sec.hAlign = SPHAlignLeft;
    bodyText_sec.vAlign = SPVAlignTop;
    bodyText_sec.fontSize = 30;
    bodyText_sec.fontName = @"Arial";
    bodyText_sec.name = @"segundos";
    
    
    bodyText_sec.color= 0xFFFFFF;;
    bodyText_sec.x = 65;
    bodyText_sec.y = 5;

    
    
    [interaction_sp addChild:bodyText];
    
    [interaction_sp addChild:bodyText_sec];
    
    [interaction_sp release];

}

-(void) playAudio:(SPEvent*) event
{
	NSLog(@"AudioPlayerComponent::playAudio");
    
    NSString* type= [event.currentTarget getmType];
    
	
	if ([type isEqualToString:@"play"] ) {
        
        [channel play];
    }
    
    if ([type isEqualToString:@"pause"]) {
        
        NSLog(@"AudioPlayerComponent::pause %f", audioPlayer.currentTime );
        [channel pause];
    }
    
    if ([type isEqualToString:@"replay"]) {
        
        [channel stop];
        [channel play];
    }
    
}


- (void) onSoundCompleted:(SPEvent*) event
{
	NSLog(@"AudioPlayerComponent::onSoundCompleted");
	
	[channel stop];
	//[channel removeEventListenersAtObject:self forType:SP_EVENT_TYPE_SOUND_COMPLETED];	
}

- (void) injectData:(NSString *)mfile_url {
    file_url = mfile_url;
    sound = [SPSound soundWithContentsOfFile:file_url];
    channel= [[sound createChannel] retain];    
    channel.volume = 1.0f;
    [channel addEventListener:@selector(onSoundCompleted:) atObject:self forType:SP_EVENT_TYPE_SOUND_COMPLETED];
    channel.loop = YES;
    audioPlayer = [channel getMPlayer];
    
    [self addEventListener:@selector(onEnterFrameTimer:) atObject:self
                           forType:SP_EVENT_TYPE_ENTER_FRAME];
    
    [channel play];
}

-(void) onEnterFrameTimer:(SPEnterFrameEvent *)event
 {
     float roundedValue = round(10.0f * audioPlayer.currentTime) / 10.0f;
     NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
     [formatter setMaximumFractionDigits:1];
     [formatter setRoundingMode: NSNumberFormatterRoundUp];
     
     NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:roundedValue]];
     [formatter release];
     
    NSString *str= @"";
    str = [str stringByAppendingString:numberString];
     [[interaction_sp childByName:@"timer"]setText:str];
}

- (void)dealloc
{
	NSLog(@"AudioPlayerComponent::dealloc");
    [channel stop];
     channel = nil;
    [channel release];
    sound = nil;
    [sound release];
    [audioPlayer release];
    [super dealloc];
}

@end
