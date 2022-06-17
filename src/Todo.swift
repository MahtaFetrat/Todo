import Foundation

enum SortType {
    case sortByName, sortByDateCreated, sortByDueDate

    func getSorter() -> (Todo, Todo) -> Bool {
        switch self {
        case .sortByName:
            return { $0.name < $1.name }
        case .sortByDateCreated:
            return { $0.dateCreated < $1.dateCreated }
        case .sortByDueDate:
            return { $0.dueDate < $1.dueDate }
        }
    }
}


enum SortOrder {
    case ascending, descending
}


class Todo: CustomStringConvertible {
    private static var lastId = 1
     static var allTodos: [Todo] = []

    var id: Int
    var name: String
    var dueDate: Date
    let dateCreated: Date

    init(name: String, dueDate: Date) {
        Todo.lastId += 1
        self.id = Todo.lastId
        self.name = name
        self.dueDate = dueDate
        self.dateCreated = DateFormatUtils.currentDate()
    }

    static func addTodo(todo: Todo) {
        Todo.allTodos.append(todo)
    }

    var description: String {
        return "\(self.id)\t\(self.name)\t\(DateFormatUtils.toString(date: dueDate))"
    }

    static let listViewHeader: String = "id\tname\tdue date"

    static func sortedTodoList(sortType: SortType, sortOrder: SortOrder) -> [Todo] {
        let sortedTodoList = Todo.allTodos.sorted(by: sortType.getSorter())
        return (sortOrder == .ascending ? sortedTodoList : sortedTodoList.reversed())
    }

    static func deleteTodo(id: Int) -> Bool {
        var deletingIndex = -1
        for (index, todo) in Todo.allTodos.enumerated() {
            if todo.id == id {
                deletingIndex = index
                break;
            }
        }  

        if deletingIndex != -1 {
            Todo.allTodos.remove(at: deletingIndex)
            return true
        }
        return false
    }

    static func getTodosByDueDate(date: Date) -> [Todo] {
        return Todo.allTodos.filter { Calendar.current.compare($0.dueDate, to: date, toGranularity: .day) == .orderedSame }
    }
}
