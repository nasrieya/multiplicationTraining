//
//  ContentView.swift
//  MultiplicationPractice
//
//  Created by Eya Nasri on 26/5/2021.
//

import SwiftUI
struct  Question{
    var questionText: String
    var answer: Int
}


struct ContentView: View {
    @State private var playingMode = false
    @State private var settingMode = true
    @State private var result = ""
    @State private var score = 0
    @State private var multiplicationTable = 1
    @State private var questionsNumber = 0
    @State private var currentQuestion = 0
    @State private var totalQuestion = 0
    @State private var showScore = false

    
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    let questionsNumbers = ["3", "5", "10", "All"]
    @State private var questions: [Question] = []
    var body: some View {
        NavigationView {
                Group {
                    if playingMode && !settingMode {
                        Form {
                            Text(questions[currentQuestion].questionText)
                            TextField("result", text: $result)
                                .keyboardType(.decimalPad)
                            Button("Next"){
                                nextQuestion()
                            }
                                }
                    } else {
                        Form {
                            VStack(alignment: .leading, spacing: 10) {

                                Text("Practicing multiplication table")
                                    .font(.headline)

                                Stepper(value: $multiplicationTable, in: 1...12 ){
                                    Text("multiplication table is \(multiplicationTable)")
                                }
                            }
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text("How many questions you want ?")
                                    .font(.headline)

                                Picker("tip percentage", selection: $questionsNumber){
                                        ForEach(0 ..< questionsNumbers.count){
                                            Text("\(self.questionsNumbers[$0])")
                                        }
                                    }.pickerStyle(SegmentedPickerStyle())
                                }
                            }
                        Button("Play"){
                            startGame()
                                }
                            .padding()
                            .background(Color(red: 0, green: 0, blue: 0.9))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                }
                .navigationBarTitle("Multiplication Practice")
                .navigationBarItems(trailing:
                                        Button("restart"){
                                           restartGame()
                                        })
            
            }.alert(isPresented: $showScore) {
                Alert(title: Text("Score"), message: Text("Your score is \(score)"), dismissButton:
                        .default(Text("restart")) {
                            self.restartGame()
                        })
                        
            }
        }
    
    func nextQuestion(){
        totalQuestion -= 1
        if(Int(result) == questions[currentQuestion].answer){
            score += 1
        }
        if totalQuestion == 0 {
            showScore = true
        } else {
            
            currentQuestion += 1
            
        }
        print(score)
        result = ""
        
        
    }
   func questionsGenerator(number: Int){
        for itr in 1...12 {
            questions.append(Question(questionText: "what is \(number) x \(itr) ?", answer: itr*number))
        }
    questions.shuffle()
    }
    
    
    func startGame(){
        playingMode = true
        settingMode = false
        questionsGenerator(number: multiplicationTable)
        switch questionsNumber {
        case 0:
            totalQuestion = 3
        case 1:
            totalQuestion = 5
        case 2:
            totalQuestion = 10
        default:
            totalQuestion = 12
        }
    }
    
    
    func restartGame(){
        playingMode = false
        settingMode = true
        multiplicationTable = 1
        questionsNumber = 0
        questions.removeAll()
        currentQuestion = 0
        score = 0
        result = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

