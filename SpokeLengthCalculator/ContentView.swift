//
//  ContentView.swift
//  SpokeLengthCalculator
//
//  Created by mightknow on 2/23/22.
//

import SwiftUI

struct ContentView: View {
    
    let inputList: [String] = [
        "Rim Diameter",
        "Flange Diameter",
        "Center to Flange",
        "Number of Spokes",
        "Number of Cross"
    ]
    
    func getSpokeLength() -> Double {
        
        var rimDiameter: Double = 0
        var flangeDiameter: Double = 0
        var centerToFlange: Double = 0
        var numberOfSpokes: Double = 0
        var numberOfCross: Double = 0
        var spokeLength: Double = 0
        
        func convertToDouble(at index: Int) -> Double {
            if let result = Double(values[index]) {
                return result
            } else {
                return 0
            }
        }
        
        rimDiameter = convertToDouble(at: 0)
        flangeDiameter = convertToDouble(at: 1)
        centerToFlange = convertToDouble(at: 2)
        numberOfSpokes = convertToDouble(at: 3)
        numberOfCross = convertToDouble(at: 4)
        
        print()
        let b7: Double = 720 * (numberOfCross/numberOfSpokes)
        print("B7: " + String(b7))
        let b8: Double = b7/180 * .pi
        print("B8: " + String(b8))
        let b9: Double = (flangeDiameter * sin(b8))/2
        print("B9: " + String(b9))
        let b10: Double = flangeDiameter * cos(b8)
        print("B10: " + String(b10))
        let b11: Double = (rimDiameter - b10)/2
        print("B11: " + String(b11))
        spokeLength = sqrt(b9*b9 + b11*b11 + centerToFlange*centerToFlange)
        
        return spokeLength
    }
    
    @State var values: [String] = ["0","0","0","0","0"]
    
    var body: some View {
        VStack {
            ForEach(0..<5) {i in
                HStack {
                    Text(inputList[i] + ":").frame(maxWidth: .infinity)
                    TextField("", text: $values[i]).frame(maxWidth: .infinity).keyboardType(.numberPad)
                }.padding()
            }
            HStack {
                Text("Spoke Length:").frame(maxWidth: .infinity)
                Text(String(format: "%.2f", getSpokeLength())).frame(maxWidth: .infinity)
            }.padding().padding(.top, 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
