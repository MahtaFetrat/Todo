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
            CLI.viewSpecialTodo()
        case "4":
            exit(0)
        default:
            print("Invalid input! Please choose one of the numbers above")
            CLI.menu()
        }
    }

    static func inputDate() -> Date {
        print("Please enter date in format yyyy-MM-dd HH:mm:ss")
         if let date = PersianDateFormatter.parseDate(from: readLine() ?? "") {
             return date
         }
         print("Invalid date!")
         return CLI.inputDate()
    }

    static func addTodo() {
        print("Please enter a title for this Todo:")
        let name = readLine() ?? "Untitled"
        let date = CLI.inputDate()
        
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
        print(todoList)   
    }

    static func viewSpecialTodo() {
        print("3 is ure choice")
    }
}
