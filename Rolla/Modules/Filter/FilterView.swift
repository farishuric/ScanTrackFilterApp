//
//  FilterView.swift
//  Rolla
//
//  Created by Faris Hurić on 10. 9. 2023..
//

import SwiftUI

enum Sort {
    case ascending, descending
    
    var title: String {
        switch self {
        case .ascending:
            return "Ascending"
        case .descending:
            return "Descending"
        }
    }
}

class SortingViewModel: ObservableObject {
    @Published var sortingTime: Double = 0.0
    @Published var isSorting = false
    @Published var sortType: Sort = .descending
    @Published var firstTenInArray: [Int] = []
    
    func generateAndSortCollection(sortType: Sort) {
        isSorting = true
        firstTenInArray = []
        
        // Create a background queue
        let backgroundQueue = DispatchQueue.global(qos: .background)
        
        backgroundQueue.async { [self] in
            let startTime = CACurrentMediaTime()
            
            // Generate a collection of 25,000,000 random integers
            var collection = (0..<100).map { _ in Int.random(in: 0..<10000) }
            
            // Sort the collection
            switch sortType {
            case .ascending:
                collection.sort(by: >)
                DispatchQueue.main.async {
                    self.isSorting = false
                    self.firstTenInArray += collection[0...11]
                }
                
            case .descending:
                collection.sort(by: <)
                DispatchQueue.main.async {
                    self.isSorting = false
                    self.firstTenInArray += collection[0...11]
                }
            }
            
            let endTime = CACurrentMediaTime()
            sortingTime = endTime - startTime
            
            // Update the UI on the main queue
            
        }
    }

    
    func toggleSortType() {
        if sortType == .ascending {
            sortType = .descending
        } else {
            sortType = .ascending
        }
    }
}

struct FilterView: View {
    @StateObject private var viewModel = SortingViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    if viewModel.isSorting {
                        ProgressView("Sorting...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                    } else {
                        PrimaryButton(buttonLabel: "Sort \(viewModel.sortType.title)", color: .purple) {
                            viewModel.isSorting = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                viewModel.generateAndSortCollection(sortType: viewModel.sortType)
                            }
                            viewModel.toggleSortType()
                        }
                        .padding()
                    }
                }
                .frame(minHeight: 56)
                
                Text("Time Taken: \(viewModel.sortingTime) seconds")
                    .padding()
                
                VStack {
                    List(viewModel.firstTenInArray, id: \.self) { element in
                        Text("\(element)")
                    }
                }
            }
            .navigationTitle("Sorting")
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
