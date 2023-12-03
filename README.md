Latest RELEASE link: https://github.com/gentlemn/reportcard/releases/tag/v0.1.0

# Reportcard

Welcome, This repo contains a gem that will create a ReportCard of students.

## Usage
### Approach 1
Clone this Repo and run
```bash

bundle exec ruby -Ilib .\bin\reportcard -f ".\marks.txt"

```

### Approach 2
Download gem file from the above release link and run following command:
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
![cap3](https://github.com/gentlemn/reportcard/blob/6c35e6c3c846683948c483ca5b434d1bef57f994/Capture2.PNG)
![cap3](https://github.com/gentlemn/reportcard/blob/cfdef2aa62547b22b828117b611a84c767cd0379/Capture3.PNG)
![cap2](https://github.com/gentlemn/reportcard/blob/6c35e6c3c846683948c483ca5b434d1bef57f994/Capture.PNG)
![cap1](https://github.com/gentlemn/reportcard/blob/6c35e6c3c846683948c483ca5b434d1bef57f994/capture1.PNG)





