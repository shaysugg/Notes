import Foundation

private enum Days: Int, Comparable {
  static func < (lhs: Days, rhs: Days) -> Bool {
    lhs.rawValue < rhs.rawValue
  }

  case mon
  case tue
  case wed
  case thu
  case fri
  case sat
  case sun
  case _end
}

private struct WeekDays: RandomAccessCollection {
  typealias Index = Int

  let startIndex: Int = 1
  let endIndex: Int = 8

  func index(after i: Int) -> Int { i + 1 }

  subscript(position: Int) -> Days {
    Days(rawValue: position - 1)!
  }
}

private enum DayStatus {
  case fine
  case shitty
}

private class WeekDaysStatus: MutableCollection {

  private var days: [Days: DayStatus] = [
    .mon: .shitty,
    .tue: .shitty,
    .wed: .shitty,
    .thu: .shitty,
    .fri: .shitty,
    .sat: .shitty,
    .sun: .shitty,
  ]

  subscript(position: Days) -> DayStatus {
    get {
      return days[position] ?? .shitty
    }
    set(newValue) {
      days[position] = newValue
    }
  }

  typealias Index = Days

  let startIndex = Days.mon
  let endIndex = Days._end

  func index(after i: Index) -> Days {
    Days(rawValue: i.rawValue + 1)!
  }
}

func mutableCollection() {
  let daysStatus = WeekDaysStatus()
  daysStatus[.mon] = .fine

  for status in daysStatus {
    print(status)
  }
}

func randomAcessCollection() {
  let days = WeekDays()

  for day in days {
    print(day)
  }
}
