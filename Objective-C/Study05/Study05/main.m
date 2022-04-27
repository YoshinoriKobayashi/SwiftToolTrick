//
//  main.m
//  Study05
//
//  Created by kobayashi on 2022/04/26.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {

        id moji; // オブジェクト型の変数*は不要
        // クラスはallocしてinitする
        moji = [NSString alloc]; // クラスメソッド allocをコール
        moji = [moji initWithString: @"Hello"]; // インスタンスメソッド
        NSLog(@"%@", moji);

        moji = [moji uppercaseString]; // 大文字にするインスタンスメソッド
        NSLog(@"%@", moji);

        moji = [moji lowercaseString]; // 小文字にするインスタンスメソッド
        NSLog(@"%@",moji);

        NSNumber *intKazu = @12343533;
        // alloc と initを同時にできる
        NSNumberFormatter * nf = [NSNumberFormatter new];
        nf.numberStyle = NSNumberFormatterCurrencyStyle; // プロパティの値をセット
//        [nf setNumberStyle:NSNumberFormatterCurrencyStyle] // インスタンスメソッドでの呼び出し
        moji = [nf stringFromNumber: intKazu];
        NSLog(@"%@", moji);




        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
