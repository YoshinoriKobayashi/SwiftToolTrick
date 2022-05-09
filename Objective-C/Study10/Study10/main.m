//
//  main.m
//  Study10
//
//  Created by kobayashi on 2022/05/07.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {

        //クラスメソッド
        //クラスと関連付けられたメソッド
        //呼び出し方法は[クラス名 メソッド名]
        //・Objective-Cにはクラス変数という考え方がない
        //・そのかわり.mファイルの中にstatic修飾子をつけた変数をクラス変数として扱う
        //・クラス初期化は+(void)initializeクラスメソッドをオーバーライドして記述






        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
