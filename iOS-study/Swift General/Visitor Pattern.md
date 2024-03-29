# Visitor Pattern
[Original Article](https://sudonull.com/post/7200-Architectural-pattern-Visitor-Visitor-in-the-universe-of-iOS-and-Swift)

The template can be useful when it is necessary to be able to perform any **similar actions** on a **group of unrelated objects of different types**.

*Or, in other words, to extend the functionality of this series of types by some kind of operation, of the same type or having a single source. At the same time, the structure and implementation of extensible types should not be affected.*

## Example 
Suppose cells of different subtypes should have different heights.

```Swift
class FirstCell: UITableViewCell { /**/ }
class SecondCell: UITableViewCell { /**/ }
class ThirdCell: UITableViewCell { /**/ }
class TableVC: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FirstCell.self,    
                           forCellReuseIdentifier: "FirstCell")
        tableView.register(SecondCell.self, 
                           forCellReuseIdentifier: "SecondCell")
        tableView.register(ThirdCell.self, 
                           forCellReuseIdentifier: "ThirdCell")
    }
    override func tableView(_ tableView: UITableView, 
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /**/ return FirstCell()
        /**/ return SecondCell()
        /**/ return ThirdCell()
    }
}
```
the problem is we don't want to send the height calculation logic to the cells themselves neither we desired to put it in the function write `if else` and configure heights based their types.

### Visitor Pattern Solution
1) Define a struct specially for configuring heights.
```Swift
struct HeightResultVisitor {
    func visit(_ сell: FirstCell) -> CGFloat { return 10.0 }
    func visit(_ сell: SecondCell) -> CGFloat { return 20.0 }
    func visit(_ сell: ThirdCell) -> CGFloat { return 30.0 }
}
```

2) Define a protocol that allow the object that conforms to it accept the  `HeightResultVisitor`, then conform cells to this protocol.
```Swift
protocol HeightResultVisitable {
    func accept(_ visitor: HeightResultVisitor) -> CGFloat
}
extension FirstCell: HeightResultVisitable {
    func accept(_ visitor: HeightResultVisitor) -> CGFloat {
        return visitor.visit(self)
    }
}
extension SecondCell: HeightResultVisitable {
    func accept(_ visitor: HeightResultVisitor) -> CGFloat {
        return visitor.visit(self)
    }
}
extension ThirdCell: HeightResultVisitable {
    func accept(_ visitor: HeightResultVisitor) -> CGFloat {
        return visitor.visit(self)
    }
}
```

3) Then:
```Swift
override func tableView(_ tableView: UITableView, 
                        heightForRowAt indexPath: IndexPath) -> CGFloat {
    let cell = tableView.cellForRow(at: indexPath) as! HeightResultVisitable    
    return cell.accept(HeightResultVisitor())
}
```

### More General Visitor
we don't want to define a specific protocol each time we want to add a behaviour  to our cell therefore we define a general protocol for accepting different visitors.
```Swift
protocol CellVisitor {
    associatedtype T
    func visit(_ cell: FirstCell) -> T
    func visit(_ cell: SecondCell) -> T
    func visit(_ cell: ThirdCell) -> T
}
```

Conform already defined `HeightResultCellVisitor` to new `CellVisitor` protocol.
```Swift
struct HeightResultCellVisitor: CellVisitor {
    func visit(_ cell: FirstCell) -> CGFloat { return 10.0 }
    func visit(_ cell: SecondCell) -> CGFloat { return 20.0 }
    func visit(_ cell: ThirdCell) -> CGFloat { return 30.0 }
}
```

```Swift
protocol VisitableСell where Self: UITableViewCell {
    func accept<V: CellVisitor>(_ visitor: V) -> V.T
}
```

```Swift
extension FirstCell: VisitableСell {
    func accept<V: CellVisitor>(_ visitor: V) -> V.T  {
        return visitor.visit(self)
    }
}
extension SecondCell: VisitableСell {
    func accept<V: CellVisitor>(_ visitor: V) -> V.T  {
        return visitor.visit(self)
    }
}
extension ThirdCell: VisitableСell {
    func accept<V: CellVisitor>(_ visitor: V) -> V.T  {
        return visitor.visit(self)
    }
}
```

