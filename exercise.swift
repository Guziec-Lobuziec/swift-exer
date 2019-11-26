import Foundation
import Glibc

enum DaysofaWeek {
   case Monday
   case Tuesday
   case Wednesday
   case Thursday
   case Friday
   case Saturday
   case Sunday
}

protocol CanBeDone {
    var done: Bool { get }
    func setDone(done: Bool) -> Void
}

class CheckListElement : CustomStringConvertible, CanBeDone {
    let taskName: String
    var done: Bool
    var day: DaysofaWeek
    weak var delegate: Printable?
   
    var statusAsString: String {
        return done ? "Gotowe" : "Do Wykonania"
    }
   
    var dayAsString: String {
        switch day {
            case .Monday:
                return "Poniedziałek"
            case .Tuesday:
                return "Wtorek"
            case .Wednesday:
                return "Środa"
            case .Thursday:
                return "Czwartek"
            case .Friday:
                return "Piątek"
            case .Saturday:
                return "Sobota"
            case .Sunday:
                return "Niedziela"
  
        }
    }
   
    var description: String {
        return "\(dayAsString) \(taskName) -> \(statusAsString)"
    }
   
    func setDone(done: Bool) -> Void {
        self.done = done
        self.delegate?.printContent()
    }
   
    init() {
        self.taskName = ""
        self.done = false
        self.day = DaysofaWeek.Monday
    }
   
    init(taskName: String, done: Bool, day: DaysofaWeek) {
        self.taskName = taskName
        self.done = done
        self.day = day
    }
}

protocol Printable: class {
    func printContent() -> Void
}

class CheckList : Printable {
   var elements: [CheckListElement]
   
   
   func printContent() -> Void {
       for element in elements {
           print(element)
       }
   }
   
   func printEveryThrid() {
        for (index, element) in elements.enumerated() {
            if(index % 3 == 0) {
                print(element)
            }
        }
   }
   
   init(list: [CheckListElement]) {
       self.elements = list
       for element in self.elements {
           element.delegate = self
       }
       
   }
   
   
}

var selected = CheckListElement(taskName: "Kodowanie", done: false, day: .Tuesday)

var elems = [CheckListElement(taskName: "Testowanie", done: true, day: .Monday)
            ,selected
            ,CheckListElement(taskName: "Zakupy", done: false, day: .Friday)
            ,CheckListElement(taskName: "Odwiedzić babcię", done: false, day: .Saturday)
            ]

var list = CheckList(list: elems)

list.printEveryThrid()

selected.setDone(done: true)



