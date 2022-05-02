//
//  Study09Super.h
//  Study09
//
//  Created by kobayashi on 2022/05/02.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//NSObjectがスーパークラス
@interface Study09Super : NSObject

@property NSString *firstName;
@property NSString *lastName;
@property NSNumber *age;

//特命初期化メソッド
//最も引数の個数が多いメソッドを特命初期化メソッドとし、他の初期化メソッドは、内部的にこれを呼び出すことができる。
//引数が少ないメソッドが引数が多いメソッドを呼ぶ
-(void)initFname:(NSString*)fName Lname:(NSString*) lName Age:(NSNumber*) age;
-(void)disp;

@end

NS_ASSUME_NONNULL_END
