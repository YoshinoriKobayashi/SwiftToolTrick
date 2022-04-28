//
//  main.m
//  Study08
//
//  Created by kobayashi on 2022/04/28.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Study08.h"


int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {

        Study08 *st = [Study08 new];
        st.name = @"いざわたけし";
        st.age = 38;
        st.pass = @YES;
        [st disp];

        st.name = @"やまだ　たろう";
        st.age = 19;
        st.pass = @NO;
        [st disp];


        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
