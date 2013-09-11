#import "ImageText.h"
#import "Model.h"
#import "ViewControllerFactory.h"

// --- private interface 

@interface ImageText ()

- (void) populateText;
- (void) addInteractions;
- (void) addImage;


@end


@implementation ImageText


- (id)init
{
    if (self = [super init])
    {
		interaction_sp = [[SPSprite alloc] init];
    }
    return self;
}


- (void) populateText{
	
	NSLog(@"ImageText::populateText %@", interaction_data_obj.bodyTextX);

	// textbox sprite
	
	interaction_sp.x=0;
	interaction_sp.y=0;
	
	[self addChild:interaction_sp];
	
	for (int i=0; i<=titles; ++i){
		SPTextField *title = [SPTextField textFieldWithWidth:600 height:100 text:[interaction_data_obj.titles objectAtIndex: i]];
		title.hAlign = SPHAlignLeft;
		title.vAlign = SPVAlignTop;
		title.fontSize = 40;
		title.fontName = @"Arial"; 
		//title.rotation=-1.57;
		title.color=0xffffff;
		title.x=[[interaction_data_obj.titlesX objectAtIndex: i] intValue];
		title.y=[[interaction_data_obj.titlesY objectAtIndex: i] intValue];
		[interaction_sp addChild:title];
	}
	 
	 
	// textbox text
	
	for (int i=0; i<=textfields; ++i){
		
		SPTextField *bodyText = [SPTextField textFieldWithWidth:[[interaction_data_obj.bodyTextWidth objectAtIndex: i]intValue] 
														 height:[[interaction_data_obj.bodyTextHeight objectAtIndex: i]intValue]  
														   text:[interaction_data_obj.bodyText objectAtIndex: i]];
		bodyText.hAlign = SPHAlignLeft;
		bodyText.vAlign = SPVAlignTop;
		bodyText.fontSize = [[interaction_data_obj.bodyTextSize objectAtIndex: i] intValue];
		bodyText.fontName = @"Arial";
        
        NSString * color_str = [interaction_data_obj.bodyTextColor objectAtIndex: i];
		bodyText.color= [self stringToHex: color_str];
		bodyText.x=[[interaction_data_obj.bodyTextX objectAtIndex: i] intValue];
		bodyText.y=[[interaction_data_obj.bodyTextY objectAtIndex: i] intValue];
        
        NSString *str= @"bodytext";
        NSString *converted = [NSString stringWithFormat:@"%d", i];
        str = [str stringByAppendingString:converted];
        
		bodyText.name = str;
		[interaction_sp addChild:bodyText];	
		
	}
	
}


- (uint) stringToHex:(NSString *)str
{
    unsigned un;
    
    if( [str isEqualToString: @"black"] ){
        un = 0x000000;
    } else if( [str isEqualToString:@"white"]){
         un = 0xffffff;
    }  else if( [str isEqualToString:@"blue"]){
        un = 0x009ACD;
    }
    return un;
}


- (void) addInteractions{
	
	NSLog(@"ImageText::addInteractions");
	
	for (int i=0; i<=buttons; ++i){
		SPTexture* nextButtonTexture = [SPTexture textureWithContentsOfFile:[interaction_data_obj.buttonImage objectAtIndex: i]];
		SPButton* button = [SPButton buttonWithUpState:nextButtonTexture text:[interaction_data_obj.buttonText objectAtIndex: i]];
		[button addEventListener:@selector(onMouseDown:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];  
		button.x = [[interaction_data_obj.buttonX objectAtIndex: i] intValue];
		button.y =[[interaction_data_obj.buttonY objectAtIndex: i] intValue];
		button.fontSize=20;
		button.fontName=@"Arial";
		button.mType= [interaction_data_obj.buttonType objectAtIndex: i];
        button.index = i;
        button.fontColor = 0xffffff;
        button.element_data_obj = interaction_data_obj.buttonURL;
        
        NSString *str= @"button";
        NSString *converted = [NSString stringWithFormat:@"%d", i];
        str = [str stringByAppendingString:converted];
        button.name = str;
        
		[interaction_sp addChild:button];
        
	}
    
    
	for (int i=0; i<=clicks; ++i){
		
		SPTexture* clickTexture = [SPTexture textureWithContentsOfFile:[dataClick_obj.clickImage objectAtIndex: i]];
		
		SPButton* click = [SPButton buttonWithUpState:clickTexture text:[dataClick_obj.clickText objectAtIndex: i]];
		
		[click addEventListener:@selector(onMouseDown:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
		
		click.x = [[dataClick_obj.clickX objectAtIndex: i] intValue];
		click.y =[[dataClick_obj.clickY objectAtIndex: i] intValue];
		click.fontSize=[[dataClick_obj.clickfontSize objectAtIndex: i] intValue];;
		click.fontName=@"Arial";
		click.fontColor=0x000000;
		click.mType= [dataClick_obj.clickType objectAtIndex: i];
		click.mId = i;
		SPRectangle *rect=[[SPRectangle alloc ]initWithX:50 y:0 width:200 height:50];
		click.textBounds=  rect;
		
		NSString *str= @"click";
		NSString *converted = [NSString stringWithFormat:@"%d", i];
		
		str = [str stringByAppendingString:converted];
		
		click.name=str;
		
		[interaction_sp addChild:click];
		
		//[rect release];
		
	}

}


- (void) addImage{
	NSLog(@"ImageText::addImage");
	
	NSString *str= @"image";

	int objcount=([interaction_data_obj.imageUrl count]-1);
	
	for (int i=0; i<=objcount; ++i){
		SPImage* image = [SPImage imageWithContentsOfFile:[interaction_data_obj.imageUrl objectAtIndex: i]];
		image.x=[[interaction_data_obj.imageX objectAtIndex: i] intValue];
		image.y=[[interaction_data_obj.imageY objectAtIndex: i] intValue];
		image.rotation=[[interaction_data_obj.imageRotation objectAtIndex: i] floatValue];
		
		NSString *converted = [NSString stringWithFormat:@"%d", i];
		
		str = [str stringByAppendingString:converted];
		
		image.name=str;
		
		[interaction_sp addChild:image];
	}

}



- (void) onMouseDown:(SPEvent*) event
{
	NSString* type= [event.currentTarget getmType];
    
	
	if ([type isEqualToString:@"nextScenario"]) {
		
		[model nextScenario];
		[_superView removeCurrent];
        //[self release];
		
	} else if ([type isEqualToString:@"previousScenario"]){
		[model previousScenario];
		[_superView removeCurrent];
        //[self release];
        
	} else if ([type isEqualToString:@"skipBack"]){
		
		[model cleanDataArr];
		[model skipBack:6];
		[_superView removeCurrent];
        
	}  else if ([type isEqualToString:@"nextActivity"]){
        
        [interaction_sp removeAllChildren];
        
//        [interaction_sp removeChild:[interaction_sp childByName:@"button1"]];
//        
//        [[interaction_sp childByName:@"button1"] release];
//        
//        [event.currentTarget removeEventListener:@selector(onMouseDown:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
//        
//        for (int i=0; i<=buttons; ++i){
//            
//            
//        }
        
		//[_superView removeCurrent];
        int n = [[interaction_data_obj.buttonURL objectAtIndex: [event.currentTarget index]] intValue];
        [appMain remove:n];
	}
}


- (void) update 
{
	NSLog(@"ImageText::update");
	
	interaction_data_obj=[model xml];
    
    data_obj=[model xml];
	dataClick_obj=[model xmlClick];
	
	clicks=[dataClick_obj.clickX count]-1;
	
	titles=[interaction_data_obj.titles count]-1;
	buttons=[interaction_data_obj.buttonX count]-1;
	textfields=[interaction_data_obj.bodyText count]-1;
    
	[self addImage];
	[self addInteractions];
	[self populateText];

	[interaction_sp release];
    [self initializeInteraction ];
}


- (void)dealloc
{
	NSLog(@"ImageText::dealloc::%d");
	
	//[data_obj release];
	//[interaction_sp release];
    [super dealloc];
	
}

@end

