# frozen_string_literal: true

# gradecounter class
class GradeCounter
  attr_accessor :grade_counts

  def initialize
    @grade_counts = Hash.new { |hash, key| hash[key] = { count: 0, sum: 0 } }
  end

  def add_score(grade, score)
    @grade_counts[grade][:count] += 1
    @grade_counts[grade][:sum] += score
  end

  def average_for_grade(grade)
    return 0 if @grade_counts[grade][:count].zero?

    @grade_counts[grade][:sum].to_f / @grade_counts[grade][:count]
  end

  def get_count(grade)
    @grade_counts[grade][:count]
  end
end
