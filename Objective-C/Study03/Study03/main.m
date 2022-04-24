//
//  main.m
//  Study03
//
//  Created by kobayashi on 2022/04/24.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {

        // NSDictionary：固定長なのであとで追加、削除はできない
        NSArray *strShikoku = @[@"香川",@"徳島",@"愛媛",@"高知"];
        for (NSString *strPName in strShikoku) {
            NSLog(@"%@", strPName);
        }
        int idx = 3;
        NSString *strDisp = strShikoku[idx];
        NSLog(@"%i番目は%@です。", idx,strDisp);

        // 要素数の取得
        // *をつけないのがポイント
        NSUInteger cnt = [strShikoku count];

        NSNumber *intCnt = [NSNumber numberWithInteger: cnt]; // NSNumberに変換
        NSLog(@"四国は%@県あります。", intCnt);

        // NSDictionary：固定長なのであとで追加、削除はできない
        NSDictionary *genso = @{@"H" : @"水素",
                                @"He": @"ヘリウム",
                                @"Li": @"リチウム",
                                @"Be": @"ベリリウム",
                                @"B": @"ホウ素"};

        strDisp = [genso objectForKey:@"H"];
        NSLog(@"%@",strDisp);

        for(NSString *key in genso) {
            NSLog(@"%@ : %@",key,genso[key]);
        }

        // NSInteger
        NSInteger x = 0;
        for(int i = 0; i < 10; i++) {
            x++;
            NSLog(@"%ld", x);
        }



        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
