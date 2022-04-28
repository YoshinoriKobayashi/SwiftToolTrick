//
//  Study08.m
//  Study08
//
//  Created by kobayashi on 2022/04/28.
//

#import "Study08.h"

@implementation Study08
-(void)disp {
    // 変数はかならずインタンスの変数を使う
    NSLog(@"氏名:%@", self.name); // _nameでもアクセスできる。_をつけるとインスタンス変数

    // メソッドは[]で囲う
    // isEqualはpass（NSNumber）のメソッド
    if ([self.pass isEqual:@(YES)]) { // _passでもアクセスできる。_をつけるとインスタンス変数
        NSLog(@"結果：合格");
    } else {
        NSLog(@"結果：不合格");
    }
    NSLog(@"年齢:%ld歳",self.age); // _ageでもアクセスできる。_をつけるとインスタンス変数
}
@end
