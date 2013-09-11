#import "ReviseUserChoiceFeedback.h"
#import "SPImage.h"
#import "SPButton.h"
#import "SPTexture.h"
#import "SPTextField.h"
#import "AudioPlayerComponent.h"


@implementation ReviseUserChoiceFeedback

- (void)setupSprite {
   interaction_sp = [[SPSprite alloc] init];
    [self addChild:interaction_sp];
    
    SPImage* image = [SPImage imageWithContentsOfFile:@"summary_feedback_bg.png"];
    [interaction_sp addChild:image];
    
    
    SPTexture* nextButtonTexture = [SPTexture textureWithContentsOfFile:@"close.png"];
    SPButton* button = [SPButton buttonWithUpState:nextButtonTexture];
    [button addEventListener:@selector(close:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    [interaction_sp addChild:button];
    button.x = 716;
    button.y = 184;
    
    
    NSString *str= @"Revisa la Pregunta ";
	NSString *converted = [NSString stringWithFormat:@"%d", choice_num];
	str = [str stringByAppendingString:converted];
    
    SPTextField *title_txt = [SPTextField textFieldWithWidth:400
                                                     height:100
                                                       text:str];
    title_txt.hAlign = SPHAlignLeft;
    title_txt.vAlign = SPVAlignTop;
    title_txt.fontSize = 24;
    title_txt.fontName = @"Arial";
    
    title_txt.color= 0x009ACD;
    title_txt.x=310;
    title_txt.y=210;
    
    [interaction_sp addChild:title_txt];
    
    str = @"Tu contestación: ";
    str = [str stringByAppendingString:choice_data.your_answer];

    
    SPTextField *your_answer_txt = [SPTextField textFieldWithWidth:400
                                                      height:100
                                                        text:str];
    your_answer_txt.hAlign = SPHAlignLeft;
    your_answer_txt.vAlign = SPVAlignTop;
    your_answer_txt.fontSize = 16;
    your_answer_txt.fontName = @"Arial";
    
    your_answer_txt.color= 0x000000;
    your_answer_txt.x=310;
    your_answer_txt.y=250;
    
    [interaction_sp addChild:your_answer_txt];
    
    
    str = @"Contestación correcta: ";
    str = [str stringByAppendingString:choice_data.correct_answer_text];
    
    SPTextField *correct_answer_txt = [SPTextField textFieldWithWidth:400
                                                            height:100
                                                              text:str];
    correct_answer_txt.hAlign = SPHAlignLeft;
    correct_answer_txt.vAlign = SPVAlignTop;
    correct_answer_txt.fontSize = 16;
    correct_answer_txt.fontName = @"Arial";
    
    correct_answer_txt.color= 0x000000;
    correct_answer_txt.x=310;
    correct_answer_txt.y=290;
    
    [interaction_sp addChild:correct_answer_txt];
    
    str = @"Observaciones adicionales: ";
    str = [str stringByAppendingString:choice_data.feedback];
    
    SPTextField *observations_txt = [SPTextField textFieldWithWidth:400
                                                               height:200
                                                                 text:str];
    observations_txt.hAlign = SPHAlignLeft;
    observations_txt.vAlign = SPVAlignTop;
    observations_txt.fontSize = 16;
    observations_txt.fontName = @"Arial";
    
    observations_txt.color= 0x000000;
    observations_txt.x=310;
    observations_txt.y=320;
    
    [interaction_sp addChild:observations_txt];
    
    player = [[AudioPlayerComponent alloc] init];
    [player injectData:choice_data.audio_file];
    [interaction_sp addChild:player];
    
    player.x = 365;
    player.y = 400;

}

- (void) close:(SPEvent*) event
{
    [player release];
    [self.parent removeChild: self];
    
    
}

@end
