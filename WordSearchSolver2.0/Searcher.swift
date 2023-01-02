//
//  Searcher.swift
//  WordSearchSolver2.0
//
//  Created by Aiden Favish on 1/1/23.
//

import SwiftUI

struct Searcher: View {
    var width: Int
    var height: Int
    @State var searchedWord = ""
    var Jumble: String
    @State var display1: NSMutableAttributedString
    @State var isLoading = false
    @State var error = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text(AttributedString(display1))
                    .font(.custom("Courier", fixedSize: 25))
                    .padding()
                    .background(
                        Color.gray.opacity(0.25)
                    )
                    .cornerRadius(25)
                
                HStack {
                    Button(action: {
                        isLoading = true
                        let start:String = searchedWord.uppercased()
                        var Word:[String] = []
                        let gridLayout = [width, height]
                        print(String(width) + " with a l of " + String(height))
                        for i in 0...start.count-1 {
                            Word.append(String(start[start.index(start.startIndex, offsetBy: i)]))
                        }
                        /* map
                         ABCDE
                         FGHIJ
                         KLMNO
                         PQRST
                         UVWXY*/
                        //Data Types
                        struct Position: Hashable {
                            var Xaxis: Int = 0
                            var Yaxis: Int = 0
                        }
                        struct Point: Hashable {
                            var position: Position
                            var letter: String
                            var index: Int
                            var trend = -1
                        }

                        //Constants
                        
                        
                        let Moves = [Position(Xaxis: -1, Yaxis: 1), Position(Xaxis: 0, Yaxis: 1), Position(Xaxis: 1, Yaxis: 1), Position(Xaxis: -1, Yaxis: 0), Position(Xaxis: 1, Yaxis: 0), Position(Xaxis: -1, Yaxis: -1), Position(Xaxis: 0, Yaxis: -1), Position(Xaxis: 1, Yaxis: -1)]

                        //Master variables
                        var Map: [Point] = []
                        var Seeds: [Point] = []
                        var ActiveSeeds: [Point] = []
                        var onCall: [Point] = []
                        var FinalProduct: [Point] = []
                        
                        //Sorting and preparing data
                        var Acounter = 0
                        var Xcounter = 0
                        var Ycounter = gridLayout[1]-1
                        for i in 0...Jumble.count-1 {
                            let UTP = Jumble[Jumble.index(Jumble.startIndex, offsetBy: i)]
                            Map.append(Point(position: Position(Xaxis: Xcounter, Yaxis: Ycounter), letter: String(UTP), index: i))
                            print(String(UTP) + " is " + String(Map[i].position.Xaxis) + " and " + String(Map[i].position.Yaxis))
                            Acounter += 1
                            Xcounter += 1
                            if Acounter == gridLayout[0] {
                                Ycounter -= 1
                                Xcounter = 0
                                Acounter = 0
                            }
                        }


                        if display1.string.count > 2 {
                            //Seeding
                            for i in Map {
                                if i.letter == Word[0] {
                                    Seeds.append(i)
                                }
                            }



                            //Stubs
                            for i in Seeds {
                                for g in 0...Moves.count-1 {
                                    for h in Map {
                                        if h.position.Xaxis == (i.position.Xaxis + Moves[g].Xaxis) && h.position.Yaxis == (i.position.Yaxis + Moves[g].Yaxis) && h.letter == Word[1] {
                                            ActiveSeeds.append(Point(position: h.position, letter: h.letter, index: h.index, trend: g))
                                        }
                                    }
                                }
                            }

                            //Sorting Stubs
                            for i in ActiveSeeds {
                                onCall.append(i)
                                for g in 2...Word.count-1 {
                                    for h in Map {
                                        if h.position.Xaxis == (i.position.Xaxis + (Moves[i.trend].Xaxis * (g-1))) && h.position.Yaxis == (i.position.Yaxis + (Moves[i.trend].Yaxis * (g-1))) && h.letter == Word[g] {
                                            onCall.append(Point(position: h.position, letter: h.letter, index: h.index, trend: i.trend))
                                        }
                                    }
                                }
                                if onCall.count == Word.count - 1 {
                                    FinalProduct = onCall
                                    onCall = []
                                } else {
                                    onCall = []
                                }
                            }

                            //Finalize
                            sleep(1)
                            if FinalProduct.count > 0 {
                                for i in Seeds {
                                    if i.position.Xaxis == (FinalProduct[0].position.Xaxis + invertTrend(trend: FinalProduct[0].trend).Xaxis) && i.position.Yaxis == (FinalProduct[0].position.Yaxis + invertTrend(trend: FinalProduct[0].trend).Yaxis) {
                                        FinalProduct.insert(Point(position: i.position, letter: i.letter, index: i.index, trend: FinalProduct[0].trend), at: 0)
                                    }
                                }
                            } else {
                                error = true
                            }

                        } else {
                            error = true
                        }
                        //Functions
                        func invertTrend(trend:Int) -> Position {
                            var result: Position
                            var x: Int = Moves[trend].Xaxis
                            var y: Int = Moves[trend].Yaxis
                            if Moves[trend].Xaxis == 1 {
                                x = -1
                            } else if Moves[trend].Xaxis == -1 {
                                x = 1
                            }
                            
                            if Moves[trend].Yaxis == 1 {
                                y = -1
                            } else if Moves[trend].Yaxis == -1 {
                                y = 1
                            }
                            
                            result = Position(Xaxis: x, Yaxis: y)
                            
                            return result
                        }

                        //End
                        print("End")
                        for i in FinalProduct {
                            print(i.letter + " with cordinates of: (" + String(i.position.Xaxis) + ", " + String(i.position.Yaxis) + ") with trend of: " + String(i.trend))
                            error = false
                        }
                        let string: String = display1.string
                        let attributedString = NSMutableAttributedString.init(string: string)
                        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.label, range: NSRange(location: 0, length: string.count))
                        if FinalProduct.count == Word.count {
                            print("END")
                            //let range = (string as NSString).range(of: "ABC")
                            for i in FinalProduct {
                                var locate = 1
                                print(Int(i.position.Xaxis)+(((gridLayout[1]-1) - Int(i.position.Yaxis))*gridLayout[0]-1))
                                print(i.letter + " with " + String(i.position.Xaxis) + ", " + String(i.position.Yaxis))
                                locate = Int(i.position.Xaxis) + ((gridLayout[1]-1) - i.position.Yaxis)*gridLayout[0] + ((gridLayout[1]-1) - i.position.Yaxis)
                                
                                let range = (NSRange(location: locate, length: 1))
                                attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: range)
                                locate = 0
                            }
                            display1 = attributedString
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                            
                            isLoading = false
                        }
                    }){
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.blue)
                                .frame(width: 80, height: 40)
                            Text("Search")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.leading)
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.gray)
                            .opacity(0.25)
                            .frame(height: 40)
                        TextField("Enter word", text: $searchedWord)
                            .padding(.horizontal)
                    }.padding(.trailing)
                    
                }.padding(.vertical)
                
                
                if error {
                    Text("Error, try again")
                        .foregroundColor(.red)
                }
                
            }
        }.navigationTitle("Search")
    }
}

struct Searcher_Previews: PreviewProvider {
    static var previews: some View {
        Searcher(width: 3, height: 3, Jumble: "ABCDEFGHI", display1: NSMutableAttributedString.init(string: "ABC\nDEF\nGHI"))
    }
}
