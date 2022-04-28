//
//  main.m
//  Study07
//
//  Created by kobayashi on 2022/04/27.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Study07.h"

int main(int argc, char * argv[]) {

    NSString * appDelegateClassName;
    @autoreleasepool {

        Study07 *st = [Study07 new];
        [st saySomething:@"こんにちは！"];
        float bmi = [st calcBmiTallCm:181.5 weightKg:84.2];
        NSLog(@"あなたのBMIは%fです。",bmi);

        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
