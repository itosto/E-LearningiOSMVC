//
//  InteractionVoPop.m
//  Ipadsparrow2
//
//  Created by jperez-diaz on 5/24/11.
//  Copyright 2011 My Company. All rights reserved.
//

#import "InteractionVoClick.h"


@implementation InteractionVoClick


@synthesize clickText;
@synthesize clickX;
@synthesize clickY;
@synthesize clickType;
@synthesize clickURL;
@synthesize clickImage;
@synthesize clickfontSize;
@synthesize classID;
@synthesize clickPopText;
@synthesize clickCorrect;


- (id)initWithText:(NSMutableArray *)mclickText 
			  clickX:(NSMutableArray *)mclickX
			  clickY:(NSMutableArray *)mclickY
		   clickType:(NSMutableArray *)mclickType 
			clickURL:(NSMutableArray *)mclickURL
		  clickImage:(NSMutableArray *)mclickImage
		  clickfontSize:(NSMutableArray *)mclickfontSize
		clickPopText:(NSMutableArray *)mclickPopText
		clickCorrect:(NSMutableArray *)mclickCorrect
		   classID: (NSMutableString*)mclassID;

{
    if (self = [super init])
    {
		clickText=mclickText;
		clickX=mclickX;
		clickY=mclickY;
		clickType=mclickType;
		clickURL=mclickURL;
		clickImage=mclickImage;
		clickfontSize=mclickfontSize;
		clickPopText=mclickPopText;
		clickCorrect=mclickCorrect;
		classID=mclassID;
		
		NSLog(@"0000000000000000 %@", clickText);
		
		
    }
	
    return self;
}

- (void)dealloc
{
	[clickText release];
	[clickPopText release];
	[clickCorrect release];
	[clickX release];
	[clickY release];
	[clickType release];
	[clickURL release];
	[clickImage release];
	[classID release];
    [super dealloc];
}

@end
