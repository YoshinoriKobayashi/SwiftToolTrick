//
//  main.m
//  Study06
//
//  Created by kobayashi on 2022/04/27.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "Study06.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {

        Study06 *st = [Study06 new]; // インスタンス作成
        [st sayHello];

        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
