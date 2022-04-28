//
//  Study07.m
//  Study07
//
//  Created by kobayashi on 2022/04/27.
//

#import "Study07.h"

@implementation Study07

-(void) saySomething:(NSString*)words{
    NSLog(@"%@",words);
}
-(float) calcBmiTallCm:(float)tall weightKg:(float)weight {
    float bmi = weight / ((tall*tall)/10000); // (tall*tall)は掛け算
    return bmi;
}

@end
