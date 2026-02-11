//
//  ContentView.swift
//  LLM_Promt_App
//
//  Created by Vishal Kothari on 11/02/26.
//

import SwiftUI

struct ContentView: View {
    @State private var question = ""
    @State private var answer = ""
    @State private var isLoading = false
    var body: some View {
        VStack {
            
            TextField("Ask something...", text: $question)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocorrectionDisabled(true)
            
            Button("Send") {
                isLoading = true
                askBackend(question: question) { response in
                    DispatchQueue.main.async {
                        isLoading = false
                        self.answer = response ?? "Error"
                    }
                }
            }.disabled(question.isEmpty)

            // Show loading indicator if API is in progress
              if isLoading {
                  ProgressView()
                      .padding()
              }
            
            TextEditor(text: $answer)
                .padding()
            }
            .padding()
            .onChange(of: question) { newValue in
                   // Clear the answer as soon as user types
                answer = ""
            }
    }
}

#Preview {
    ContentView()
}
