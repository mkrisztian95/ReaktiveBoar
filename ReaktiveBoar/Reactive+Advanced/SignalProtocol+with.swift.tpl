//! Autogenerated file
// swiftlint:disable large_tuple function_parameter_count file_length

//line_length

import ReactiveKit

public extension SignalProtocol where Element == Void {
{% for j in range(1, 10) %}

func with<{% for i in range(j) %}U{{i}}{% if not loop.last %}, {% endif %}{% endfor %}>({%- for i in range(j) %}
_ value{{i}}: Value<U{{i}}>{% if not loop.last %}, {% endif %} {%- endfor -%}
) -> Signal<({% for i in range(j) %}U{{i}}{% if not loop.last %}, {% endif %}{% endfor %}), Error> {
return Signal { observer in
return self.observe { event in
switch event {
case .next:
if
{%- for i in range(j) %}
let val{{i}} = value{{i}}.value{% if not loop.last %}, {% endif %} {%- endfor -%} {
observer.next( ({% for i in range(j) %}val{{i}}{% if not loop.last %}, {% endif %}{% endfor %}) )
}
case .failed(let error):
observer.failed(error)
case .completed:
observer.completed()
}
}
}
} {% endfor %}
}

public extension SignalProtocol {
{% for j in range(1, 10) %}

func with<{% for i in range(j) %}U{{i}}{% if not loop.last %}, {% endif %}{% endfor %}>({%- for i in range(j) %}
_ value{{i}}: Value<U{{i}}>{% if not loop.last %}, {% endif %} {%- endfor -%}
) -> Signal<(Element, {% for i in range(j) %}U{{i}}{% if not loop.last %}, {% endif %}{% endfor %}), Error> {
return Signal { observer in
return self.observe { event in
switch event {
case .next(let element):
if
{%- for i in range(j) %}
let val{{i}} = value{{i}}.value{% if not loop.last %}, {% endif %} {%- endfor -%} {
observer.next( (element, {% for i in range(j) %}val{{i}}{% if not loop.last %}, {% endif %}{% endfor %}) )
}
case .failed(let error):
observer.failed(error)
case .completed:
observer.completed()
}
}
}
} {% endfor %}
}
