//
//  SignalProtocol+withTests.swift
//  ReaktiveBoarTests
//
//  Created by Peter Ovchinnikov on 3/12/19.
//  Copyright © 2019 Peter Ovchinnikov. All rights reserved.
//

// swiftlint:disable file_length type_body_length

import XCTest
import ReactiveKit
@testable import ReaktiveBoar

class SignalProtocolWithTests: XCTestCase {

{%- for j in range(1, 10) %}
func testWith{{j}}Argument() {

Signal<Int, TestError>.failed(.error)
.with({% for i in range(j)%}.strong({{ i+2 }}){% if not loop.last %}, {% endif %}
{% endfor %})
.expect([.failed(.error)])

Signal<Int, TestError>(just: 1)
.with({% for i in range(j)%}.weak(SimpleClass()){% if not loop.last %}, {% endif %}
{% endfor %})
.expectNext([])

Signal<Int, TestError>(just: 1)
.with({% for i in range(j)%}.strong({{ i+2 }}){% if not loop.last %}, {% endif %}
{% endfor %})
.expectNext([ (1, {% for i in range(j)%}{{ i+2 }}{% if not loop.last %}, {% endif %}{% endfor %}) ])
}
{%- endfor %}

{%- for j in range(1, 10) %}
func testVoidWith{{j}}Argument() {

Signal<Void, TestError>.failed(.error)
.with({% for i in range(j)%}.strong({{ i+2 }}){% if not loop.last %}, {% endif %}
{% endfor %})
.expect([.failed(.error)])

Signal<Void, TestError>(just: () )
.with({% for i in range(j)%}.weak(SimpleClass()){% if not loop.last %}, {% endif %}
{% endfor %})
.expectNext([])

Signal<Void, TestError>(just: () )
.with({% for i in range(j)%}.strong({{ i+2 }}){% if not loop.last %}, {% endif %}
{% endfor %})
.expectNext([ ({% for i in range(j)%}{{ i+2 }}{% if not loop.last %}, {% endif %}{% endfor %}) ])
}
{%- endfor %}


}
