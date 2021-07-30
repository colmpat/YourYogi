//
//  InsightsViewModel.swift
//  YourYogi
//
//  Created by Colm Lang on 7/20/21.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class InsightsViewModel: ObservableObject {
    @Published var routines = [CompletedRoutine]()
    
    @Published var routinesByYear = [RoutinesInYear]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var noRoutines = true
    
    @Published var selectedRoutine: CompletedRoutine?
    
    init() {
        RoutineRepository.shared.$routines
            .map { routine in
                return routine.isEmpty
            }
            .assign(to: \.noRoutines, on: self)
            .store(in: &cancellables)
        
        RoutineRepository.shared.$routines
            .assign(to: \.routines, on: self)
            .store(in: &cancellables)
        
        self.$routines
            .map { routines in
                
                let dateStringFormatter = DateFormatter()
                dateStringFormatter.dateFormat = "MMMM"
                
                //we can get all of the years of completed routines with this dictionary's keys(note this is [String : [CompletedRoutine]])
                let routinesByYear = self.getDatesGroupedByYearDictionary(routines: routines)
                //we can now insert each of the years we found as RoutinesInYear objects
                var years = [RoutinesInYear]()
                for year in routinesByYear.keys {
                    //first we group the array for the current year into an array of RoutinesOnDate objects
                    let routinesOnDates = self.getRoutinesOnDates(routines: routinesByYear[year]!)
                    //then we group those elements in routinesOnDates array into an array of RoutinesInMonths and append a new element to years
                    let routinesInMonths = self.getRoutinesInMonths(routinesOnDates: routinesOnDates)
                    years.append(RoutinesInYear(year: year, monthsAndRoutines: routinesInMonths))
                }
                
                //then we can return the yearDictionary
                return self.sortYears(years: years)
            }
            .assign(to: \.routinesByYear, on: self)
            .store(in: &cancellables)
        
    }
    //sort the years and dates (most recent first)
    private func sortYears(years: [RoutinesInYear]) -> [RoutinesInYear] {
        //first sort by years (highest first)
        var sortedYears = years.sorted {
            return $0.year > $1.year
        }
        //then for each year, sort by months (most recent first)
        for i in sortedYears.indices {
            sortedYears[i].monthsAndRoutines.sort {
                let months = ["January":1,"February":2,"March":3,"April":4,"May":5,"June":6,"July":7,"August":8,"September":9,"October":10,"November":11,"December":12]
                if let month1 = months[$0.month], let month2 = months[$1.month] {
                    return month1 > month2
                } else {
                    return false //unreachable
                }
            }
            //then sort this month by its dates
            for j in sortedYears[i].monthsAndRoutines.indices {
                sortedYears[i].monthsAndRoutines[j].datesAndRoutines.sort {
                    return $0.date > $1.date
                }
            }
        }
        return sortedYears
    }
    
    private func getRoutinesOnDates(routines: [CompletedRoutine]) -> [RoutinesOnDate] {
        var routinesOnDates = [RoutinesOnDate]()
        
        Dictionary(grouping: routines, by: { routine in
            
            let date = routine.dateCompleted!.dateValue()
            return Calendar.current.startOfDay(for: date)
            
        }).forEach { (key, value) in
            routinesOnDates.append(RoutinesOnDate(date: key, routines: value))
        }
        return routinesOnDates
    }
    
    private func getRoutinesInMonths(routinesOnDates: [RoutinesOnDate]) -> [RoutinesInMonth] {
        var routinesInMonths = [RoutinesInMonth]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        Dictionary(grouping: routinesOnDates, by: {dateFormatter.string(from: $0.date)}).forEach { (key, value) in
            routinesInMonths.append(RoutinesInMonth(month: key, datesAndRoutines: value))
        }
        return routinesInMonths
    }
    
    private func getDatesGroupedByYearDictionary(routines: [CompletedRoutine]) -> Dictionary<String, [CompletedRoutine]> {
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        return Dictionary(grouping: routines, by: {yearFormatter.string(from: $0.dateCompleted!.dateValue())})
    }
}
struct RoutinesOnDate: Hashable {
    static func == (lhs: RoutinesOnDate, rhs: RoutinesOnDate) -> Bool {
        return lhs.date == rhs.date && lhs.routines.elementsEqual(rhs.routines)
    }
    
    let date: Date
    var routines: [CompletedRoutine]
}
struct RoutinesInMonth: Hashable {
    let month: String
    var datesAndRoutines: [RoutinesOnDate]
}
struct RoutinesInYear: Hashable {
    let year: String
    var monthsAndRoutines: [RoutinesInMonth]
}
