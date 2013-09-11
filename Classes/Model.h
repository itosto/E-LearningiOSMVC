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
#import "UserAnswerData.h"

@interface Model : Observer {
	
	@public
	XMLParser *XML;
	NSInteger currentScenario;
	NSMutableDictionary * data_arr;
    id app;


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
- (void) cleanDataArr;
- (void)dataArr:(UserAnswerData *)node withName:(NSString *)name;

@property (nonatomic,assign) NSInteger currentScenario;
@property (nonatomic,copy) XMLParser *XML;
@property (nonatomic,copy) NSMutableDictionary* data_arr;
@property (nonatomic,retain) id app;

@end
