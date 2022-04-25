//
//  main.m
//  Study04
//
//  Created by kobayashi on 2022/04/25.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {

        //NSMutableArray：可変長の配列
        NSMutableArray *weekDay = [NSMutableArray new];
        [weekDay addObject: @"月曜日"];
        [weekDay addObject: @"火曜日"];
        [weekDay addObject: @"水曜日"];
        [weekDay addObject: @"木曜日"];
        [weekDay addObject: @"金曜日"];
        [weekDay addObject: @"土曜日"];
        [weekDay addObject: @"日曜日"];

        for(NSString *wd in weekDay) {
            NSLog(@"%@",wd);
        }

        NSLog(@"------------------");

        NSString *wd = weekDay[6];
        //最後を削除
        [weekDay removeLastObject];
        //0番に挿入
        [weekDay insertObject:wd atIndex:0];

        for(NSString *wd in weekDay) {
            NSLog(@"%@",wd);
        }
        NSLog(@"------------------");

        //NSMutableDictionary：可変長のDictionary
        NSMutableDictionary *color = [NSMutableDictionary new];
        [color setObject:@"ピンク" forKey:@"Pink"];
        [color setObject:@"黒" forKey:@"Black"];
        [color setObject:@"緑" forKey:@"Green"];
        [color setObject:@"白" forKey:@"White"];

        for(NSString *key in color) {
            NSLog(@"%@:%@",key,[color objectForKey:key]);
        }
        NSLog(@"===============");

        [color setObject:@"ぴんく" forKey:@"Pink"];
        [color removeObjectForKey:@"Black"];
        for(NSString *key in color) {
            NSLog(@"%@ : %@", key,[color objectForKey:key]);
        }
        NSLog(@"++++++++++++++++++");

        //NSMutableString:可変長のString
        NSMutableString *str = [NSMutableString stringWithString:@"This pen"];
        [str insertString:@"is " atIndex:5];
        NSLog(@"%@", str);
        [str insertString:@"a " atIndex:8];
        NSLog(@"%@", str);




        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
