//
//  File.swift
//  TaskApp
//
//  Created by Yoshinori Kobayashi on 2020/10/23.
//

import SwiftUI
import CoreData

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    
    // Fetching Data.....
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Task>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            
            VStack(spacing: 0){
                
                HStack{
                    
                    Text("Tasks")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                
                // Empty View....
                
                if results.isEmpty{
                    
                    Spacer()
                    
                    Text("タスクがありません")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                    
                    Spacer()
                }
                else{
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        
                        LazyVStack(alignment: .leading,spacing: 20){
                            
                            ForEach(results){task in
                                
                                VStack(alignment: .leading, spacing: 5, content: {
                                    
                                    Text(task.content ?? "")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        
                                    Text(task.date ?? Date(),style: .date)
                                        .fontWeight(.bold)
                                })
                                .foregroundColor(.black)
                                .contextMenu{
                                    
                                    Button(action: {homeData.EditItem(item: task)}, label: {
                                        Text("Edit")
                                    })
                                    
                                    Button(action: {
                                        context.delete(task)
                                        try! context.save()
                                    }, label: {
                                        Text("Edit")
                                    })
                                }
                            }
                        }
                        .padding()
                    })
                }
            }
            
            // Add Button...
            
            Button(action: {homeData.isNewData.toggle()}, label: {
                
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                    
                        AngularGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), center: .center)
                    )
                    .clipShape(Circle())
            })
            .padding()
        })
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $homeData.isNewData, content: {
            
            NewDataView(homeData: homeData)
        })
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
