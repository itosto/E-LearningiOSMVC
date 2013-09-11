//
//  XMLParser.m
//  Ipadsparrow2
//
//  Created by Jose Perez on 3/3/11.
//  Copyright 2011 JDTechSolutions. All rights reserved.
//

#import "XMLParser.h"
#import "InteractionVo.h"
#import "InteractionVoClick.h"
#import "SPStage.h"


@interface XMLParser()

- (void)parseInteractionXml:(NSString*)path;
- (void)addClickNode:(InteractionVoClick *)node withName:(NSString *)name;
- (void)removeXtraCharacters;

@end


@implementation XMLParser


- (id)initWithContentsOfFile:(NSString *)path
{
	if (self = [super init])
    {
		//Object containing all xml nodes
        intXML = [[NSMutableDictionary alloc] init];
		
		//Arrays contaning xml text 
		buttonText = [[NSMutableArray alloc] init];
		bodyTextColor = [[NSMutableArray alloc] init];
		buttonX = [[NSMutableArray alloc] init];
		buttonY = [[NSMutableArray alloc] init];
		bodyTextX = [[NSMutableArray alloc] init];	
		bodyTextY = [[NSMutableArray alloc] init];
		bodyTextHeight=[[NSMutableArray alloc] init];
		bodyTextWidth=[[NSMutableArray alloc] init];
		buttonType = [[NSMutableArray alloc] init];
		buttonURL = [[NSMutableArray alloc] init];
		buttonImage = [[NSMutableArray alloc] init];
		imageUrl=[[NSMutableArray alloc] init];
		imageX=[[NSMutableArray alloc] init];
		imageY=[[NSMutableArray alloc] init];
		imageRotation=[[NSMutableArray alloc] init];
		titles=[[NSMutableArray alloc] init];
		titlesX=[[NSMutableArray alloc] init];
		titlesY=[[NSMutableArray alloc] init];
		bodyText=[[NSMutableArray alloc] init];
		bodyTextSize=[[NSMutableArray alloc] init];
		classID=[[NSMutableString alloc] initWithCapacity:50];
		
		clickText= [[NSMutableArray alloc] init];
		clickX= [[NSMutableArray alloc] init];
		clickY= [[NSMutableArray alloc] init];
		clickType= [[NSMutableArray alloc] init];
		clickURL= [[NSMutableArray alloc] init];
		clickImage= [[NSMutableArray alloc] init];
		clickfontSize= [[NSMutableArray alloc] init];
		clickPopText= [[NSMutableArray alloc] init];
		clickCorrect= [[NSMutableArray alloc] init];
		
        [self parseInteractionXml:path];
		
    }
	
    return self;  
}

- (id)init
{
    return [self initWithContentsOfFile:nil];
}

- (void)parseInteractionXml:(NSString *)path
{
    SP_CREATE_POOL(pool);
    
    if (!path) return;
    
    float scale = [SPStage contentScaleFactor];
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:path withScaleFactor:scale];
    NSURL *xmlUrl = [NSURL fileURLWithPath:fullPath];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlUrl];
    xmlParser.delegate = self;    
    BOOL success = [xmlParser parse];
    
    SP_RELEASE_POOL(pool);
    
    if (!success)    
        [NSException raise:SP_EXC_FILE_INVALID 
                    format:@"could not parse xml file %@. Error code: %d, domain: %@", 
		 path, xmlParser.parserError.code, xmlParser.parserError.domain];
	
    [xmlParser release];    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
		namespaceURI:(NSString *)namespaceURI 
		qualifiedName:(NSString *)qName 
		attributes:(NSDictionary *)attributeDict 
{
	
    if ([elementName isEqualToString:@"scenario"])
    {
		NSLog(@"XMLParser::didStartElement:classID");
		
        [classID appendString:[attributeDict valueForKey:@"classID"]];
		
		intID= [attributeDict valueForKey:@"id"];
        return;
	}	
	
	if ([elementName isEqualToString:@"bodyText"]){
		
		NSLog(@"XMLParser::didStartElement:bodyText");
		[bodyTextSize addObject:[attributeDict valueForKey:@"size"]];
		[bodyTextX addObject:[attributeDict valueForKey:@"x"]];
		[bodyTextY addObject:[attributeDict valueForKey:@"y"]];	
		[bodyTextColor addObject:[attributeDict valueForKey:@"color"]];	
		[bodyTextWidth addObject:[attributeDict valueForKey:@"w"]];	
		[bodyTextHeight addObject:[attributeDict valueForKey:@"h"]];
        return;
	}	
	
	if ([elementName isEqualToString:@"title"]){
		
		NSLog(@"XMLParser::didStartElement:title");
		[titlesX addObject:[attributeDict valueForKey:@"x"]];
		[titlesY addObject:[attributeDict valueForKey:@"y"]];
        return;
	}	
	
	if ([elementName isEqualToString:@"image"]){
		
		NSLog(@"XMLParser::didStartElement:image");
		[imageX addObject:[attributeDict valueForKey:@"x"]];
		[imageY addObject:[attributeDict valueForKey:@"y"]];
		[imageRotation addObject:[attributeDict valueForKey:@"rotation"]];
        return;
	}
	
	if ([elementName isEqualToString:@"button"]){
		
		[buttonX addObject:[attributeDict valueForKey:@"x"]];
		[buttonY addObject:[attributeDict valueForKey:@"y"]];
		[buttonImage addObject:[attributeDict valueForKey:@"image"]];
        return;
	}
	
	if ([elementName isEqualToString:@"click"]){
		NSLog(@"XMLParser::didStartElement:click");
		[clickX addObject:[attributeDict valueForKey:@"x"]];
		[clickY addObject:[attributeDict valueForKey:@"y"]];
		[clickImage addObject:[attributeDict valueForKey:@"image"]];
		[clickfontSize addObject:[attributeDict valueForKey:@"fontSize"]];
		[clickCorrect addObject:[attributeDict valueForKey:@"correct"]];
        return;
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {

    if (!currentStringValue) {
		
        currentStringValue = [[NSMutableString alloc] init];
	
    }
	
    [currentStringValue appendString:string];
	
	[self removeXtraCharacters];


	
}


- (void)removeXtraCharacters{
	
	[currentStringValue replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [currentStringValue length])];
	[currentStringValue replaceOccurrencesOfString:@"\t" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [currentStringValue length])];

	NSArray *comps = [currentStringValue componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	NSMutableArray *words = [NSMutableArray array];
	
	for(NSString *comp in comps) {
		if([comp length] >= 1) {
			[words addObject:comp];
		}
	}
	
	NSString *result = [words componentsJoinedByString:@" "];
	
	[currentStringValue setString:result];
	
}



- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
		namespaceURI:(NSString *)namespaceURI 
		qualifiedName:(NSString *)qName 

{
	
	if ([elementName isEqualToString:@"title"]){
		
		[titles addObject: currentStringValue];
        //return;
	}

	if ([elementName isEqualToString:@"bodyText"]){
		
		[bodyText addObject:currentStringValue];
       //return;
	}
	
	if ([elementName isEqualToString:@"buttonText"]){
		
		[buttonText addObject:currentStringValue];
		//return;
	}
	
	
	if ([elementName isEqualToString:@"buttonType"]){
		
		[buttonType addObject:currentStringValue];
		//return;
	}
    
    if ([elementName isEqualToString:@"buttonURL"]){
		
		[buttonURL addObject:currentStringValue];
		//return;
	}
    
	
	if ([elementName isEqualToString:@"image"]){
		
		[imageUrl addObject:currentStringValue];
        //return;
	}	
	
	
	if ([elementName isEqualToString:@"clickType"]){
		
		[clickType addObject:currentStringValue];
        //return;
	}
	
	if ([elementName isEqualToString:@"clickUrl"]){
		
		[clickURL addObject:currentStringValue];
        //return;
	}
	
	if ([elementName isEqualToString:@"clickText"]){
		
		[clickText addObject:currentStringValue];
        //return;
	}
	
	if ([elementName isEqualToString:@"clickPopText"]){
		
		[clickPopText addObject:currentStringValue];
        //return;
	}
	
	
	
	if ([elementName isEqualToString:@"scenario"]){
		
		
		[self addNode:[[InteractionVo alloc] initWithText:bodyText 
											 bodyTextSize:bodyTextSize
											bodyTextColor:bodyTextColor
											bodyTextWidth: bodyTextWidth
											bodyTextHeight:bodyTextHeight
											   titles:titles 
											   titlesX:titlesX
											   titlesY:titlesY
											   buttonText:buttonText
											   buttonX:buttonX
											   buttonY:buttonY
											   bodyTextX:bodyTextX 
											   bodyTextY:bodyTextY 											   
											   buttonType:buttonType 
											   buttonURL:buttonURL 
											   buttonImage:buttonImage
												 imageUrl:imageUrl
												   imageX:imageX
												   imageY:imageY
											imageRotation:imageRotation
											   classID:classID] withName:intID];

		
		[self addClickNode:[[InteractionVoClick alloc] initWithText:clickText 
														clickX:clickX
														clickY:clickY
													 clickType:clickType 
													  clickURL:clickURL
													clickImage:clickImage
												 clickfontSize:clickfontSize
												clickPopText:clickPopText
												clickCorrect:clickCorrect
												  classID:classID] withName:intID];
		
		
		classID=nil;
		classID=[[NSMutableString alloc] initWithCapacity:50];

		
		bodyText=nil;
		bodyText=[[NSMutableArray alloc] init];
		
		bodyTextSize=nil;
		bodyTextSize=[[NSMutableArray alloc] init];
		
		bodyTextX=nil;
		bodyTextX=[[NSMutableArray alloc] init];

		bodyTextY=nil;
		bodyTextY=[[NSMutableArray alloc] init];	
		
		
		bodyTextColor=nil;
		bodyTextColor=[[NSMutableArray alloc] init];	
		
		bodyTextWidth=nil;
		bodyTextWidth=[[NSMutableArray alloc] init];	
		
		bodyTextHeight=nil;
		bodyTextHeight=[[NSMutableArray alloc] init];	
		
		titles=nil;
		titles= [[NSMutableArray alloc] init];
		
		titlesX=nil;
		titlesX= [[NSMutableArray alloc] init];
		
		titlesY=nil;
		titlesY= [[NSMutableArray alloc] init];
		
		buttonText=nil;
		buttonText=[[NSMutableArray alloc] init];
		
		buttonX=nil;
		buttonX=[[NSMutableArray alloc] init];

		buttonY=nil;
		buttonY=[[NSMutableArray alloc] init];
		
		buttonType=nil;
		buttonType=[[NSMutableArray alloc] init];
		
	
		buttonURL=nil;
		buttonURL=[[NSMutableArray alloc] init];
		
		buttonImage=nil;
		buttonImage = [[NSMutableArray alloc] init];
		
		imageUrl=nil;
		imageUrl=[[NSMutableArray alloc] init];
		
		imageX=nil;
		imageX=[[NSMutableArray alloc] init];
		
		imageY=nil;
		imageY=[[NSMutableArray alloc] init];
		
		imageRotation=nil;
		imageRotation=[[NSMutableArray alloc] init];
		
		clickText=nil;
		clickText= [[NSMutableArray alloc] init];
		
		clickX=nil;
		clickX= [[NSMutableArray alloc] init];
		
		clickY=nil;
		clickY= [[NSMutableArray alloc] init];
		
		clickType=nil;
		clickType= [[NSMutableArray alloc] init];
		
		clickURL=nil;
		clickURL= [[NSMutableArray alloc] init];
		
		clickImage=nil;
		clickImage= [[NSMutableArray alloc] init];
		
		clickfontSize=nil;
		clickfontSize= [[NSMutableArray alloc] init];
		
		clickPopText=nil;
		clickPopText=[[NSMutableArray alloc] init];
		
		clickCorrect=nil;
		clickCorrect=[[NSMutableArray alloc] init];
		
	}
	
	[currentStringValue release];
    currentStringValue = nil;

}


- (void)addNode:(InteractionVo *)node withName:(NSString *)name
{
    NSLog(@"XMLParser::addNode %@", name);
	
	[intXML setObject:node forKey:name];
}

- (void)addClickNode:(InteractionVoClick *)node withName:(NSString *)name
{
	NSMutableString *st=[[NSMutableString alloc] init];
	
	[st appendString:@"Click"];
	
	[st appendString:name];
	
    NSLog(@"XMLParser::addNode %@", st);
	
	[intXML setObject:node forKey:st];
}


- (void)removeNode:(NSString *)name
{
    [intXML removeObjectForKey:name];
}


- (InteractionVo*) contentAt: (NSString *) name
{
	NSLog(@"XMLParser::contentAt %@", name);

    if (![intXML objectForKey:name]) return nil; 
	
    return [intXML objectForKey:name];  
	 
}

- (InteractionVoClick*) contentAtClick: (NSString *) name
{
	NSLog(@"XMLParser::contentAtClick %@", name);
	
    if (![intXML objectForKey:name]) return nil; 
	
    return [intXML objectForKey:name];  
	
}


- (int)count
{
    return [intXML count];
}

- (void)dealloc
{

	NSLog(@"XMLParser::dealloc");
	[intXML release];
	[buttonText release];
	[bodyTextSize release];
	[bodyTextColor release];
	[bodyTextWidth release];
	[bodyTextHeight release];
	[buttonX release];
	[buttonY release];
	[buttonType release];
	[buttonURL release];
	[buttonImage release];
	[titles release];
	[titlesX release];
	[titlesY release];
	[bodyText release];
	[bodyTextX release];
	[bodyTextY release];
	[classID release];
	[intID release];
	[imageUrl release];
	[imageX release];	
	[imageY release];
	[imageRotation release];
	[clickText release];
	[clickX release];
	[clickY release];
	[clickType release];
	[clickURL release];
	[clickImage release];
	[clickfontSize release];
	[clickPopText release];
	[super dealloc];
}

@end

