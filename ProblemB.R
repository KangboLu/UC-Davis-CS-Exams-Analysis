library(stringr)
urls <- c("http://heather.cs.ucdavis.edu/~matloff/50/OldExams/",
          "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/",
          "http://heather.cs.ucdavis.edu/~matloff/145/Exams/",
          "http://heather.cs.ucdavis.edu/~matloff/152A/Exams/",
          "http://heather.cs.ucdavis.edu/~matloff/154A/OldExams/",
          "http://heather.cs.ucdavis.edu/~matloff/154B/Exams/",
          "http://heather.cs.ucdavis.edu/~matloff/156/Exams/",
          "http://heather.cs.ucdavis.edu/~matloff/158/OldExams/",
          "http://heather.cs.ucdavis.edu/~matloff/256/Exams/")
file_list <- vector()
for (url in urls) {
  html <- paste(readLines(url), collapse="\n")
  return_extension <- unlist(str_extract_all(html, "[WSF](.)*.tex(?=\")"))
  directory <- rep(url, length(return_extension))
  complete_url <- paste0(directory, return_extension)
  file_list <- append(file_list, complete_url)
}
file_list
