#import "ImageText.h"
#import <MediaPlayer/MediaPlayer.h>

@interface VideoPlayer : ImageText {
    @protected
    MPMoviePlayerController *moviePlayerController;
    
    BOOL didDoubleTapped;
    float _x;
    float _y;
}

@end
