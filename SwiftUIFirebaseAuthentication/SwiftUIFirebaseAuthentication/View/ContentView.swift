//
//  ContentView.swift
//  SwiftUIFirebaseAuthentication
//
//  Created by yoshiiikoba on 2022/02/05.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var authStateManager = FirebaseAuthStateManager()
    @State var isShowSheet = false
    
    var body: some View {
        VStack {
            if authStateManager.signInState == false {
                // Sign-Out状態なのでSign-Inボタンを表示する
                Button(action: {
                    self.isShowSheet.toggle()
                }) {
                    Text("Sign-In")
                }
            } else {
                // Sign-In状態なのでSign-Outボタンを表示する
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                    } catch {
                        print("Error")
                    }
                }) {
                    Text("Sign-Out")
                }
            }
        }
        .sheet(isPresented: $isShowSheet) {
            FirebaseUIView(isShowSheet: self.$isShowSheet)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
