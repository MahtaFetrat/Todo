import Foundation


class CLI {
    static func menu() {
        print("""
        Welcome to Todo app! What do you want to do?
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
        
        var todo = Todo(name: name, date: date)
        Todo.addTodo(todo: todo)
    }

    static func viewTodoList() {
        print("2 is ure choice")
    }

    static func viewSpecialTodo() {
        print("3 is ure choice")
    }
}
