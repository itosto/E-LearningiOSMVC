#import <Foundation/Foundation.h>


@interface InteractionVo : NSObject {
	 
@public
	NSMutableArray *bodyText;
	NSMutableArray *bodyTextSize;
	NSMutableArray *bodyTextX;
	NSMutableArray *bodyTextY;
	NSMutableArray *bodyTextWidth;
	NSMutableArray *bodyTextHeight;
	NSMutableArray *bodyTextColor;
	NSMutableArray *titles;
	NSMutableArray *titlesX;
	NSMutableArray *titlesY;
	NSMutableArray *buttonText;
	NSMutableArray *buttonX;
	NSMutableArray *buttonY;
	NSMutableArray *buttonType;
	NSMutableArray *buttonURL;
	NSMutableArray *buttonImage;
	NSMutableString *classID;
	NSMutableArray  *imageUrl;	
	NSMutableArray  *imageX;	
	NSMutableArray  *imageY;	
	NSMutableArray  *imageRotation;	
	
	
}

- (id)initWithText:(NSMutableArray *)bodyText
			bodyTextSize:(NSMutableArray *) bodyTextSize
			bodyTextColor:(NSMutableArray *)bodyTextColor 
			bodyTextWidth: (NSMutableArray *)bodyTextWidth
			bodyTextHeight:(NSMutableArray *)bodyTextHeight
			titles:(NSMutableArray *)titles 
			titlesX:(NSMutableArray *)titlesX
			titlesY:(NSMutableArray *)titlesY
			buttonText:(NSMutableArray *)buttonText 
			buttonX:(NSMutableArray *)buttonX
			buttonY:(NSMutableArray *)buttonY
			bodyTextX:(NSMutableArray *)bodyTextX 
			bodyTextY:(NSMutableArray *)bodyTextY 
			buttonType:(NSMutableArray *)buttonType 
			buttonURL:(NSMutableArray *)buttonURL
			buttonImage:(NSMutableArray *)buttonImage
			imageUrl: (NSMutableArray*) imageUrl
			imageX:(NSMutableArray*) imageX
			imageY:(NSMutableArray*) imageY
			imageRotation:(NSMutableArray*) imageRotation
			classID: (NSMutableString *)classID;


@property (nonatomic, copy) NSMutableArray *bodyText;
@property (nonatomic, copy) NSMutableArray *bodyTextSize;
@property (nonatomic, copy) NSMutableArray *bodyTextColor;
@property (nonatomic, copy) NSMutableArray *titles;
@property (nonatomic, copy) NSMutableArray *titlesX;
@property (nonatomic, copy) NSMutableArray *titlesY;
@property (nonatomic, copy) NSMutableArray *buttonText;
@property (nonatomic, copy) NSMutableArray *bodyTextX;
@property (nonatomic, copy) NSMutableArray *bodyTextY;
@property (nonatomic, copy) NSMutableArray *bodyTextWidth;
@property (nonatomic, copy) NSMutableArray *bodyTextHeight;
@property (nonatomic, copy) NSMutableArray *buttonType;
@property (nonatomic, copy) NSMutableArray *buttonX;
@property (nonatomic, copy) NSMutableArray *buttonY;
@property (nonatomic, copy) NSMutableArray *buttonURL;
@property (nonatomic, copy) NSMutableArray *buttonImage;
@property (nonatomic, copy) NSMutableString *classID;
@property (nonatomic, copy) NSMutableArray *imageUrl;
@property (nonatomic, copy) NSMutableArray *imageX;
@property (nonatomic, copy) NSMutableArray *imageY;
@property (nonatomic, copy) NSMutableArray *imageRotation;

@end
