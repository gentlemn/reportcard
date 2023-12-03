# frozen_string_literal: true

require_relative "reportcard/version"
require_relative "grade_counter"
require "byebug"

# toplevel reportcard module
module Reportcard
  class << self
    def generate_marks_card(file_path)
      @grade_count = GradeCounter.new
      # Read the marks.txt file
      marks_data = File.readlines(file_path, chomp: true)
      # generate marks card hash and calculate the average grand total
      report_hash = create_marks_hash(marks_data)
      report_hash, above_avg, below_avg = update_report_with_performance(report_hash)
      print_score_card(report_hash, above_avg, below_avg)
    end

    def create_marks_hash(marks_data) # rubocop:disable Metrics/AbcSize
      report_hash = {}
      marks_data.each do |marks|
        student_id, *student_marks = split_hash(marks, ",")

        # Create a hash for the student
        student_hash = {}
        student_marks.each do |mark|
          name, score = split_hash(mark, "-")
          student_hash[name.downcase] = score.to_i
        end
        grand_total = student_hash.values.sum
        student_hash[:grand_total] = grand_total
        student_hash[:grade] = update_grade(grand_total)

        report_hash[student_id] = student_hash
      end
      report_hash
    end

    def update_grade(total)
      grade = case total
              when 340..Float::INFINITY then "A"
              when 300...340 then "B"
              else "C"
              end
      @grade_count.add_score(grade, total)
      grade
    end

    def update_report_with_performance(report_hash)
      grade_avg = {
        "A" => @grade_count.average_for_grade("A"),
        "B" => @grade_count.average_for_grade("B"),
        "C" => @grade_count.average_for_grade("C")
      }
      above_avg_count = 0
      below_avg_count = 0

      report_hash.each do |student_id, report|
        grade = report[:grade]
        avg_compare = report[:grand_total] >= grade_avg[grade]
        report_hash[student_id][:avg_compare] = avg_compare

        above_avg_count += avg_compare ? 1 : 0
        below_avg_count += avg_compare ? 0 : 1
      end

      [report_hash, above_avg_count, below_avg_count]
    end

    def print_score_card(hash, above_count, below_count)
      puts "Score card"
      scorecard(hash)
      puts "---------------------------------------------------------"
      overall_performance(above_count, below_count)
    end

    def scorecard(hash)
      puts "ID Subject1 Subject2 Subject3 Subject4 Grand-Total Grade Average-Compare"

      # Print each row
      hash.each do |student_id, data|
        printf("| %<id>s | %<s1>s | %<s2>s | %<s3>s | %<s4>s | %<grand_total>s | %<grade>s | %<avg_compare>s |\n",
               id: student_id,
               s1: data["s1"],
               s2: data["s2"],
               s3: data["s3"],
               s4: data["s4"],
               grand_total: data[:grand_total],
               grade: data[:grade],
               avg_compare: data[:avg_compare] ? "ABOVE" : "BELOW")
      end
    end

    def overall_performance(above_count, below_count)
      # Prints general information
      puts "------------------------------------------------"
      printf("Grade report
      Number of students in A Grade :: %<grade_a>s
      Number of students in B Grade :: %<grade_b>s
      Number of students in C Grade :: %<grade_c>s
      Number of students above their grade average :: %<above>s
      Number of students below their grade average :: %<below>s\n",
             grade_a: get_grade("A"), grade_b: get_grade("B"), grade_c: get_grade("C"),
             above: above_count, below: below_count)
      puts "------------------------------------------------"
    end

    # This function splits hash according to the regex passed
    def split_hash(hash, regex)
      hash.split(regex.to_s)
    end

    def get_grade(grade)
      @grade_count.get_count(grade)
    end
  end

  class Error < StandardError; end
  # Your code goes here...
end
