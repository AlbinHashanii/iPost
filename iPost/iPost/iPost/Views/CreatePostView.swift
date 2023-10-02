//
//  CreatePostView.swift
//  iPost
//
//  Created by Albin Hashani on 9/26/23.
//

import SwiftUI

struct CreatePostView: View {
    @Environment (\.managedObjectContext) var managedObjectContext
    
    @State private var author = ""
    @State private var title = ""
    @State private var post_description = ""
    @State private var feeling = "Happy"
    @Binding var isPresented: Bool
    @State private var feelingD: Double = 0.0
    @State private var showAlert = false
    let emotions = ["Happy", "Sad", "Angry", "Excited", "Calm", "Tired"]
    

    var body: some View {
        NavigationView {
            Form{
                Section{
                    TextField("Title", text: $title)
                    TextField("Body", text:$post_description)
                    TextField("Author", text:$author)
                    
                    VStack{
                        Slider(value: $feelingD, in: 0...100, step: 20).padding()
                        Text("\(currentEmotion())")
                    }
                    
                    VStack{
                        Spacer()
                        Button("Post"){
                            DataController().addPost(author: author, title: title, post_description: post_description, feeling: feeling, context: managedObjectContext)
                            isPresented = false
                        }
                    }
                }
            }.onChange(of: feelingD) {
                newValue in feeling = currentEmotion()
            }
            .navigationBarItems(trailing: Button("Cancel"){
                isPresented = false
            })
            .navigationTitle("New post")
        }
    
    }
    
    func currentEmotion() -> String {
        switch Int(feelingD) {
        case 0..<20:
           return emotions[0]
        case 20..<40:
            return emotions[1]
        case 40..<60:
            return emotions[2]
        case 60..<80:
            return emotions[3]
        default:
            return emotions[4]
        }
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView(isPresented: .constant(true))
    }
}


