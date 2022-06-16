import Foundation


class CLI {
    static let dateFormatter = CLI.getDateFormatter()

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

    private static func getDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.calendar = Calendar(identifier: .persian)

        return dateFormatter
    }

    static func inputDate() -> Date {
        print("Please enter date in format yyyy-MM-dd HH:mm:ss")
         if let date = CLI.dateFormatter.date(from: readLine() ?? "") {
             return date
         }
         print("Invalid date!")
         return CLI.inputDate()
    }

    static func addTodo() {
        print("Please enter a title for this Todo:")
        let title = readLine()
        let date = CLI.inputDate()
        print(CLI.dateFormatter.string(from: date))
    }

    static func viewTodoList() {
        print("2 is ure choice")
    }

    static func viewSpecialTodo() {
        print("3 is ure choice")
    }
}