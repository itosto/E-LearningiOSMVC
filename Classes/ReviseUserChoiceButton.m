#import "ReviseUserChoiceButton.h"
#import "SPImage.h"
#import "SPButton.h"
#import "SPTexture.h"
#import "SummaryChoiceTapped.h"
#import "SPTextField.h"

@implementation ReviseUserChoiceButton
@synthesize choice_data;
@synthesize choice_num;

- (id)init {
    if (self = [super init]) {
        [self setupSprite];
    }
    return self;
}


//---
- (id)initWithData:(UserAnswerData *) summary choice_num:(int)mchoice_num

{
	
	if (self = [super init])
	{
        choice_num = mchoice_num;
        choice_data = summary;
        [self setupSprite];

	}
	
	return self;
	
}
- (void)setupSprite {
        
    interaction_sp = [[SPSprite alloc] init];
    SPTexture* playButtonTexture;
    
    if ([choice_data.correct_answer_eval isEqualToString:@"1"] ){
      playButtonTexture = [SPTexture textureWithContentsOfFile:@"correct_bg.png"];
    } else {
        playButtonTexture = [SPTexture textureWithContentsOfFile:@"incorrect_bg.png"];
    }
	
    
    NSString *str= @"Revisar melodía ";
	NSString *converted = [NSString stringWithFormat:@"%d", choice_num];
	str = [str stringByAppendingString:converted];

    
    SPButton* choice_btn = [SPButton buttonWithUpState:playButtonTexture text: str];
    [choice_btn addEventListener:@selector(tappedChoice:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    choice_btn.fontColor = 0x000000;
    choice_btn.fontSize = 14;
    choice_btn.fontName = @"Arial";
    
    [self addChild:interaction_sp];
    [interaction_sp addChild:choice_btn];
  
}

- (void) tappedChoice:(SPEvent*) event{
    
    SummaryChoiceTapped *dispatch_event = [[SummaryChoiceTapped alloc]
                                           initWithType:EVENT_TYPE_SUMMARY_CHOICE_TAPPED data:choice_data bubbles:YES];
    [self dispatchEvent:dispatch_event];
    [dispatch_event release];
    
}

- (void) dealloc {
    [interaction_sp release];
    [super dealloc];
    
}


@end
