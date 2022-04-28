//
//  Study08.h
//  Study08
//
//  Created by kobayashi on 2022/04/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 外部に公開するものはhファイルに書く
// @interfaceがクラス
@interface Study08 : NSObject
// 参照型の変数
@property NSString *name;
@property NSNumber *pass;
// 値型の変数
@property NSInteger age;
// メソッド
// -はインスタンスメソッド
// 戻り値は必須
-(void)disp;

//　代表的なプロパティのオプション
@property (readonly) NSString *address; //読み込み専用、デフォルトはreadwrite
@property (nonatomic) NSString *favarite; //デフォルトはatomic,アトミック性の設定、スレッドがからまないときはnonatomicにするとアクセスが高速になる。
@property (weak) NSString *music; //デフォルトはstrong。オブジェクトへの弱い参照の強度
@property (copy) NSMutableArray *seiza; //オブジェクトの複製を保存。参照先のデータの整合性が保てる。NSMutable系を使うときはcopy属性で値型にしておくと、思わぬところでの変更が影響されない

@end

NS_ASSUME_NONNULL_END
