//
//  main.m
//  Study09
//
//  Created by kobayashi on 2022/05/02.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Study09Super.h"
#import "Study09Sub.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        //インスタンスを作る
        Study09Super *st = [Study09Super new];
        [st disp];

        Study09Sub *st2 = [Study09Sub new];
        [st2 disp];
        [st2 disp2];


        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
