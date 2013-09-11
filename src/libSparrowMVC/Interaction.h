//
//  Interaction.h
//  Ipadsparrow2
//
//  Created by Jose D Perez on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"

@interface Interaction : SPSprite {

	@protected
	NSInteger titles;
	NSInteger buttons;
	NSInteger textfields;
	NSInteger clicks;

	id model;
	id _superView;
	
}

- (void) removeFromStage;
- (void) injectData:(id)_msuperView model:(id )mModel;

@property (nonatomic,assign) NSInteger titles;
@property (nonatomic,assign) NSInteger buttons;
@property (nonatomic,assign) NSInteger textfields;
@property (nonatomic,assign) NSInteger clicks;

@end

