require 'pathname'

class Parser

  attr_accessor :problem

  def initialize(problem)
    self.problem = problem
  end

  def explanation
    return help if problem == 'help'
    problem.gsub(/REASON/) {|m| generate_reason }
  end

  def generate_reason
    reason = random_excuse
    reason.gsub(/COMPONENT/) {|m| random_component }
  end

  def random_component
    components.sample
  end

  def random_excuse
    excuses.sample
  end

  def help
    %{
Here's some help:

Describe your problem in a sentence, using the text "REASON" where-ever you'd like a good excuse inserted

e.g. "Glitching was not a viable attack because of REASON"
    }
  end

  def excuses
    @excuses ||= File.readlines(data_path.join('excuses.txt')).map(&:chomp)
  end

  def components
    @components ||= File.readlines(data_path.join('components.txt')).map(&:chomp)
  end

  def data_path
    # here = File.expand_path(File.dirname(__FILE__))
    here = Pathname.new(File.dirname(__FILE__))
    here.join('..', '..', 'data')
  end

end
