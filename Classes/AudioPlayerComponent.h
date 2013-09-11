#import <AVFoundation/AVFoundation.h>
#import "SPDisplayObject.h"
#import "SPSound.h"
#import "SPSprite.h"

@interface AudioPlayerComponent : SPSprite{
    
@protected
    SPSound *sound;
	SPSoundChannel *channel;
    NSString *file_url;
    SPSprite *interaction_sp;
    AVAudioPlayer *audioPlayer;

}
- (id)init;
- (void) injectData: (NSString *) mfile_url;
- (void) playAudio:(SPEvent*) event;

@property (nonatomic, copy) SPSoundChannel *channel;

@end
