//
//  NewDataView.swift
//  TaskApp
//
//  Created by Yoshinori Kobayashi on 2020/10/23.
//
import SwiftUI

struct NewDataView: View {
    @ObservedObject var homeData : HomeViewModel
    @Environment(\.managedObjectContext) var context
    var body: some View {
        
        VStack{
            
            HStack{
                
                Text("\(homeData.updateItem == nil ? "追加" : "更新") タスク")
                    .font(.system(size: 65))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            
            TextEditor(text: $homeData.content)
                .padding()
            
            Divider()
                .padding(.horizontal)
            
            HStack{
                
                Text("いつ")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            
            HStack(spacing: 10){
                
                DateButton(title: "今日", homeData: homeData)
                
                DateButton(title: "明日", homeData: homeData)
                
                // Date Picker...
                
                DatePicker("", selection: $homeData.date, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
            
            // Add Button....
            
            Button(action: {homeData.writeData(context: context)}, label: {
                
                Label(
                    title: { Text(homeData.updateItem == nil ? "追加" : "更新")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    },
                    icon: { Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                    })
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(
                    
                        LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(8)
            })
            .padding()
            // disabling button when no data...
            .disabled(homeData.content == "" ? true : false)
            .opacity(homeData.content == "" ? 0.5 : 1)
        }
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
    }
}


struct NewDataView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
