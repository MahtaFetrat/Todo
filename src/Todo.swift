import Foundation


class Todo {
    private static var lastId = 1
    private static var allTodos: [Todo] = []

    private var id: Int
    private var name: String
    private var date: Date
    private let dateCreated: Date

    init(name: String, date: Date) {
        Todo.lastId += 1
        self.id = Todo.lastId
        self.name = name
        self.date = date
        self.dateCreated = PersianDateFormatter.currentDate()
    }

    static func addTodo(todo: Todo) {
        Todo.allTodos.append(todo)
    }
}
