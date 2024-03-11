//
//  ContentView.swift
//  RPS
//
//  Created by Mykhailo Kravchuk on 22/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var choiceUserToWin = "Win"
    @State private var randomCellenge = Bool.random()
    @State private var choiceUser = "Paper"
    @State private var choiceUsers = ["Rock", "Scissors", "Paper"]
    @State private var machineChoice  = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var score = 0
    @State private var showalert = false
    @State private var userCoise = ""
    @State private var machinepick = ""
    @State private var result = ""
    @State private var isHelpVisible = false
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .white, .pink, .purple, .green, .yellow,.white , .orange]), startPoint: .top, endPoint: .bottom)
                .blur(radius: 100, opaque: true)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("RPS")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.secondary)
                VStack(spacing: 20){
                    
                    VStack{
                        Text("Machine pick")
                            .foregroundStyle(.primary)
                            .font(.subheadline)
                        Text("\(machineChoice[1])")
                            .font(.headline)
                    }
                    VStack{
                        Text("Chellenge")
                        Text("\(randomCellenge == true ? "Win": "Lose")")
                            .foregroundStyle(randomCellenge == true ? .green : .red)
                            .font(.title2)
                    }
                    .padding()
                    
                    VStack{
                        Text("Pick your chouse")
                        HStack{
                            
                            ForEach(0..<3){ pic in
                                Button{ tappedPic(pic: pic)
                                    userCoise = choiceUsers[pic]
                                machinepick = machineChoice[1]
                                }label:{
                                    
                                    Text(choiceUsers[pic])
                                        .frame(width: 70)
                                        .padding(5)
                                        .background(.brown)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                        .padding(.leading,30)
                                }
                            }
                        }
                        .offset(x: -10)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Material.regular)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding()
                
                Spacer()
                HStack {
                    Spacer()
                            if isHelpVisible {
                                CloudView(content: """
                                          Welcome to the Rock, Paper, Scissors Challenge game! Your task is to correctly choose the next move to either win or lose the game. Each turn of the game, the program randomly selects either rock, paper, or scissors. If the program chooses Rock and Win, you need to select Paper to win. But if the program chooses Rock and Lose, you need to select Scissors to lose. You can earn a point if you choose the correct move or lose a point if you make the wrong move. The game consists of 10 questions, after which you will see your final score. Are you ready? Let's test your skills in the Rock, Paper, Scissors Challenge game!
                                          """)
                                {
                                    withAnimation {
                                        isHelpVisible.toggle()
                                    }
                                }
                            } else {
                                Button(action: {
                                    withAnimation {
                                        isHelpVisible.toggle()
                                    }
                                }) {
                                    Image(systemName: "exclamationmark.circle")
                                        .foregroundColor(.blue)
                                        .font(.largeTitle)
                                }
                            }
                        }
                .padding()
                
            }
            .alert(isPresented: $showalert) {
                            Alert(
                                title: Text("Attention"),
                                message: Text(result),
                                dismissButton: .default(Text("OK")) {
                                    restartGame()
                                }
                            )
                        }
            
            }
        }
    func tappedPic(pic: Int){
        let userChoice = choiceUsers[pic]
        let machineChoice = machineChoice[1] // Assuming you want the first choice of the machine
        
        
        if randomCellenge == true {
            if userChoice == machineChoice {
                result = "It's a tie!"
            } else if (userChoice == "Rock" && machineChoice == "Scissors") ||
                        (userChoice == "Paper" && machineChoice == "Rock") ||
                        (userChoice == "Scissors" && machineChoice == "Paper") {
                result = "You win!"
            } else {
                result = "You lose!"
            }
        }
        else{
            if userChoice == machineChoice {
                result = "It's a tie!"
            } else if (userChoice == "Rock" && machineChoice == "Scissors") ||
                        (userChoice == "Paper" && machineChoice == "Rock") ||
                        (userChoice == "Scissors" && machineChoice == "Paper") {
                result = "You lose!"
            } else {
                result = "You win!"
            }
        }
        showalert = true
    }
                func restartGame() {
                    score = 0
                    machineChoice.shuffle()
                    randomCellenge = Bool.random()
                }
                }


struct CloudView: View {
    let content: String
    let onTap: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    onTap()
                }
            HStack {
                Text(content)
                    .padding()
                    .foregroundColor(.black)
                    .font(.headline)
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
