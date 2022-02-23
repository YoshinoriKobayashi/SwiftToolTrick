/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view controller that onboards users to the app.
*/

import UIKit
import HealthKit

class WelcomeViewController: SplashScreenViewController, SplashScreenViewControllerDelegate {
    
    let healthStore = HealthData.healthStore
    
    /// 読み取りを依頼するHealthKitのデータタイプです。
    let readTypes = Set(HealthData.readDataTypes)
    /// 当社が共有を要求し、書き込みアクセスが可能なHealthKitデータタイプ。
    let shareTypes = Set(HealthData.shareDataTypes)
    
    var hasRequestedHealthData: Bool = false
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = tabBarItem.title
        view.backgroundColor = .systemBackground
        splashScreenDelegate = self
        actionButton.setTitle("Authorize HealthKit Access", for: .normal)

        getHealthAuthorizationRequestStatus()
    }
    
    func getHealthAuthorizationRequestStatus() {
        print("Checking HealthKit authorization status...")
        
        // HealthKitがサポートされているデバイスであるか確認
        // このあとで、HealthStoreを操作する
        if !HKHealthStore.isHealthDataAvailable() {
            presentHealthDataNotAvailableError()
            
            return
        }
        
        // アプリが提供されたタイプの認証を要求する場合に、システムがユーザーにパーミッションシートを提示するかどうかを示します。
        // このメソッドは、このページで紹介しているように、完了ハンドラを使って同期コードから呼び出すこともできますし、
        // 次のような宣言を持つ非同期メソッドとして呼び出すこともできます。
        healthStore.getRequestStatusForAuthorization(toShare: shareTypes, read: readTypes) { (authorizationRequestStatus, error) in
            
            var status: String = ""
            if let error = error {
                status = "HealthKit Authorization Error: \(error.localizedDescription)"
            } else {
                switch authorizationRequestStatus {
                case .shouldRequest:
                    self.hasRequestedHealthData = false
                    
                    status = "The application has not yet requested authorization for all of the specified data types."
                case .unknown:
                    status = "The authorization request status could not be determined because an error occurred."
                case .unnecessary:
                    self.hasRequestedHealthData = true
                    
                    status = "The application has already requested authorization for the specified data types. "
                    status += self.createAuthorizationStatusDescription(for: self.shareTypes)
                default:
                    break
                }
            }
            
            print(status)
            
            // 結果はバックグラウンドのスレッドで戻ってくる。UIの更新をメインスレッドにディスパッチする。
            DispatchQueue.main.async {
                self.descriptionLabel.text = status
            }
        }
    }
    
    // MARK: - SplashScreenViewController Delegate
    
    func didSelectActionButton() {
        requestHealthAuthorization()
    }
    
    func requestHealthAuthorization() {
        print("Requesting HealthKit authorization...")
        
        // HealthKitがサポートされているデバイスであるか確認
        // このあとで、HealthStoreを操作する
        if !HKHealthStore.isHealthDataAvailable() {
            presentHealthDataNotAvailableError()
            
            return
        }
        // 認証を要求する。読み込み、書き込みはreadTypesで判断
        healthStore.requestAuthorization(toShare: shareTypes, read: readTypes) { (success, error) in
            var status: String = ""
            
            if let error = error {
                status = "HealthKit Authorization Error: \(error.localizedDescription)"
            } else {
                // 許可申請が成功
                if success {
                    if self.hasRequestedHealthData {
                        status = "You've already requested access to health data. "
                    } else {
                        status = "HealthKit authorization request was successful! "
                    }
                    
                    status += self.createAuthorizationStatusDescription(for: self.shareTypes)
                    
                    self.hasRequestedHealthData = true
                } else {
                    status = "HealthKit authorization did not complete successfully."
                }
            }
            
            print(status)
            
            // 結果はバックグラウンドのスレッドで戻ってくる。UIの更新をメインスレッドにディスパッチする。
            DispatchQueue.main.async {
                self.descriptionLabel.text = status
            }
        }
    }
    
    // MARK: - Helper Functions
    
    private func createAuthorizationStatusDescription(for types: Set<HKObjectType>) -> String {
        var dictionary = [HKAuthorizationStatus: Int]()
        
        for type in types {
            let status = healthStore.authorizationStatus(for: type)
            
            if let existingValue = dictionary[status] {
                dictionary[status] = existingValue + 1
            } else {
                dictionary[status] = 1
            }
        }
        
        var descriptionArray: [String] = []
        
        if let numberOfAuthorizedTypes = dictionary[.sharingAuthorized] {
            let format = NSLocalizedString("AUTHORIZED_NUMBER_OF_TYPES", comment: "")
            let formattedString = String(format: format, locale: .current, arguments: [numberOfAuthorizedTypes])
            
            descriptionArray.append(formattedString)
        }
        if let numberOfDeniedTypes = dictionary[.sharingDenied] {
            let format = NSLocalizedString("DENIED_NUMBER_OF_TYPES", comment: "")
            let formattedString = String(format: format, locale: .current, arguments: [numberOfDeniedTypes])
            
            descriptionArray.append(formattedString)
        }
        if let numberOfUndeterminedTypes = dictionary[.notDetermined] {
            let format = NSLocalizedString("UNDETERMINED_NUMBER_OF_TYPES", comment: "")
            let formattedString = String(format: format, locale: .current, arguments: [numberOfUndeterminedTypes])
            
            descriptionArray.append(formattedString)
        }
        
        // 文章に複数の節がある場合は、文法に合わせてフォーマットします。
        if let lastDescription = descriptionArray.last, descriptionArray.count > 1 {
            descriptionArray[descriptionArray.count - 1] = "and \(lastDescription)"
        }
        
        let description = "Sharing is " + descriptionArray.joined(separator: ", ") + "."
        
        return description
    }
    
    private func presentHealthDataNotAvailableError() {
        let title = "Health Data Unavailable"
        let message = "Aw, shucks! We are unable to access health data on this device. Make sure you are using device with HealthKit capabilities."
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default)
        
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
}
