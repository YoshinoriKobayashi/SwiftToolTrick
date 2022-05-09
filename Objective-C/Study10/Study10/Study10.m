//
//  Study10.m
//  Study10
//
//  Created by kobayashi on 2022/05/07.
//

#import "Study10.h"

//クラス変数
static NSInteger goukei = 0;
static NSMutableArray *nameList;

@implementation Study10

//クラスオブジェクトの初期化
+(void)initialize {
    goukei = 0;
    nameList = [NSMutableArray new];
}

-(void) initName:(NSString*) name Score:(NSInteger) intScore {
    _name = name;
    _score = intScore;
    goukei += _scorel;
    // クラスメソッド
    [nameList addObject:name];

}
+(void) dispResult {

} // クラスメソッド


@end
