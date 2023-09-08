//
//  ProtectedSheet.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/3/23.
//

import SwiftUI

enum QuizResult {
    case notDetermined
    case wrong
    case right
}

struct ProtectedSheet: View {
    
//    @Binding var openingAttempts: Int
    let app: ShortcutsAppEntity
    
    @State private var result: QuizResult = .notDetermined
    
    @State private var question: Quiz = Quiz.allQuestions.randomElement() ?? Quiz.allQuestions.first!
    
    @State private var answeredQuestion: Bool = false
    @State private var correct: Bool? = nil
    
    @State private var answer: String = ""
    
    var color: Color {
        switch result {
        case .notDetermined:
            return .gray
        case .wrong:
            return .red
        case .right:
            return .green
        }
    }
    
    func check() {
        
        if Int(answer) == Int(question.answer) {
            result = .right
        } else {
            result = .wrong
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                self.answeredQuestion = true
            }
        }
    }
    
    var body: some View {
        NavigationSceleton(navigationBarTitle: "Question Time!", subTitle: "", navbarDisplayMode: .inline, contentWrapper: .scrollView, navType: .navigationView) {
            
            VStack(spacing: 50) {
                Question(question.question)
                QuestionInput(quiz: question)
            }
            .padding(.top, 100)
            
        } bottomContent: {
            Button(action: {
                check()
            }, label: {
                PrimaryButtonLabel(buttonText: "Answer", buttonState: !answer.isEmpty ? .isEligible : .notEligible, isProgressing: false)
            })
            
        } navbarLargeContent: {
            
        } navbarLeading: {
            
        } navbarCenter: {
            Logo(size: 40)
        } navbarTrailing: {
            
        }
        .overlay {
            if answeredQuestion {
              Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .overlay {
                        VStack (){
                            Logo(size: 100)
                            Text("You opened \(app.appName)")
                            Text("3x Times today")
                                .padding(.bottom, 50)
                            
                            Button(action: {
                                // Send application to background
                                
                                if let url = URL(string: "home://") {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }
                                
                                self.answeredQuestion = false
                                self.question = Quiz.allQuestions.randomElement() ?? Quiz.allQuestions.first!
                                self.answer = ""
                                self.result = .notDetermined
                                
                            }, label: {
                                PrimaryButtonLabel(buttonText: "Do not open Instagram", buttonState: .isEligible, isProgressing: false)
                            })
                           
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    // Send application to background
                                    if let url = URL(string: "instagram://") {
                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                    }
                                    self.answeredQuestion = false
                                    self.question = Quiz.allQuestions.randomElement() ?? Quiz.allQuestions.first!
                                    self.answer = ""
                                    self.result = .notDetermined
                                    
                                }, label: {
                                    Text("Go back to \(app.appName)")
                                        .font(.headline)
                                })
                               
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical)
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.ultraThinMaterial)
                            }
                        }
                        .font(.system(.largeTitle, weight: .semibold))
                        .padding()
                    }
            }
        }
    }
    
    @ViewBuilder
    func Question(_ question: String) -> some View {
        Text(question)
            .font(.system(.title, weight: .bold))
            .padding(.horizontal)
    }
    
    @ViewBuilder
    func QuestionInput(quiz: Quiz) -> some View {
        switch quiz.type {
        case .manual:
            TextField("Answer", text: $answer)
                .font(.system(.largeTitle, weight: .bold))
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(color, lineWidth: 4)
                }
                .padding(.horizontal, 30)
        case .toChooseFrom(let a, let b, let c, let d):
            VStack {
                HStack {
                   ChoosingCell(a)
                    ChoosingCell(b)
                }
                HStack {
                    ChoosingCell(c)
                    ChoosingCell(d)
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    func ChoosingCell(_ a: Double) -> some View {
        HStack {
            Spacer()
            Text("\(Int(a))")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(result == .notDetermined ? .gray : result != .notDetermined && a == question.answer ? .green : .red)
            Spacer()
        }
        .padding()
        .background {
            if result != .notDetermined {
                RoundedRectangle(cornerRadius: 15)
                    .fill(result != .notDetermined && a == question.answer ? .green.opacity(0.1) : .red.opacity(0.1))
            } else {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.ultraThinMaterial)
            }
        }
        .onTapGesture {
            withAnimation {
                self.answer = String(a)
                check()
            }
        }
    }
}

struct ProtectedSheet_Previews: PreviewProvider {
    static var previews: some View {
        ProtectedSheet(app: ShortcutsAppEntity(id: UUID(), appName: "Instagram", appIconData: nil))
    }
}
