//
//  ContentView.swift
//  HWS Challenge Unit Converter
//
//  Created by Aaron Burbach on 7/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputAmount = 0.0
    @State private var selectedInputUnit = "lb"
    @State private var selectedOutputUnit = "lb"
    @FocusState private var amountIsFocused: Bool
    
    let validUnits = ["lb", "cwt", "ton"]
    
    var convertedAmount: Double {
        var convertedAmount = 0.0
        
        if (inputAmount == 0) { return convertedAmount }
                
        switch selectedInputUnit {
            case "lb":
                switch selectedOutputUnit {
                    case "lb":
                        convertedAmount = inputAmount
                    case "cwt":
                        convertedAmount = poundsToHundredweights(pounds: inputAmount)
                    case "ton":
                        convertedAmount = poundsToTons(pounds: inputAmount)
                    default:
                        convertedAmount = inputAmount
                }
            case "cwt":
                switch selectedOutputUnit {
                    case "lb":
                        convertedAmount = hundredweightsToPounds(hundredweights: inputAmount)
                    case "cwt":
                        convertedAmount = inputAmount
                    case "ton":
                        convertedAmount = hundredweightsToTons(hundredweights: inputAmount)
                    default:
                        convertedAmount = inputAmount
                }
            case "ton":
            switch selectedOutputUnit {
                case "lb":
                    convertedAmount = tonsToPounds(tons: inputAmount)
                case "cwt":
                    convertedAmount = tonsToHundredweights(tons: inputAmount)
                case "ton":
                    convertedAmount = inputAmount
                default:
                    convertedAmount = inputAmount
            }
            default:
                convertedAmount = 0.0
        }
        return convertedAmount
    }
    
    func poundsToHundredweights(pounds: Double) -> Double {
        return pounds / 100
    }
    
    func poundsToTons(pounds: Double) -> Double {
        return pounds / 2000
    }
    
    func hundredweightsToPounds(hundredweights: Double) -> Double {
        return hundredweights * 100
    }
    
    func hundredweightsToTons(hundredweights: Double) -> Double {
        return (hundredweights * 100) / 2000
    }
    
    func tonsToPounds(tons: Double) -> Double {
        return tons * 2000
    }
    
    func tonsToHundredweights(tons: Double) -> Double {
        return (tons * 2000) / 100
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Input Unit", selection: $selectedInputUnit) {
                        ForEach(validUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Unit to convert from...")
                }
                
                Section {
                    TextField("Amount to Convert", value: $inputAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Amount to Convert")
                }
                
                Section {
                    Picker("Output Unit", selection: $selectedOutputUnit) {
                        ForEach(validUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Unit to convert to...")
                }
            
                Section {
                    Text(convertedAmount.formatted())
                } header: {
                    Text("The converted amount is:")
                }
            }
            .navigationTitle("HWS Converter App")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
