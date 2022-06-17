import Foundation


class CLI {
    static func run() {
        print("Welcome to Todo app!")
        while true {
            CLI.menu()
        }
    }
    
    static func menu() {
        print("""
        What do you want to do?
        1. Add a new Todo
        2. View Todo list
        3. View Todo for a special date
        4. exit
        """)
        let choice = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        switch choice {
        case "1":
            CLI.addTodo()
        case "2":
            viewTodoList()
        case "3":
            CLI.viewTodosByDueDate()
        case "4":
            exit(0)
        default:
            print("Invalid input! Please choose one of the numbers above")
            CLI.menu()
        }
    }

    static func inputDateTime() -> Date {
        print("Please enter date in format yyyy-MM-dd HH:mm:ss")
         if let date = DateFormatUtils.parseDate(from: readLine() ?? "") {
             return date
         }
         print("Invalid date!")
         return CLI.inputDateTime()
    }

    static func inputDate() -> Date {
        print("Please enter date in format yyyy-MM-dd")
         if let date = DateFormatUtils.parseDate(from: "\(readLine() ?? "") 00:00:01") {
             return date
         }
         print("Invalid date!")
         return CLI.inputDate()
    }

    static func addTodo() {
        print("Please enter a title for this Todo:")
        let name = readLine() ?? "Untitled"
        let date = CLI.inputDateTime()
        
        var todo = Todo(name: name, dueDate: date)
        Todo.addTodo(todo: todo)
    }

    private static func getSortType () -> SortType {
        print("""
        Sort Todos by ...
        1. Name
        2. Date Created
        3. Due Date
        """)
        let choice = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        switch choice {
        case "1":
            return SortType.sortByName
        case "2":
            return SortType.sortByDateCreated
        case "3":
            return SortType.sortByDueDate
        default:
            print("Invalid input! Please choose one of the numbers above")
            return CLI.getSortType()
        }
    } 

    private static func getSortOrder() -> SortOrder {
        print("""
        Sort order ...
        1. Ascending
        2. Descending
        """)
        let choice = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        switch choice {
        case "1":
            return SortOrder.ascending
        case "2":
            return SortOrder.descending
        default:
            print("Invalid input! Please choose one of the numbers above")
            return CLI.getSortOrder()
        }
    }

    static func viewTodoList() {
        let sortType: SortType = CLI.getSortType()
        let sortOrder: SortOrder = CLI.getSortOrder()

        let todoList: [Todo] = Todo.sortedTodoList(sortType: sortType, sortOrder: sortOrder)

        print(Todo.listViewHeader)
        for todo in todoList {
            print(todo) 
        }

        if !todoList.isEmpty {
            deleteTodoMenu()   
        }   
    }

    static func deleteTodoMenu() {
        print("""
        Do you want to delete any?
        1. Delete
        2. Back
        """)
        let choice = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        switch choice {
            case "1":
                inputTodoIdToDelete()
            default:
                print("Invalid input! Please choose one of the numbers above")
                return CLI.deleteTodoMenu()
        }
    }

    static func inputTodoIdToDelete() {
        print("Please enter the Todo id to delete")
        let id = Int((readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)) ?? -1
        if !Todo.deleteTodo(id: id) {
            print("Invalid id! Please enter a id from the list above")
            CLI.inputTodoIdToDelete()
        }
    }

    static func viewTodosByDueDate() {
        let date = CLI.inputDate()
        let todoList: [Todo] = Todo.getTodosByDueDate(date: date)
        print(Todo.listViewHeader)
        for todo in todoList {
            print(todo) 
        }

        if !todoList.isEmpty {
            deleteTodoMenu()   
        }   
    }
}
