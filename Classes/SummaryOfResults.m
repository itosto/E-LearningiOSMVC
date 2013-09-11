#import "SummaryOfResults.h"
#import "ReviseUserChoiceButton.h"
#import "SummaryChoiceTapped.h"
#import "ReviseUserChoiceFeedback.h"
#import "SPTextField.h"
@implementation SummaryOfResults

- (void) initializeInteraction{
    NSLog(@"SummaryOfResults::initializeInteraction");
    data_arr = model.data_arr;
    int l = data_arr.count;
    int total_correct = 0;
    
    for (int i=1; i<=l; ++i){
        
        NSString *str= @"obj";
        NSString *converted = [NSString stringWithFormat:@"%d", i];
        str = [str stringByAppendingString:converted];
        
        UserAnswerData* sum =  [data_arr objectForKey:str];
        ReviseUserChoiceButton * choice = [[ReviseUserChoiceButton alloc] initWithData:sum choice_num:i];
        [interaction_sp addChild:choice];
        choice.mId = i;
        [choice addEventListener:@selector(presentFeedbackWindow:) atObject:self forType:EVENT_TYPE_SUMMARY_CHOICE_TAPPED];
        
        if(i<=5){
            
            choice.x = 55;
            choice.y = 250 + ((i-1) * 75);
            
            
        }	else if(i<=10 && i>5) {
            
            choice.x = 280;
            choice.y = 250 + ((i-6) * 75);
            
        }	else if(i<=15 && i>10) {
            
            choice.x = 512;
            choice.y = 250 + ((i-11) * 75);
            
        }	 else if(i<=20 && i>10) {
            
            choice.x = 753;
            choice.y = 250 + ((i-16) * 75);
        }
        
        [choice release];
        
        if([sum.correct_answer_eval isEqualToString: @"1"]){
            total_correct++;
        }
    }
   
    
    NSString *str1;
    NSString *totalQuestions = [NSString stringWithFormat:@"%d", l];
    NSString *total_correct_str = [NSString stringWithFormat:@"%d", total_correct];
    
    if(total_correct >= 14) {
       str1= @"Tuvistes ";
       str1 = [str1 stringByAppendingString:total_correct_str];
       str1 = [str1 stringByAppendingString:@" correctas de un total de "];
       str1 = [str1 stringByAppendingString:totalQuestions];
       str1 = [str1 stringByAppendingString:@" preguntas. Esto significa que tienes buen oido musical!"];

    } else {
        
        str1= @"Tuvistes ";
        str1 = [str1 stringByAppendingString:total_correct_str];
        str1 = [str1 stringByAppendingString:@" correctas de un total de "];
        str1 = [str1 stringByAppendingString:totalQuestions];
        str1 = [str1 stringByAppendingString:@" preguntas. Esto significa que tienes que trabajar para desarrolar aun más tu oído musical."];
    }
    
     SPTextField *bodyText = [interaction_sp childByName:@"bodytext1"];
     bodyText.text = str1;
}
    

- ( void)presentFeedbackWindow :(SummaryChoiceTapped *) event {
    NSLog(@"SummaryOfResults::presentFeedbackWindow %@", event.data.feedback);
    ReviseUserChoiceFeedback *ucf = [[ReviseUserChoiceFeedback alloc] initWithData: event.data choice_num: event.currentTarget.mId];
    [interaction_sp addChild:ucf];
    [ucf release];
}

	

@end
