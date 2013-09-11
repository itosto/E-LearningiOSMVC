//
//  XMLParser.h
//  Ipadsparrow2
//
//  Created by Jose Perez on 3/3/11.
//  Copyright 2011 __AllenInteractions__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class InteractionVo;

//#ifdef __IPHONE_4_0
@interface XMLParser : NSObject <NSXMLParserDelegate>
//#else
//@interface XMLParser : NSObject
//#endif

{
	@public NSMutableDictionary *intXML;
	
	@private NSMutableArray* buttonText;
	NSMutableArray *bodyTextSize;
	NSMutableArray *bodyTextColor;
	NSMutableArray *bodyTextWidth;
	NSMutableArray *bodyTextHeight;
	NSMutableArray *buttonX;
	NSMutableArray *buttonY;
	NSMutableArray* buttonType;
	NSMutableArray* buttonURL;
	NSMutableArray *buttonImage;
	NSMutableArray *titles;
	NSMutableArray *titlesX;
	NSMutableArray *titlesY;
	NSMutableArray *bodyText;
	NSMutableArray* bodyTextX;
	NSMutableArray* bodyTextY;	
	NSString *intID;
	NSMutableString *currentStringValue;
	NSMutableString *classID;
	NSMutableArray* imageUrl;	
	NSMutableArray* imageX;	
	NSMutableArray* imageY;	
	NSMutableArray* imageRotation;	
	NSMutableArray *clickText;
	NSMutableArray *clickX;
	NSMutableArray *clickY;
	NSMutableArray *clickType;
	NSMutableArray *clickURL;
	NSMutableArray *clickImage;
	NSMutableArray *clickfontSize;
	NSMutableArray *clickPopText;
	NSMutableArray *clickCorrect;
	
	
	
}
- (id) initWithContentsOfFile:(NSString *) path;
- (InteractionVo*) contentAt: (NSString *) name;
- (void)addNode:(InteractionVo *)node withName:(NSString *)name;



@end


