//
//  Debug.swift
//  DebugLog
//
//  Created by yoshiiikoba on 2022/02/19.
//

import Foundation
import SwiftUI

//class Debug: ObservedObject {
//    class func log (_ message:String) {
//        print(message)
//    }
//}

struct DebugView: View {
    var message :String = ""
    var file :String = #file
    var line :String = #line
    var function :String = #function    
    
    var body: some View {
        print(Self._printChanges())
        let _ = print(message + "\(#function)")
        return Text("")
    }
}
