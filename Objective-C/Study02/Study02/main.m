//
//  main.m
//  Study02
//
//  Created by kobayashi on 2022/04/23.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        NSString *namae = @"Takeshi Izawa"; // 文字列の宣言
        NSLog(@"%@", namae);

        NSNumber *intKaKaku = @15000;  // 数値の宣言
        NSNumber *uintNenrei = @38u; // 符号なしの整数
        NSNumber *longJinko = @120000l; // long型
        NSNumber *boolFlag = @YES; // Bool値の宣言
        NSNumber *floatPai = @3.14f; // 浮動小数点
        NSNumber *doublePai = @3.141592653;
        NSNumber *charRank = @'T'; // 文字の宣言

        int i = 10;
        intKaKaku = @(i); // @() // が代入したい変数
        float f = 3.14;
        floatPai = @(f);
        BOOL b = YES;
        boolFlag = @(b);

        intKaKaku =  @(1232333);
        NSNumberFormatter *nf = [NSNumberFormatter new];
        nf.numberStyle = NSNumberFormatterCurrencyStyle; // プロパティ
        NSString *strkazu = [nf stringFromNumber: intKaKaku];
        NSLog(@"%@", strkazu);

        floatPai = @(0.4555f);
        nf.numberStyle = NSNumberFormatterPercentStyle;
        strkazu = [nf stringFromNumber:floatPai];
        NSLog(@"%@",strkazu);

        [nf setNumberStyle: NSNumberFormatterDecimalStyle];
        [nf setGroupingSeparator:@","];  // 区切る文字
        [nf setGroupingSize: 3]; // 区切る感覚
        NSString *strkazu2 = [nf stringFromNumber: intKaKaku];
        NSLog(@"%@", strkazu2);

        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
