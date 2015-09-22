require_relative "module2_assignment"

# This script provides a sample execution of the Solution class
# that is consistent with what the rspec evaluation will perform.
# You may use it to sanity check your actual solution along side
# the rspec tests.
#
#class Solution
#
#  def analyze_file
#    puts 'analyze_file'
#  end
#  def calculate_line_with_highest_frequency
#    puts 'calculate_line_with_highest_frequency'
#  end
#  def print_highest_word_frequency_across_lines
#    puts 'print_highest_word_frequency_across_lines'
#  end
#end

solution = Solution.new
#expect errors until you implement these methods
solution.analyze_file
solution.calculate_line_with_highest_frequency
solution.print_highest_word_frequency_across_lines
