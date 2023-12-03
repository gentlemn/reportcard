require_relative 'reportcard'

file_path = ARGV[0]


if file_path
  Reportcard.generate_marks_card(file_path)
else
  print "Add file path"
end