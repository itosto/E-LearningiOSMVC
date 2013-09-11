//
//  SummaryChoice.h
//  Sparrow
//
//  Created by Jose D Perez-Diaz on 9/15/12.
//
//

#import "SPSprite.h"
#import "UserAnswerData.h"

@interface ReviseUserChoiceButton : SPSprite{
    @protected
    UserAnswerData * choice_data;
    SPSprite *interaction_sp;   
    int choice_num;
    
    
}
- (id)initWithData:(UserAnswerData *) summary choice_num: (int ) mchoice_num;

@property (nonatomic, copy) UserAnswerData * choice_data;
@property (nonatomic, assign) int choice_num;


@end
