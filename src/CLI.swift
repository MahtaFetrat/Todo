import Foundation


enum MainMenuError : Error {
    case goToMainMenu
}

class CLI {
    private static var sortType: SortType = .sortByName
    private static var sortOrder: SortOrder = .ascending

    static func run() {
        print("Welcome to Todo app!")
        menu()
    }

    static func menu() {
        while true {
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
                    do {
                        try addTodo()
                    } catch {
                        continue
                    }
                case "2":
                    do {
                        try viewTodoList()
                    } catch {
                        continue
                    }
                case "3":
                    do {
                        try viewTodoListByDueDate()
                    } catch {
                        continue
                    }
                case "4":
                    exit(0)
                default:
                    print("\nInvalid input! Please choose one of the numbers")
            }
        }
    }

    static func addTodo() throws {
        while true {
            print("\nPlease enter a title for this Todo or 0 to go back:")
            let name = readLine() ?? "Untitled"
            if name == "0" {
                return
            }
            do {
                try inputDateTime(name : name)
            } catch {
                throw MainMenuError.goToMainMenu
            }
        }
    }

    static func inputDateTime(name : String) throws {
        while true {
            print("Please enter date in format yyyy-MM-dd HH:mm:ss or 0 to go back")
            let dateString = readLine() ?? ""
            if dateString == "0" {
                return
            }
            if let date = DateFormatUtils.parseDate(from: dateString) {
                let todo = Todo(name: name, dueDate: date)
                Todo.addTodo(todo: todo)

                print("\nTodo successfully added!\n")
                throw MainMenuError.goToMainMenu
            } else {
                print("\nInvalid date!")
            }
        }
    }

    static func viewTodoList() throws {
        while true {
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
                do {
                    try getSortOrder()
                } catch {
                    throw MainMenuError.goToMainMenu
                }
            case "2":
                sortType = SortType.sortByDateCreated
                do {
                    try getSortOrder()
                } catch {
                    throw MainMenuError.goToMainMenu
                }
            case "3":
                sortType = SortType.sortByDueDate
                do {
                    try getSortOrder()
                } catch {
                    throw MainMenuError.goToMainMenu
                }
            case "4":
                return
            default:
                print("\nInvalid input! Please choose one of the numbers")
            }
        }
    }

    private static func getSortOrder() throws {
        while true {
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
                do {
                    try printSortedTodoList(todoList : Todo.sortedTodoList(sortType: sortType, sortOrder: sortOrder))
                } catch {
                    throw MainMenuError.goToMainMenu
                }
            case "2":
                sortOrder = SortOrder.descending
                do {
                    try printSortedTodoList(todoList : Todo.sortedTodoList(sortType: sortType, sortOrder: sortOrder))
                } catch {
                    throw MainMenuError.goToMainMenu
                }
            case "3":
                return
            default:
                print("\nInvalid input! Please choose one of the numbers")
            }
        }
    }

    static func printSortedTodoList(todoList : [Todo]) throws {
        var todoList1 = todoList
        while true {
            //let todoList: [Todo] = Todo.sortedTodoList(sortType: sortType, sortOrder: sortOrder)

            if todoList1.isEmpty {
                print("No ToDo to show!\n")
                throw MainMenuError.goToMainMenu
            }

            print(Todo.listViewHeader)
            for todo in todoList1 {
                print(todo) 
            }

            print("""
            \nDo you want to delete any?
            1. Delete
            2. Go to main menu
            3. Back
            """)
            let choice = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            switch choice {
                case "1":
                    let id = inputTodoIdToDelete(todoList : todoList1)
                    for (index, todo) in todoList1.enumerated() {
                        if todo.id == id {
                            todoList1.remove(at : index)
                            break
                        }
                    }
                case "2":
                    throw MainMenuError.goToMainMenu
                case "3":
                    return
                default:
                    print("\nInvalid input! Please choose one of the numbers")
            }
        }
    }

    static func inputTodoIdToDelete(todoList : [Todo]) -> Int {
         while true {
            print("\nPlease enter the Todo id to delete or 0 to go back")
            let idString = readLine() ?? ""
            if idString == "0" {
                return 0
            }
            let id = Int(idString.trimmingCharacters(in: .whitespacesAndNewlines)) ?? -1
            var hasDeleted = false

            
            for todo in todoList {
                if todo.id == id {
                    Todo.deleteTodo(todo : todo)
                    hasDeleted = true
                    break;
                }
            }

            if hasDeleted {
                print("\nTodo deleted successfully!\n")
                return id
            } else {
                print("\nInvalid id! Please enter a id from the list")
            }
        }
    }

    static func viewTodoListByDueDate() throws {
        while true {
            print("Please enter date in format yyyy-MM-dd or 0 to go back")
            let dateString = readLine() ?? ""
            if dateString == "0" {
                return
            }
            if let date = DateFormatUtils.parseDate(from: "\(dateString) 00:00:01") {
                let todoList: [Todo] = Todo.getTodosByDueDate(date: date)
                do {
                    try printSortedTodoList(todoList : todoList)
                } catch {
                    throw MainMenuError.goToMainMenu
                }
            } else {
                print("\nInvalid date!")
            }
        }
    }   

}
