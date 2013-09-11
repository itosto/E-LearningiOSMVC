//
//  TouchSheet.h
//  Sparrow
//
//  Created by Daniel Sperl on 08.05.09.
//  Copyright 2009 Incognitek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"

@interface TouchSheet : SPSprite 
{
  @private
    SPSprite *mQuad;
}

- (id)initWithSprite:(SPSprite*)quad; // designated initializer

@end
