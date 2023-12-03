# Reportcard

Welcome, This is a gem which will create a ReportCard of students.

## Usage
### Approach 1
Clone this Repo and run
```bash

bundle exec ruby -Ilib .\bin\reportcard -f ".\marks.txt"

```

### Approach 2
Download gem file and run following command:
```bash
gem install <path_to_the_gem>
```
In irb

```bash

require 'reportcard'
Reportcard.generate_marks_card("marks.txt")

```

### Approach 3
Download Repo and run following command:
```bash
ruby .\lib\main.rb .\marks.txt
```







