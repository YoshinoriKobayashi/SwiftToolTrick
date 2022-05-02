//
//  Study09Sub.m
//  Study09
//
//  Created by kobayashi on 2022/05/02.
//

#import "Study09Sub.h"

@implementation Study09Sub

-(void)disp{
    //ここでは_lastnameはもっていないので、スーパークラスのものを使う
    NSLog(@"サブクラス：%@ %@さん%@歳\Nこんにちは！よろしくお願いします。",super.lastName,super.firstName,super.age);
}
-(void)disp2{
    [super disp];
    [self disp];
}

@end
