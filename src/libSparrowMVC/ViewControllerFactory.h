//
//  SuperView.h
//  Ipadsparrow2
//
//  Created by Jose D Perez on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"//;
#import "RevealA.h"//;
#import "ImageText.h"//;
#import "AudioSelectOptions.h"//;
#import "DragDropAudio.h"//;
#import "Model.h"//;




@interface ViewControllerFactory : SPSprite {
	@public
    id model;
	id _app;
	SPSprite *mCurrentScene;
	Boolean *firstTime;
	NSMutableArray *nextActivity;
}

- (id)initWithObjects:(id)_mapp model:(Model*)mModel;


- (void)construct:(NSString*)className;

- (void)removeCurrent;
@end

