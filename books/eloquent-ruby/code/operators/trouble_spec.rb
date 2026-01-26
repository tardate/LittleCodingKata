#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

# Fun, but slightly crazy example of what you can do with operators.

class Unit
  attr_reader :name, :members

  def initialize(name, members=[])
    @name = name
    @members = members.clone
  end

  def <<(others)
    @members << others
  end

  def -(member)
    result = self.class.new("New: #{@name}", @members)
    result.members.delete(member)
    result
  end
end

class Department < Unit
  def +(other)
    if other.kind_of?(Department)
      return Division.new("New Dept: #{@name}", [self, other])
    end

    # Assume other is an Employee
    result = Department.new("New Dept: #{@name}", @members)
    result << other
    result
  end
end

class Division < Unit
  def +(other)
    result = Division.new("New Dept: #{@name}", @members)

    if other.kind_of?(Department)
      result << other.members
    else
      # Assume other is an Employee
      result << other
    end
    result
  end
end

class Employee
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def +(other)
    if other.kind_of?(Employee)
      Department.new("New department", [self, other])
    else
      # Assume other is a dept.
      other + self
    end
  end
end
 
class NumberWithSideEffects
  attr_reader :n

  def initialize(n)
    @n = n
  end

  def +(other)
    result = @n + other if other.kind_of?(Numeric)
    result = @n + other.n
    
    # Here"s the crazy bit!
    @n -= 1
    result
  end
end

   
describe Employee do
  let(:employee_1) { Employee.new("Sally") }
  let(:employee_2) { Employee.new("Guy") }

  it "lets you add employees to get a department" do
    department = employee_1 + employee_2
    expect(department).to be_a(Department)
    expect(department.members.size).to eq(2)
    expect(department.members).to include(employee_1)
    expect(department.members).to include(employee_2)
  end
end


describe Department do
  let(:e1) { Employee.new("Jackson") }
  let(:e2) { Employee.new("Emi") }
  let(:e3) { Employee.new("Felicia") }
  let(:e4) { Employee.new("Tom") }

  let(:department_1) { Department.new("Shipping", [e1, e3]) }
  let(:department_2) { Department.new("Accounting", [e2, e4]) }

  it "lets you add departments together to get divisions" do
    division = department_1 + department_2
    expect(division).to be_a(Division)
    expect(division.members.size).to eq(2)
    expect(division.members).to include(department_1)
    expect(division.members).to include(department_2)
  end 

  it "lets you remove employees" do
    smaller_dept = department_1 - e1
    expect(smaller_dept).to be_a(Department)
    expect(smaller_dept.members.size).to eq(1)
    expect(smaller_dept.members).to include(e3)
  end
end
 
describe "addition" do
  it "can be sensible" do
    a = 10
    b = 20
    a + b
    expect(a).to eq(10)
    expect(b).to eq(20)
  end

  it "can be insane" do
    a = NumberWithSideEffects.new(10)
    b = NumberWithSideEffects.new(20)
    c = a + b
    
    expect(c).to eq(30)
    expect(b.n).to eq(20)

    # No we don"t really expect this, but there it is.
    expect(a.n).to eq(9)
  end
end
