/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A collection of HealthKit properties, functions, and utilities.
*/

import Foundation
import HealthKit

class HealthData {
    // 1度インスタンス化すれば、プロジェクト全体で使える
    // HKHealthStoreがヘルスデータ資源
    // HealthKitで管理されるすべてのデータのアクセスポイントです。
    // HKHealthStoreオブジェクトを使用して、HealthKitデータの共有または読み取りの許可を要求します。
    // 許可が得られれば、HealthKitストアを使用して、新しいサンプルをストアに保存したり、アプリが保存したサンプルを管理したりできます。
    // さらに、HealthKitストアを使用して、クエリの開始、停止、および管理を行うことができます。
    static let healthStore: HKHealthStore = HKHealthStore()
    
    // MARK: - Data Types
    static var readDataTypes: [HKSampleType] {
        return allHealthDataTypes
    }
    
    static var shareDataTypes: [HKSampleType] {
        return allHealthDataTypes
    }
    // 操作するデータ
    private static var allHealthDataTypes: [HKSampleType] {
        let typeIdentifiers: [String] = [
            HKQuantityTypeIdentifier.stepCount.rawValue,
            HKQuantityTypeIdentifier.distanceWalkingRunning.rawValue,
            HKQuantityTypeIdentifier.sixMinuteWalkTestDistance.rawValue
        ]
        
        return typeIdentifiers.compactMap { getSampleType(for: $0) }
    }
    
    // MARK: - Authorization
    // クロージャ
    // 必要に応じてHealthKitから健康データを要求し、`HealthData.allHealthDataTypes`内のデータタイプを使用します。
    class func requestHealthDataAccessIfNeeded(dataTypes: [String]? = nil, completion: @escaping (_ success: Bool) -> Void) {
        var readDataTypes = Set(allHealthDataTypes)
        var shareDataTypes = Set(allHealthDataTypes)
        
        if let dataTypeIdentifiers = dataTypes {
            readDataTypes = Set(dataTypeIdentifiers.compactMap { getSampleType(for: $0) })
            shareDataTypes = readDataTypes
        }
        
        requestHealthDataAccessIfNeeded(toShare: shareDataTypes, read: readDataTypes, completion: completion)
    }
    
    /// 必要に応じてHealthKitから健康データを要求する。
    /// クロージャ
    class func requestHealthDataAccessIfNeeded(toShare shareTypes: Set<HKSampleType>?,
                                               read readTypes: Set<HKObjectType>?,
                                               completion: @escaping (_ success: Bool) -> Void) {
        // @escaping をつけていると引数が確定していなくても、関数内のコード処理が先に行われます。
        // HealthKitがサポートされているデバイスであるか確認
        // このあとで、HealthStoreを操作する
        // このデバイスで HealthKit が利用可能かどうかを示す Boolean 値を返します。
        if !HKHealthStore.isHealthDataAvailable() {
            fatalError("Health data is not available!")
        }
        
        print("Requesting HealthKit authorization...")
        // 認証要求
        // 指定されたデータ型の保存と読み込みの許可を要求します。
        // HealthKitはこれらのリクエストを非同期的に実行します。
        // 新しいデータタイプ（ユーザーがこのアプリで以前に許可または拒否していないデータタイプ）でこのメソッドを呼び出すと、
        // システムは自動的に許可フォームを表示し、要求されたすべての許可をリストアップします。
        // ユーザーが回答を終えた後、このメソッドは、バックグラウンドのキューにある完了ブロックを呼び出します。
        // ユーザーがすでに指定されたすべてのタイプへのアクセスを許可または禁止することを選択している場合は、
        // HealthKitはユーザーにプロンプトを表示せずに完了を呼び出します。
        healthStore.requestAuthorization(toShare: shareTypes, read: readTypes) { (success, error) in
            if let error = error {
                print("requestAuthorization error:", error.localizedDescription)
            }
            
            if success {
                print("HealthKit authorization request was successful!")
            } else {
                print("HealthKit authorization was not successful.")
            }
            //　ここでコールバックする（呼び出し元に処理を戻す）
            completion(success)
        }
    }
    
    // MARK: - HKHealthStore
    // クロージャ
    class func saveHealthData(_ data: [HKObject], completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        // healthStoreに保存
        healthStore.save(data, withCompletion: completion)
    }
    
    // MARK: - HKStatisticsCollectionQuery
    class func fetchStatistics(with identifier: HKQuantityTypeIdentifier,
                               predicate: NSPredicate? = nil,
                               options: HKStatisticsOptions,
                               startDate: Date,
                               endDate: Date = Date(),
                               interval: DateComponents,
                               completion: @escaping (HKStatisticsCollection) -> Void) {
        guard let quantityType = HKObjectType.quantityType(forIdentifier: identifier) else {
            fatalError("*** Unable to create a step count type ***")
        }
        
        let anchorDate = createAnchorDate()
        
        // Create the query
        // 一連の固定長の時間間隔で複数の統計クエリを実行するクエリです。
        // 統計収集クエリは、グラフやチャート用のデータを作成するためによく使われます。
        // 例えば、各日の総歩数や各時間の平均心拍数を計算する統計コレクションクエリを作成することができます。
        // オブザーバー・クエリと同様に、コレクション・クエリも長期的なクエリとして機能し、
        // HealthKitストアのコンテンツが変更されたときに更新を受け取ることができます。
        let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                                quantitySamplePredicate: predicate,
                                                options: options,
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)
        
        // Set the results handler
        // クエリの初期結果のための結果ハンドラです。
        // このプロパティがnilに設定されていない場合、クエリは、HealthKitに現在保存されている
        // すべてのマッチするサンプルの統計情報の計算が終了した後、バックグラウンドのキューで結果ハンドラを実行します。
        query.initialResultsHandler = { query, results, error in
            if let statsCollection = results {
                completion(statsCollection)
            }
        }
        // 指定されたクエリの実行を開始します。
        // HealthKitは、バックグラウンドのキューで非同期的にクエリを実行します。
        // ほとんどのクエリは、実行が終了すると自動的に停止します。
        // しかし、オブザーバーのクエリや一部の統計収集クエリなど、長時間実行されるクエリはバックグラウンドで実行され続けます。
        // 実行時間の長いクエリを停止するには、stop(_:)メソッドを呼び出します。
        healthStore.execute(query)
    }
    
    // MARK: - Helper Functions
    
    class func updateAnchor(_ newAnchor: HKQueryAnchor?, from query: HKAnchoredObjectQuery) {
        if let sampleType = query.objectType as? HKSampleType {
            setAnchor(newAnchor, for: sampleType)
        } else {
            if let identifier = query.objectType?.identifier {
                print("anchoredObjectQueryDidUpdate error: Did not save anchor for \(identifier) – Not an HKSampleType.")
            } else {
                print("anchoredObjectQueryDidUpdate error: query doesn't not have non-nil objectType.")
            }
        }
    }
    
    // ユーザーのデフォルトデータベースへのインターフェースで、アプリの起動時にキーと値のペアを永続的に保存します。
    // UserDefaultsクラスは、デフォルトシステムと対話するためのプログラムインターフェースを提供します。
    // デフォルトシステムを使うと、ユーザーの好みに合わせてアプリの動作をカスタマイズすることができます。
    // たとえば、ユーザーが好みの測定単位やメディアの再生速度を指定できるようになります。
    // アプリは、ユーザーのデフォルトデータベースにある一連のパラメーターに値を割り当てることで、これらの好みを保存します。
    // パラメータは、起動時のアプリのデフォルト状態や、デフォルトでの動作を決定するためによく使われるので、デフォルトと呼ばれます。
    // 実行時には、UserDefaults オブジェクトを使用して、ユーザーのデフォルト 
    // データベースからアプリが使用するデフォルトを読み取ります。
    // UserDefaultsは情報をキャッシュするので、デフォルト値が必要になるたびにユーザーのデフォルトデータベースを開く必要はありません。
    // デフォルト値を設定すると、プロセス内では同期的に変更され、永続的なストレージや他のプロセスに対しては非同期的に変更されます。
    private static let userDefaults = UserDefaults.standard
    
    private static let anchorKeyPrefix = "Anchor_"
    
    private class func anchorKey(for type: HKSampleType) -> String {
        return anchorKeyPrefix + type.identifier
    }
    
    /// 特定のサンプルタイプに対する長時間のアンカー付きオブジェクトクエリで使用された保存済みのアンカーを返します。
    /// クエリが一度も実行されていない場合は nil を返します。
    class func getAnchor(for type: HKSampleType) -> HKQueryAnchor? {
        if let anchorData = userDefaults.object(forKey: anchorKey(for: type)) as? Data {
            return try? NSKeyedUnarchiver.unarchivedObject(ofClass: HKQueryAnchor.self, from: anchorData)
        }
        
        return nil
    }
    
    /// 特定のサンプルタイプに対する長期的なアンカー付きオブジェクトのクエリで使用される保存されたアンカーを更新します。
    private class func setAnchor(_ queryAnchor: HKQueryAnchor?, for type: HKSampleType) {
        if let queryAnchor = queryAnchor,
            let data = try? NSKeyedArchiver.archivedData(withRootObject: queryAnchor, requiringSecureCoding: true) {
            userDefaults.set(data, forKey: anchorKey(for: type))
        }
    }
}
