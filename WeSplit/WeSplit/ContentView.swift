//
//  ContentView.swift
//  WeSplit
//
//  Created by Jordi on 08/10/2020.
//  Copyright © 2020 0x5b62. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = "2"
    @State private var tipPercentage = 2
    
    let tipPercentages = [10,15,20,25,0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0 + 2
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let amountPerPerson = (orderAmount + (orderAmount / 100 * tipSelection)) / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmountWithTip: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let totalAmount = orderAmount + (orderAmount / 100 * tipSelection)
        
        return totalAmount
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    /*Picker("Number of people", selection: $numberOfPeople) {
                     ForEach(2..<100) {
                     Text("\($0) people")
                     }*/
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("What tip percentage do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total amount including tip")) {
                    Text("$\(totalAmountWithTip, specifier: "%.2f")")
                }
                
                Section(header: Text("Total per person including tip")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
