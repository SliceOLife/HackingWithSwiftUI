//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jordi van Hoorn on 10/10/2020.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany",
                            "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    @State private var answerCorrect = false
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors:[.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                VStack {
                    Text("Tap the flag of").foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number]).renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black,lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                    
                }
                Text("Current Score: \(currentScore)")
                    .foregroundColor(.white)
                Spacer()
            }
        }.alert(isPresented: $showingScore, content: {
            if self.answerCorrect {
                return Alert(title: Text(scoreTitle), message: Text("Your score is \(currentScore)"), dismissButton: .default(Text("Continue")) {
                        self.askQuestion()})
                
            } else {
                return Alert(title: Text(scoreTitle), message: Text("Sorry! That's the wrong flag!"), dismissButton: .default(Text("Continue")) {
                        self.askQuestion()})
            }
        })
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            answerCorrect = true
            currentScore += 1
        }else{
            scoreTitle = "Wrong"
            answerCorrect = false
            currentScore -= 1
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
