//
//  HomeViewModel.swift
//  TaskApp
//
//  Created by Yoshinori Kobayashi on 2020/10/23.
//

import SwiftUI
import CoreData

class HomeViewModel:ObservableObject {
    
    @Published var content = ""
    @Published var date = Date()
    
    // For NewData Sheet ...
    @Published var isNewData = false
    
    // Checking And Updating Date...
    @Published var updateItem : Task!
    
    let calendar = Calendar.current
    func checkDate()->String{
        if calendar.isDateInToday(date) {
            return "今日"
        } else if calendar.isDateInToday(date) {
            return "明日"
        } else {
            return "他の日"
        }
    }
    func updateDate(value: String) {
        if value == "今日" {
            date = Date()
        } else if value == "明日" {
            date = calendar.date(byAdding: .day,value: 1, to: Date())!
        } else {
            // なにかの処理
        }
    }
    func writeData(context : NSManagedObjectContext) {
        // Updating Item ....
        if updateItem != nil {
            // Means Update Old Data ...
            updateItem.date = date
            updateItem.content = content
            
            try! context.save()
            
            updateItem = nil
            isNewData.toggle()
            content = ""
            date = Date()
            return
        }
        let newTask = Task(context: context)
        newTask.date = date
        newTask.content = content
        
        do {
            try context.save()
            
            isNewData.toggle()
            content = ""
            date = Date()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func EditItem(item: Task) {
        updateItem = item
        
        date = item.date!
        content = item.content!
        isNewData.toggle()
    }
        
    
    
}
