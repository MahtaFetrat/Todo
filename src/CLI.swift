import Foundation


class CLI {
    private static var sortType: SortType = .sortByName
    private static var sortOrder: SortOrder = .ascending

    static func run() {
        print("Welcome to Todo app!")
        menu()
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
                addTodo()
            case "2":
                viewTodoList()
            case "3":
                viewTodoListByDueDate()
            case "4":
                exit(0)
            default:
                print("\nInvalid input! Please choose one of the numbers above")
                menu()
        }
    }

    static func addTodo() {
        print("\nPlease enter a title for this Todo:")
        let name = readLine() ?? "Untitled"
        let date = inputDateTime()
        
        var todo = Todo(name: name, dueDate: date)
        Todo.addTodo(todo: todo)

        print("\nTodo successfully added!\n")
        menu()
    }

    static func viewTodoList() {
       getSortType()
    }

    static func viewTodoListByDueDate() {
        let date = inputDate()
        let todoList: [Todo] = Todo.getTodosByDueDate(date: date)
        print(Todo.listViewHeader)
        for todo in todoList {
            print(todo) 
        }

        if !todoList.isEmpty {
            deleteTodoMenu(back: menu)   
        } else {
            menu()
        }
    }

    private static func getSortType () {
        print("""
        Sort Todos by ...
        1. Name
        2. Date Created
        3. Due Date
        4. Back
        """)
        let choice = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        switch choice {
        case "1":
            sortType = SortType.sortByName
        case "2":
            sortType = SortType.sortByDateCreated
        case "3":
            sortType = SortType.sortByDueDate
        case "4":
            menu()
        default:
            print("Invalid input! Please choose one of the numbers above")
            getSortType()
        }

        getSortOrder()
    } 

    private static func getSortOrder() {
        print("""
        Sort order ...
        1. Ascending
        2. Descending
        3. Back
        """)
        let choice = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        switch choice {
        case "1":
            sortOrder = SortOrder.ascending
        case "2":
            sortOrder = SortOrder.descending
        case "3":
            viewTodoList()
        default:
            print("Invalid input! Please choose one of the numbers above")
            getSortOrder()
        }

        printSortedTodoList()
    }

    static func printSortedTodoList() {
        let todoList: [Todo] = Todo.sortedTodoList(sortType: sortType, sortOrder: sortOrder)

        print(Todo.listViewHeader)
        for todo in todoList {
            print(todo) 
        }

        if !todoList.isEmpty {
            deleteTodoMenu(back: getSortOrder)   
        } else {
            menu()
        }
    }

    static func deleteTodoMenu(back: () -> ()) {
        print("""
        \nDo you want to delete any?
        1. Delete
        2. Back
        """)
        let choice = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        switch choice {
            case "1":
                inputTodoIdToDelete()
            case "2":
                back()
            default:
                print("Invalid input! Please choose one of the numbers above")
                return deleteTodoMenu(back: back)
        }
    }

    static func inputTodoIdToDelete() {
        print("Please enter the Todo id to delete")
        let id = Int((readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)) ?? -1
        if !Todo.deleteTodo(id: id) {
            print("Invalid id! Please enter a id from the list above")
            inputTodoIdToDelete()
        } else {
            print("\nTodo deleted successfully!\n")
            menu()
        }
    }

    static func inputDateTime() -> Date {
        print("Please enter date in format yyyy-MM-dd HH:mm:ss")
         if let date = DateFormatUtils.parseDate(from: readLine() ?? "") {
             return date
         }
         print("Invalid date!")
         return inputDateTime()
    }

    static func inputDate() -> Date {
        print("Please enter date in format yyyy-MM-dd")
         if let date = DateFormatUtils.parseDate(from: "\(readLine() ?? "") 00:00:01") {
             return date
         }
         print("Invalid date!")
         return inputDate()
    }
}
