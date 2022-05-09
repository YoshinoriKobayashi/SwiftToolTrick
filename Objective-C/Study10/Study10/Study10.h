//
//  Study10.h
//  Study10
//
//  Created by kobayashi on 2022/05/07.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Study10 : NSObject
@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger score;

-(void) initName:(NSString*) name Score:(NSInteger) intScore;
+(void) dispResult; // クラスメソッド
@end

NS_ASSUME_NONNULL_END
