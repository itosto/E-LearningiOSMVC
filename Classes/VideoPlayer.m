#import "VideoPlayer.h"
#import "Model.h"
#import "ViewControllerFactory.h"
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation VideoPlayer


- (void) onMouseDown:(SPEvent*) event
{
	NSString* type= [event.currentTarget getmType];
    
	
	if ([type isEqualToString:@"nextScenario"]) {
        
        if(moviePlayerController !=nil){
            
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:MPMoviePlayerPlaybackDidFinishNotification
                                                          object:moviePlayerController];
            [moviePlayerController stop];
            [moviePlayerController.view removeFromSuperview];
        }
        
		[model nextScenario];
		[_superView removeCurrent];
		
	} else if ([type isEqualToString:@"previousScenario"]){
		[model previousScenario];
		[_superView removeCurrent];
	} else if ([type isEqualToString:@"skipBack"]){
		
		[model cleanNotesArr];
		[model skipBack:6];
		[_superView removeCurrent];
        
	}  else if ([type isEqualToString:@"nextActivity"]){
        
        
        [interaction_sp removeAllChildren];
        
        
        //        [interaction_sp removeChild:[interaction_sp childByName:@"button1"]];
        //
        //        [[interaction_sp childByName:@"button1"] release];
        //
        //        [event.currentTarget removeEventListener:@selector(onMouseDown:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
        //
        //        for (int i=0; i<=buttons; ++i){
        //
        //
        //        }
        
		//[_superView removeCurrent];
        int n = [[interaction_data_obj.buttonURL objectAtIndex: [event.currentTarget index]] intValue];
        [appMain remove:n];
        
        if(moviePlayerController !=nil){
            
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:MPMoviePlayerPlaybackDidFinishNotification
                                                          object:moviePlayerController];
            [moviePlayerController stop];
            [moviePlayerController.view removeFromSuperview];
        }

        [self release];
        
	} else if([type isEqualToString:@"video"]){
        
        NSString* str = [interaction_data_obj.buttonURL objectAtIndex: [event.currentTarget index]];
         _x = [[interaction_data_obj.buttonX objectAtIndex: [event.currentTarget index]]intValue];
         _y =  [[interaction_data_obj.buttonY objectAtIndex: [event.currentTarget index]]intValue];
        
        NSLog(@"here is my string:: %@", str);
        
        [self instantiateVideo: str];
        
        //[str release];
            
    }
}


- (void) willLeavetoAnotherModule{
    
    if(moviePlayerController !=nil){
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:moviePlayerController];
        [moviePlayerController stop];
        [moviePlayerController.view removeFromSuperview];
    }
    
    [self release];
}



- (void) didDetectTap: (UITapGestureRecognizer *)tap {

    if ( didDoubleTapped ) {
        [moviePlayerController play];
        didDoubleTapped = NO;
    } else {
        [moviePlayerController pause];
        didDoubleTapped = YES;

    }
    
}

- (void) instantiateVideo: (NSString *) str {
    NSString *filepath   =   [[NSBundle mainBundle] pathForResource:str ofType:@"m4v"];
    NSURL    *fileURL    =   [NSURL fileURLWithPath:filepath];
    
    moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlaybackComplete:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:moviePlayerController];
    
    
    [moviePlayerController.view setFrame:CGRectMake(0,0,640,480)];
    
    moviePlayerController.controlStyle = MPMovieControlStyleNone;
   // moviePlayerController.controlStyle = MPMovieControlModeVolumeOnly;
    moviePlayerController.view.userInteractionEnabled = YES;
    
    [moviePlayerController setFullscreen:NO animated:NO];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDetectTap:)];
    tapGesture.numberOfTapsRequired = 2;
    [moviePlayerController.view addGestureRecognizer:tapGesture];
    [tapGesture release];
    
    didDoubleTapped = NO;
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    
    NSLog(@"here %i", deviceOrientation);
    
    if (deviceOrientation == UIDeviceOrientationFaceUp )
    {
        NSLog(@"UIDeviceOrientationFaceDown");
        
        [[moviePlayerController view] setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
        [moviePlayerController.view setFrame:CGRectMake(768 - 480 - _y,
                                                        _x,
                                                        480,
                                                        640)];
        
    }
    
    if (deviceOrientation ==  UIDeviceOrientationFaceDown)
    {
        NSLog(@"UIDeviceOrientationFaceUp");
        [[moviePlayerController view] setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
        [moviePlayerController.view setFrame:CGRectMake(768 - 480 - _y,
                                                        _x,
                                                        480,
                                                        640)];
    }
    
    
    if (deviceOrientation == UIDeviceOrientationLandscapeRight )
    {

         NSLog(@"VideoPlayer::UIDeviceOrientationLandscapeLeft");
        
        [[moviePlayerController view] setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
        [moviePlayerController.view setFrame:CGRectMake(768 - 480 - _y,
                                                        _x,
                                                        480,
                                                        640)];

    }
    
    if (deviceOrientation ==  UIDeviceOrientationLandscapeLeft )
    {
        
         NSLog(@"VideoPlayer:: UIDeviceOrientationLandscapeRight");
        
        [[moviePlayerController view] setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
        
        [moviePlayerController.view setFrame:CGRectMake(_y,
                                                        1024 - 640 - _x,
                                                        480,
                                                        640)];
    }
    
    
    [[appMain nativeView] addSubview:moviePlayerController.view];
    
    [moviePlayerController play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willEnterFullScreen:)
                                                 name:MPMoviePlayerWillEnterFullscreenNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieEventFullscreenHandler:)
                                                 name:MPMoviePlayerDidEnterFullscreenNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieEventExitFullscreenHandler:)
                                                 name:MPMoviePlayerDidExitFullscreenNotification
                                               object:nil];
    
    //[appMain removeOrientationChangesObserver];
    
}

- (void) willEnterFullScreen:(NSNotification*)notification {
    NSLog(@"willEnterFullScreen");
    //[moviePlayerController setFullscreen:NO animated:NO];
    //[moviePlayerController setControlStyle:MPMovieControlStyleEmbedded];
}


- (void)movieEventFullscreenHandler:(NSNotification*)notification {
    NSLog(@"movieEventFullscreenHandler");
     UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    
    if (deviceOrientation == UIDeviceOrientationLandscapeLeft ){
        //[[UIDevice currentDevice] performSelector:NSSelectorFromString(@"setOrientation:") withObject:(id)UIDeviceOrientationLandscapeRight];
    }
    
    if (deviceOrientation == UIDeviceOrientationLandscapeRight ){
        //[[UIDevice currentDevice] performSelector:NSSelectorFromString(@"setOrientation:") withObject:(id)UIDeviceOrientationLandscapeLeft];
    }
    
   
    moviePlayerController.controlStyle = MPMovieControlStyleNone;
   [moviePlayerController setFullscreen:NO animated:NO];
   [moviePlayerController setControlStyle:MPMovieControlStyleNone];
   //[[UIDevice currentDevice] performSelector:NSSelectorFromString(@"setOrientation:") withObject:(id)UIInterfaceOrientationPortrait];
    
}

- (void)movieEventExitFullscreenHandler:(NSNotification*)notification {
    NSLog(@"movieEventExitFullscreenHandler");
    //[[UIDevice currentDevice] performSelector:NSSelectorFromString(@"setOrientation:") withObject:(id)UIInterfaceOrientationLandscapeRight];
    //[[UIDevice currentDevice] performSelector:NSSelectorFromString(@"setOrientation:") withObject:(id)UIInterfaceOrientationPortrait];
    //[appMain onDeviceOrientationChanged: notification];
    
}


- (void) orientationChanged{
    
    NSLog(@"VideoPlayer:: Device Orientation changed: ");
    
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    
    if (deviceOrientation == UIDeviceOrientationPortrait ||
        deviceOrientation == UIDeviceOrientationPortraitUpsideDown)
    {
        
    }
    
    if (deviceOrientation == UIDeviceOrientationLandscapeRight )
    {
        NSLog(@"VideoPlayer:: Device Orientation changed:: LandscapeLeft: %i", deviceOrientation);
        if(moviePlayerController!=nil){
            [[moviePlayerController view] setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
            [moviePlayerController.view setFrame:CGRectMake(768 - 480 - _y,
                                                            _x,
                                                            480,
                                                            640)];
        }
        
    }
    
    if (deviceOrientation ==  UIDeviceOrientationLandscapeLeft )
    {
        NSLog(@"VideoPlayer:: Device Orientation changed: LandscapeRight::  %i", deviceOrientation);
        if(moviePlayerController!=nil){

            [[moviePlayerController view] setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
            [moviePlayerController.view setFrame:CGRectMake(_y,
                                                            1024 - 640 - _x,
                                                            480,
                                                            640)];
        }
       
    }

}


- (void)moviePlaybackComplete:(NSNotification *)notification
{
    MPMoviePlayerController *moviePlayerController_obj = [notification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
													name:MPMoviePlayerPlaybackDidFinishNotification
												  object:moviePlayerController];
	
    [moviePlayerController_obj.view removeFromSuperview];
     moviePlayerController_obj = nil;
    [moviePlayerController_obj release];
}

- (void)dealloc
{
	NSLog(@"VideoPlayer::dealloc::");
	
	//[data_obj release];
     moviePlayerController = nil;
    [moviePlayerController release];
	
    [super dealloc];
	
}

@end
