//
//  Study09Super.m
//  Study09
//
//  Created by kobayashi on 2022/05/02.
//

#import "Study09Super.h"

@implementation Study09Super

-(id)init {
    //これは決まりごと、スーパーを上書き
    self = [super init];
    //自分があれば、初期化する
    if(self) {
        [self initFname:@"たけし" Lname:@"いざわ" Age:@42];
    }
    //戻り値のデータ型がID型なので、selfを戻す
    return self;
}

-(void)initFname:(NSString*)fName Lname:(NSString*) lName Age:(NSNumber*) age {
    //_はインスタンス変数であることを示す。
    //初期化する
    _firstName = fName;
    _lastName = lName;
    _age = age;
}
-(void)disp {
    NSLog(@"スーパークラス%@ %@さん%@歳\nこんにちは！よろしくお願いします。",_firstName,_lastName,_age);
}

@end
