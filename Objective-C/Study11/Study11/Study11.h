//
//  Study11.h
//  Study11
//
//  Created by kobayashi on 2022/05/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Study11 : NSObject

@property (nonatomic, readonly) NSString *name; // 名前
@property (nonatomic) NSInteger *age; // 年齢

-(void) dispMessage;

@end

NS_ASSUME_NONNULL_END
