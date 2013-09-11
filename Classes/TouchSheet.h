#import <Foundation/Foundation.h>
#import "Sparrow.h"

@interface TouchSheet : SPSprite 
{
  @private
    SPSprite *mQuad;
}

- (id)initWithSprite:(SPSprite*)quad; // designated initializer

@end
