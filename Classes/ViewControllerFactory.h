#import <Foundation/Foundation.h>
#import "Sparrow.h"
#import "RevealA.h"
#import "ImageText.h"
#import "AudioSelectOptions.h"
#import "DragDropAudio.h"


@interface ViewControllerFactory : SPSprite
{
    @public
    Interaction *mCurrentScene;
    
	@private 
	id model;
	id _app;
	
	Boolean *firstTime;
	NSMutableArray *nextActivity;
}

- (id)initWithObjects:(id)_mapp model:(Model*)mModel;

- (void)construct:(NSString*)className;

- (void)removeCurrent;

@property (strong, nonatomic) Interaction *mCurrentScene;

@end

