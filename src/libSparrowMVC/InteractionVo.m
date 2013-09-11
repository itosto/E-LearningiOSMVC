//
//  InteractionVo.m
//  Ipadsparrow2
//
//  Created by Jose Perez on 3/3/11.
//  Copyright 2011 __AllenInteractions__. All rights reserved.
//

#import "InteractionVo.h"


@implementation InteractionVo

@synthesize bodyText;
@synthesize bodyTextSize;
@synthesize bodyTextColor;
@synthesize titles;
@synthesize titlesX;
@synthesize titlesY;
@synthesize buttonText;
@synthesize buttonX;
@synthesize buttonY;
@synthesize bodyTextHeight;
@synthesize bodyTextWidth;
@synthesize bodyTextX;
@synthesize bodyTextY;
@synthesize buttonType;
@synthesize buttonURL;
@synthesize buttonImage;
@synthesize classID;
@synthesize imageX;
@synthesize imageUrl;
@synthesize imageY;
@synthesize imageRotation;

- (id)initWithText:(NSMutableArray*)mbodyText 
	  bodyTextSize:(NSMutableArray *) mbodyTextSize
		bodyTextColor:(NSMutableArray*)mbodyTextColor
		bodyTextWidth:(NSMutableArray*)mbodyTextWidth
		bodyTextHeight:(NSMutableArray*)mbodyTextHeight
		titles:(NSMutableArray* )mtitles 
		titlesX:(NSMutableArray*) mtitlesX
		titlesY:(NSMutableArray*) mtitlesY
		buttonText:(NSMutableArray*)mbuttonText 
		buttonX:(NSMutableArray *)mbuttonX
		buttonY:(NSMutableArray *)mbuttonY
		bodyTextX:(NSMutableArray*)mbodyTextX
        bodyTextY:(NSMutableArray*)mbodyTextY 
		buttonType:(NSMutableArray*)mbuttonType 
		buttonURL:(NSMutableArray*)mbuttonURL
	    buttonImage:(NSMutableArray *)mbuttonImage
		  imageUrl:(NSMutableArray*)mimageUrl
			imageX:(NSMutableArray*)mimageX
			imageY:(NSMutableArray*)mimageY
			imageRotation:(NSMutableArray*) mimageRotation
		   classID: (NSMutableString*)mclassID;
{
    if (self = [super init])
    {
        bodyText=mbodyText ;
		bodyTextSize=mbodyTextSize;
        titles=mtitles;
		titlesX=mtitlesX;
		titlesY=mtitlesY;
        buttonText =mbuttonText;
		bodyTextColor=mbodyTextColor;
		bodyTextWidth=mbodyTextWidth;
		bodyTextHeight=mbodyTextHeight;
		buttonX=mbuttonX;
		buttonY=mbuttonY;
		bodyTextX =mbodyTextX;
        bodyTextY =mbodyTextY;   
		buttonType=mbuttonType;
		buttonURL=mbuttonURL;
		buttonImage=mbuttonImage;
		imageUrl=mimageUrl;
		imageX=mimageX;
		imageY=mimageY;
		imageRotation=mimageRotation;
		classID=mclassID;

    }
	
    return self;
}

- (void)dealloc
{
	NSLog(@"InteractionVo::dealloc %d", [buttonText retainCount]);

	[bodyText release];
	[bodyTextSize release];
	[bodyTextColor release];
	[bodyTextWidth release];
	[bodyTextHeight release];
	[titles release];
	[titlesX release];
	[titlesY release];
	[buttonText release];
	[buttonX release];
	[buttonY release];
	[bodyTextX release];
	[bodyTextY release];
	[buttonType release];
	[buttonURL release];
	[buttonImage release];
	[classID release];
	[imageUrl release];
	[imageX release];	
	[imageY release];
	[imageRotation release];
    [super dealloc];
}

@end
