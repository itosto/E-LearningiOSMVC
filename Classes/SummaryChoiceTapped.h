#import "SPEvent.h"
#import "UserAnswerData.h"
#define EVENT_TYPE_SUMMARY_CHOICE_TAPPED @"sumChoiceTapped"

@interface SummaryChoiceTapped : SPEvent {
    
    UserAnswerData *mdata;
}

- (id)initWithType:(NSString *)type data:(UserAnswerData*)data bubbles:(BOOL)bubbles;

@property (nonatomic, readonly) UserAnswerData* data;
@end
