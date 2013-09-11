//
//  Observer.h
//  Ipadsparrow2
//
//  Created by Jose D Perez on 3/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLParser.h"//;
#import "InteractionVo.h"//;

@interface Observer : NSObject {
	
@private 		 

	NSMutableArray *subscribers;
	NSMutableArray *objects_arr;
	//NSMutableString *className;
	//NSMutableString *className2;

}

- (id)initWithsubscribersArray:(NSMutableArray*) msubscriberarrArray;
- (BOOL) addSubscriber:(id)classInstance;
- (void)storeObjects: (id) obj;
- (void) removeSubscriber:(id)classInstance;
- (void) removeState:(NSMutableArray*) mc_arr;
- (void) addState:(NSMutableArray*) mc_arr;
- (void) notifyChanges;

@end
