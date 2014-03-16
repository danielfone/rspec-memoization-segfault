# This should always raise "SystemStackError: stack level too deep".

def foo
  foo
end

puts foo
