//
//  IsEqual.swift.tpl.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/12/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

// swiftlint:disable cyclomatic_complexity function_body_length

import ReactiveKit

extension Event where Element: Equatable {

func isEqualTo(_ event: Event<Element, Error>) -> Bool {

switch (self, event) {
case (.completed, .completed):
return true
case (.failed, .failed):
return true
case (.next(let left), .next(let right)):
return left == right
default:
return false
}
}
}


extension Event {

func isEqualTo(_ event: Event<Element, Error>) -> Bool {

switch (self, event) {
case (.completed, .completed):
return true
case (.failed, .failed):
return true
case (.next(let left), .next(let right)):
if let left = left as? Int, let right = right as? Int {
return left == right
} else if let left = left as? [Int], let right = right as? [Int] {
return left == right
} else if let left = left as? (Int?, Int), let right = right as? (Int?, Int) {
return left.0 == right.0 && left.1 == right.1
{%- for j in range(3, 11) %}
} else if let left = left as? ({% for i in range(j) %}Int{% if not loop.last %}, {% endif %}{% endfor %}),
let right = right as? ({% for i in range(j) %}Int{% if not loop.last %}, {% endif %}{% endfor %}) {
return {% for i in range(j) %}left.{{i}}==right.{{i}}{% if not loop.last %} && {% endif %}
{% endfor -%}
{%- endfor -%}
} else if let left = left as? String, let right = right as? String {
return left == right
} else if let left = left as? [String], let right = right as? [String] {
return left == right
} else {
fatalError("Cannot compare that element type. \(left)")
}
default:
return false
}
}
}
