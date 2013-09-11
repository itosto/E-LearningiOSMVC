#import "SummaryChoiceTapped.h"

@implementation SummaryChoiceTapped
@synthesize  data = mdata;

- (id)initWithType:(NSString *)type data:(UserAnswerData *)data bubbles:(BOOL)bubbles
{
    if (self = [super initWithType:type bubbles:NO])
    {
        mdata = data;
    }
    return self;
}

@end
