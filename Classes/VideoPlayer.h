//
//  VideoPlayer.h
//  Sparrow
//
//  Created by Jose D Perez-Diaz on 8/19/12.
//
//

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
