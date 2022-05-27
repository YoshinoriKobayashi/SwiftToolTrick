//
//  Study11.m
//  Study11
//
//  Created by kobayashi on 2022/05/25.
//

#import "Study11.h"

// クラス拡張
@interface Study11();
// nameのプロパティを上書き
@property (nonatomic,readwrite) NSString *name; // 名前
// setterとgetterをもつ

// ここで定義したメソッドは見えない
// private
-(void) disHomeru;

@end

@implementation Study11

// プロパティの初期化
-(id) init {
    self = [self init];
    if (self) {
        // _　はインスタンス変数
        _name = @"やまだ　たらおう";
    }
    return self;

}

- (void) dispMessage {
    NSLog(@"%@さん", self.name);
}

-(void) dispHomeru {
    NSLog(@"すごい！");
}
@end
