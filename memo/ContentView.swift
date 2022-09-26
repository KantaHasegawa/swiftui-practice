//
//  ContentView.swift
//  memo
//
//  Created by KantaHasegawa on 2022/09/25.
//

import SwiftUI

struct MemoList: View {
    @Binding var memos: [String]
    var Remove: (Int) -> Void
    var body: some View{
        VStack {
            Text("Memo List")
            List(memos.indices, id: \.self) {index in
                Memo(memo: memos[index], index: index, Remove: Remove)
            }
        }
    }
}

struct Memo: View {
    var memo: String
    var index: Int
    var Remove: (Int) -> Void
    var body: some View {
        HStack{
            Text("title: \(memo)")
            Button(action: {Remove(index)}){
                Text("Remove")
            }
        }
    }
}

struct ContentView: View {
    @State private var text: String = ""
    @State private var memos: [String] = []
       
    var body: some View {
        VStack {
            Text("My memo App!!")
                .padding()
            Button(action: {CallAPI()}){
               Text("API Call!!")
            }
            TextField("memo title", text: $text)
            HStack {
                Button(action: {Add()}){
                    Text("add")
                }
            }
            MemoList(memos: $memos, Remove: Remove)
        }
    }
    
    func Add () {
        if text == "" {return}
        memos.append(text)
        text = ""
        return
    }
    
    func Remove (index: Int) {
        memos.remove(at: index)
        return
    }
    
    func CallAPI () {
        let url = URL(string: "http://localhost:3000/users")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in  //非同期で通信を行う
            guard let data = data else { return }
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: [])  // DataをJsonに変換
                print(object)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
