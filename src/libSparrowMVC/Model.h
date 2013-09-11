//
//  Model.h
//  Ipadsparrow2
//
//  Created by Jose Perez on 3/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Observer.h"//;
#import "XMLParser.h"//;
#import "InteractionVo.h"//;

@interface Model : Observer {
	
	@public
	XMLParser *XML;
	NSInteger currentScenario;
	NSMutableArray* notes_arr;


}


- (void) registerView: (id) view;
- (void) unregisterView: (id) view;
- (id) xml;
- (id) xmlClick;
- (void) loadXML: (NSString*) xmlFile; 
- (void) pushClass: (NSMutableArray*) classNames;
- (void) removeClass: (NSMutableArray*) classNames;
- (void) pushObj: (id) obj;
- (void) startApp; 
- (void) nextScenario;
- (void) previousScenario;
- (void) skipBack:(NSInteger)n;
- (void) notify;
- (void) cleanNotesArr;
- (void) notesArr: (NSString*)string;

@property (nonatomic,assign) NSInteger currentScenario;
@property (nonatomic,copy) XMLParser *XML;
@property (nonatomic,copy) NSMutableArray* notes_arr;

@end
