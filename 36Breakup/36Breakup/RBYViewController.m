//
//  RBYViewController.m
//  36Love
//
//  Created by Rose Yao on 1/27/15.
//  Copyright (c) 2015 Rose Yao. All rights reserved.
//

#import "RBYViewController.h"


@interface RBYViewController()

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *tapLabel;
@property (nonatomic, retain) NSTimer *timer;

@property  (nonatomic)      int     currentQuestionIndex;
@property (nonatomic, copy) NSArray *questions;

@end;

@implementation RBYViewController

@synthesize timer;
int secondsLeft=239;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    
    if (self) {
        _questions = @[@"Given the choice of anyone in the world, whom would you like to punch in the face?",
                       @"On average, how long do you spend composing tweets before you post them? Do you realize that they don’t matter?",
                       @"Before responding to a text, do you wait a few minutes to make it seem like you’re doing something more important? Why? Answer me now.",
                       @"What would constitute a “perfect” day for you? Why do we always just go home and watch Netflix instead of doing any of that stuff?",
                       @"What’s your favorite song? No, it’s not. I’ve never once heard you listen to that song.",
                       @"Honestly, which one of us would you rather have die first?",
                       @"So you want me to be the one who becomes a burden to our children and then dies alone?",
                       @"Name three things you find irritating about your partner.",
                       @"Why do we even have a dishwasher if you insist on thoroughly scrubbing the dishes before putting them in? O.K., fine, I’m adding your dishwasher issue to my list of irritating things, too. So there.",
                       @"If you could change anything about your partner’s family, what would it be?",
                       @"Take four minutes and tell your partner your life story in as much detail as possible. I already know that story. And I was there for that one. It didn’t happen like that.",
                       @"Why did you send me a link to this Times article if you didn’t want us to go through the questions together?",
                       @"Between you and your partner, who is the better gift-giver?",
                       @"No, I did like that jacket, but I specifically asked for it, so it doesn’t really count as a gift that you thought of, and, you know, 'it’s the thought that counts.'",
                       @"Ha ha. Fine. You can be the better gift-giver. Happy? Next question.",
                       @"What is your most treasured memory? I was there for that one. It definitely didn’t happen like that.",
                       @"What is your most horrible memory? No, “Right now, answering these questions” doesn’t count.",
                       @"Is there something that you’ve dreamed of doing for a long time but haven’t done because you know your partner wouldn’t like it?",
                       @"Don’t pin that on me. You know we don’t have to do everything together, right?",
                       @"What do you want to do for dinner?",
                       @"If you knew we were getting dinner tonight, why would you eat a cupcake at five? All I’ve had to eat today is a cup of soup and, like, eight almonds.",
                       @"Take turns going to the bathroom with nothing but a thin, not at all soundproof door separating you from your partner. Just sit there and hear it all.",
                       @"What do you want to watch tonight?",
                       @"Are you going to fall asleep in the middle of the episode again?",
                       @"I’m not the one making us answer these questions. Do you want to stop?",
                       @"Do you not think our relationship is strong enough to handle these questions? ",
                       @"How do you feel about your partner’s relationship with his or her mother?",
                       @"Oh, like your mother is so much better?",
                       @"Share a tube of toothpaste with your partner.",
                       @"Why are you not squeezing from the bottom? Are you a monster?",
                       @"Tell your partner which celebrities you find attractive.",
                       @"Why do none of those celebrities look anything like me?",
                       @"Rent a car with your partner and drive while he or she gives directions.",
                       @"How am I supposed to get across four lanes in two seconds? You have to tell me the exit earlier.",
                       @"Tell your partner something that you like about him or her. Try to think of something. Anything.",
                       @"Given the choice of anyone in the world, whom would you like to punch in the face?"
                       ];
        self.currentQuestionIndex = 102;
        
    }
    
    return self;
}

- (IBAction)showQuestion:(id)sender
{
    if (self.currentQuestionIndex == 102) {
        [self.startLabel setHidden:YES];
        [self.tapLabel setHidden:YES];
        self.currentQuestionIndex = 0;
    }
    

    if (self.currentQuestionIndex == 100) {
        [self.startLabel setHidden:NO];
        if (self.timer==nil) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerOver) userInfo:nil repeats:YES];
            self.tapLabel.text = @"";
            self.startLabel.text = @"4 minutes and 0 seconds";
        }
    }
    else if (self.currentQuestionIndex == 101) {
        if (timer!=nil)
        {
            [timer invalidate];
            timer=nil;
            secondsLeft=239;
        }
        self.startLabel.text = @"Thank you and please tell your friends";
        self.tapLabel.text = @"Tap to go start again :)";
        self.currentQuestionIndex = 102;
    }
    else if (self.currentQuestionIndex == [self.questions count]) {
        self.currentQuestionIndex = -1;
        [self.startLabel setHidden:NO];
        [self.tapLabel setHidden:NO];
        self.startLabel.text = @"Now stare into each other's eyes ANGRILY for 4 minutes";
        self.tapLabel.text = @"Tap to start";
        self.questionLabel.text = @"";
        self.currentQuestionIndex = 100;

    }
    else {
        NSString *question = self.questions[self.currentQuestionIndex];
        self.questionLabel.text = [NSString stringWithFormat:@"%d) %@", self.currentQuestionIndex+1, question];
        self.currentQuestionIndex++;
    }

}

- (void)timerOver
{
    if (secondsLeft==0) {
        self.currentQuestionIndex = 101;
        self.startLabel.text = @"Congrats lovers!";
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        
    }
    else {
        int seconds = (secondsLeft %3600) % 60;
        int mins = secondsLeft/60;
    
        if (mins == 0) {
            self.startLabel.text = [NSString stringWithFormat:@"%0d seconds", seconds];
        }
        else if (mins == 1) {
            self.startLabel.text = [NSString stringWithFormat:@"%0d minute and %0d seconds", mins, seconds];
        }
        else {
            self.startLabel.text = [NSString stringWithFormat:@"%0d minutes and %0d seconds", mins, seconds];
        }
        secondsLeft--;
    }
}


@end
