//
//  SummaryofAnswers.h
//  Sparrow
//
//  Created by Jose D Perez-Diaz on 9/14/12.
//
//

#import <Foundation/Foundation.h>

@interface UserAnswerData : NSObject{
    @public
    NSString* your_answer;
    NSString* correct_answer_eval;
    NSString* correct_answer_text;
    NSString* feedback;
    NSString* audio_file;
    
}

@property (nonatomic, copy) NSString* your_answer;
@property (nonatomic, copy) NSString* correct_answer_eval;
@property (nonatomic, copy) NSString* correct_answer_text;
@property (nonatomic, copy) NSString* feedback;
@property (nonatomic, copy) NSString* audio_file;
@end
