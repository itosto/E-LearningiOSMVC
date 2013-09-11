#import <Foundation/Foundation.h>
#import "SPSprite.h"
#import "Model.h"

@interface Interaction : SPSprite
{

	@protected
	NSInteger titles;
	NSInteger buttons;
	NSInteger textfields;
	NSInteger clicks;
    
	Model * model;
	id _superView;
    id appMain;
	
}

- (void) removeFromStage;
- (void) orientationChanged;
- (void) willLeavetoAnotherModule;
- (void) injectData:(id)_msuperView model:(Model*)mModel mAppMain:(id) appMain;
- (void) initializeInteraction;
- (void) update;

@property (nonatomic,assign) NSInteger titles;
@property (nonatomic,assign) NSInteger buttons;
@property (nonatomic,assign) NSInteger textfields;
@property (nonatomic,assign) NSInteger clicks;

@end

