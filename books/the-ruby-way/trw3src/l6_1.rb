class Transition
  A, B = :A, :B
  T, F = true, false
          # state,p1,p2  => newstate, result
  Table = {[A,F,F]=>[A,F], [B,F,F]=>[B,T],
           [A,T,F]=>[B,T], [B,T,F]=>[B,T],
           [A,F,T]=>[A,F], [B,F,T]=>[A,T],
           [A,T,T]=>[A,T], [B,T,T]=>[A,T]}

  def initialize(proc1, proc2)
    @state = A
    @proc1, @proc2 = proc1, proc2
  end

  def check?
    p1 = @proc1.call ? T : F
    p2 = @proc2.call ? T : F
    @state, result = *Table[[@state,p1,p2]]
    return result
  end 
end
