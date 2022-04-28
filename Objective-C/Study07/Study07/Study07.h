//
//  Study07.h
//  Study07
//
//  Created by kobayashi on 2022/04/27.
//

#import <Foundation/Foundation.h>

@interface Study07 : NSObject
-(void) saySomething:(NSString*)words;// 戻り値　メソッド名　引数
-(float) calcBmiTallCm:(float)tall weightKg:(float)weight; // BMIを計算するメソッド


// 引数が3つの場合
// - (戻り値の型)メソッド名:(引数の型)引数1　ラベル:(引数の型)引数2 ラベル:(引数の型)引数3

@end
