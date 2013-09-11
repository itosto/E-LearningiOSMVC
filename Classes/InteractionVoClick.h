#import <Foundation/Foundation.h>


@interface InteractionVoClick : NSObject {
	
@public NSMutableArray *clickText;
	NSMutableArray *clickX;
	NSMutableArray *clickY;
	NSMutableArray *clickType;
	NSMutableArray *clickURL;
	NSMutableArray *clickImage;
	NSMutableArray *clickfontSize;
	NSMutableArray *clickPopText;
	NSMutableArray *clickCorrect;
	NSMutableString *classID;
	
	
	
}

- (id)initWithText:(NSMutableArray *)clickText 
		   clickX:(NSMutableArray *)clickX
		   clickY:(NSMutableArray *)clickY
		clickType:(NSMutableArray *)clickType 
		 clickURL:(NSMutableArray *)clickURL
		  clickImage:(NSMutableArray *)clickImage
		 clickfontSize:(NSMutableArray *)clickfontSize
 clickPopText:(NSMutableArray *)clickPopText
 clickCorrect:(NSMutableArray *)clickCorrect
		   classID: (NSMutableString*)classID;


@property (nonatomic, copy) NSMutableArray *clickText;
@property (nonatomic, copy) NSMutableArray *clickType;
@property (nonatomic, copy) NSMutableArray *clickX;
@property (nonatomic, copy) NSMutableArray *clickY;
@property (nonatomic, copy) NSMutableArray *clickURL;
@property (nonatomic, copy) NSMutableArray *clickImage;
@property (nonatomic, copy) NSMutableArray *clickfontSize;
@property (nonatomic, copy) NSMutableArray *clickPopText;
@property (nonatomic, copy) NSMutableArray *clickCorrect;
@property (nonatomic, copy) NSMutableString *classID;


@end
