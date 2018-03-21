library(stringr)
library(tm)
# urls for scrapping file paths
urls <- c("http://heather.cs.ucdavis.edu/~matloff/50/OldExams/",
          "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/",
          "http://heather.cs.ucdavis.edu/~matloff/145/Exams/",
          "http://heather.cs.ucdavis.edu/~matloff/152A/Exams/",
          "http://heather.cs.ucdavis.edu/~matloff/154A/OldExams/",
          "http://heather.cs.ucdavis.edu/~matloff/154B/Exams/",
          "http://heather.cs.ucdavis.edu/~matloff/156/Exams/",
          "http://heather.cs.ucdavis.edu/~matloff/158/OldExams/",
          "http://heather.cs.ucdavis.edu/~matloff/256/Exams/")
names(urls) <- c("ECS50", "ECS132", "ECS145", "ECS152A", "ECS154A", "ECS154B", "ECS156", "ECS158", "ECS256")

# create vector to store each course's exam file path
ECS50_exams <- vector()
ECS132_exams <- vector()
ECS145_exams <- vector()
ECS152A_exams <- vector()
ECS154A_exams <- vector()
ECS154B_exams <- vector()
ECS156_exams <- vector()
ECS158_exams <- vector()
ECS256_exams <- vector()

# match all the .tex file names and return compeleted file path
complete_file_path <- function(url, exam_list) {
  html <- paste(readLines(url), collapse="\n")
  return_extension <- unlist(str_extract_all(html, "(?<=(href=\"))(.)*.tex(?=\")"))
  directory <- rep(url, length(return_extension))
  paste0(directory, return_extension)
}

# complete exam path for each course
ECS50_exams <- append(complete_file_path(urls["ECS50"], ECS50_exams), ECS50_exams)
ECS132_exams <- append(complete_file_path(urls["ECS132"], ECS132_exams), ECS132_exams)
ECS145_exams  <- append(complete_file_path(urls["ECS145"], ECS145_exams), ECS145_exams)
ECS152A_exams <- append(complete_file_path(urls["ECS152A"], ECS152A_exams), ECS152A_exams)
ECS154A_exams <- append(complete_file_path(urls["ECS154A"], ECS154A_exams), ECS154A_exams)
ECS154B_exams <- append(complete_file_path(urls["ECS154B"], ECS154B_exams), ECS154B_exams)
ECS156_exams <- append(complete_file_path(urls["ECS156"], ECS156_exams), ECS156_exams)
ECS158_exams <- append(complete_file_path(urls["ECS158"], ECS158_exams), ECS158_exams)
ECS256_exams <- append(complete_file_path(urls["ECS256"], ECS256_exams), ECS256_exams)

# test data
test_data <- c("http://heather.cs.ucdavis.edu/~matloff/50/OldExams/F05I.tex",
  "http://heather.cs.ucdavis.edu/~matloff/50/OldExams/F12Quiz2Wed.tex",
  "http://heather.cs.ucdavis.edu/~matloff/50/OldExams/F12Quiz4Wed.tex",
  "http://heather.cs.ucdavis.edu/~matloff/50/OldExams/S01III.tex",
  "http://heather.cs.ucdavis.edu/~matloff/50/OldExams/S03I.tex",
  "http://heather.cs.ucdavis.edu/~matloff/50/OldExams/S10Quiz3.tex",
  "http://heather.cs.ucdavis.edu/~matloff/50/OldExams/S10Quiz6.tex",
  "http://heather.cs.ucdavis.edu/~matloff/50/OldExams/S11Midterm.tex",
  "http://heather.cs.ucdavis.edu/~matloff/50/OldExams/S11Quiz7.tex",
  "http://heather.cs.ucdavis.edu/~matloff/50/OldExams/W02III.tex",
  "http://heather.cs.ucdavis.edu/~matloff/50/OldExams/W04II002.tex",
  "http://heather.cs.ucdavis.edu/~matloff/50/OldExams/W05II002.tex",
  "http://heather.cs.ucdavis.edu/~matloff/50/OldExams/W07I.tex",
  "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/F10Quiz8.tex",
  "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/F11Quiz4.tex",
  "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/F12Quiz1.tex",
  "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/F12Quiz6.tex",
  "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/F13Quiz7.tex",
  "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/S10Quiz3.tex",
  "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/W12Quiz2.tex",
  "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/W12Quiz4.tex",
  "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/W12Quiz8.tex",
  "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/W15Quiz5.tex",
  "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/W15Quiz6.tex",
  "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/W16Quiz4.tex",
  "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/W16Quiz8.tex",
  "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/W17Quiz4.tex",
  "http://heather.cs.ucdavis.edu/~matloff/132/OldExams/W17Quiz7.tex",
  "http://heather.cs.ucdavis.edu/~matloff/145/Exams/F11Quiz2.tex",
  "http://heather.cs.ucdavis.edu/~matloff/145/Exams/F11Quiz4a.tex",
  "http://heather.cs.ucdavis.edu/~matloff/145/Exams/F14Quiz3.tex",
  "http://heather.cs.ucdavis.edu/~matloff/145/Exams/S03II.tex",
  "http://heather.cs.ucdavis.edu/~matloff/145/Exams/S07III.tex",
  "http://heather.cs.ucdavis.edu/~matloff/145/Exams/W17Quiz2.tex",
  "http://heather.cs.ucdavis.edu/~matloff/145/Exams/W17Quiz6.tex",
  "http://heather.cs.ucdavis.edu/~matloff/152A/Exams/F01III.tex",
  "http://heather.cs.ucdavis.edu/~matloff/152A/Exams/S99I.tex",
  "http://heather.cs.ucdavis.edu/~matloff/154A/OldExams/F98I.tex",
  "http://heather.cs.ucdavis.edu/~matloff/154A/OldExams/F99III.tex",
  "http://heather.cs.ucdavis.edu/~matloff/154A/OldExams/W95II.tex",
  "http://heather.cs.ucdavis.edu/~matloff/154B/Exams/W99III.tex",
  "http://heather.cs.ucdavis.edu/~matloff/156/Exams/W08I.tex",
  "http://heather.cs.ucdavis.edu/~matloff/158/OldExams/S02II.tex",
  "http://heather.cs.ucdavis.edu/~matloff/158/OldExams/S08II.tex",
  "http://heather.cs.ucdavis.edu/~matloff/158/OldExams/S10Quiz4.tex",
  "http://heather.cs.ucdavis.edu/~matloff/158/OldExams/S11Quiz1.tex",
  "http://heather.cs.ucdavis.edu/~matloff/158/OldExams/S16Quiz5.tex",
  "http://heather.cs.ucdavis.edu/~matloff/158/OldExams/W12Quiz2.tex",
  "http://heather.cs.ucdavis.edu/~matloff/158/OldExams/W15Quiz3.tex",
  "http://heather.cs.ucdavis.edu/~matloff/256/Exams/F10Quiz2.tex")

# training data
ECS50_exams <- ECS50_exams[!(ECS50_exams %in% test_data)]
ECS132_exams <- ECS132_exams[!(ECS132_exams %in% test_data)]
ECS145_exams <- ECS145_exams[!(ECS145_exams %in% test_data)]
ECS152A_exams <- ECS152A_exams[!(ECS152A_exams %in% test_data)]
ECS154A_exams <- ECS154A_exams[!(ECS154A_exams %in% test_data)]
ECS154B_exams <- ECS154B_exams[!(ECS154B_exams %in% test_data)]
ECS156_exams <- ECS156_exams[!(ECS156_exams %in% test_data)]
ECS158_exams <- ECS158_exams[!(ECS158_exams %in% test_data)]
ECS256_exams <- ECS256_exams[!(ECS256_exams %in% test_data)]

# read files and store in each course's exam vector
remove_latex_term <- function(file) gsub("([{]?)[\\](.)*[}]", " ", readLines(file))
collapse_exam <- function(exam) lapply(exam, remove_latex_term)
ECS50_exams <- collapse_exam(ECS50_exams)
ECS132_exams <- collapse_exam(ECS132_exams)
ECS145_exams <- collapse_exam(ECS145_exams)
ECS152A_exams <- collapse_exam(ECS152A_exams)
ECS154A_exams <- collapse_exam(ECS154A_exams)
ECS154B_exams <- collapse_exam(ECS154B_exams)
ECS156_exams <- collapse_exam(ECS156_exams)
ECS158_exams <- collapse_exam(ECS158_exams)
ECS256_exams <- collapse_exam(ECS256_exams)
exams <- c(ECS50_exams, ECS132_exams, ECS145_exams, ECS152A_exams, ECS154A_exams,
           ECS154B_exams, ECS156_exams, ECS158_exams ,ECS256_exams)

# remove stopwords for better analysis
stop_words <- c("The", "the", "blank", "will", "item", 
                "cdot", "find", "Find", "copy", "make", 
                "suppose", "code", "suppose", "Suppose",
                "example", "blanks", "makeatletter", "makeatother",
                "use", "hline", "one", "two", "textbfdirections",
                "httpwwwlyxorg", "answer", "answers", "consider",
                "number", "name", "instruction", "line", "random",
                "print", "get", "right", "function",
                stopwords("en"))
clean_corpus <- function(file) {
  corpus <- Corpus(VectorSource(file))
  corpus <- tm_map(corpus, tolower)
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, removeWords, stop_words)
  return(corpus)
}

# function to create dtf matrix for analysis
create_dtf_matrix <- function(exam) {
  # clean corpus and create dtf
  corpus <- clean_corpus(exam)
  dtf <- DocumentTermMatrix(corpus)
  freq <- colSums(as.matrix(dtf))
  ord <- order(freq,decreasing=TRUE)
  freq <- freq[ord]
  dtf <- as.matrix(dtf)[,names(head(freq, n = 2))]
}

# clean and create document term matrix for dtf
corpus <- clean_corpus(exams)
dtf <- as.matrix(DocumentTermMatrix(corpus))
dtf_50  <- create_dtf_matrix(ECS50_exams)
dtf_132 <- create_dtf_matrix(ECS132_exams)
dtf_145 <- create_dtf_matrix(ECS145_exams)
dtf_152A <- create_dtf_matrix(ECS152A_exams)
dtf_154A <- create_dtf_matrix(ECS154A_exams)
dtf_154B <- create_dtf_matrix(ECS154B_exams)
dtf_156 <- create_dtf_matrix(ECS156_exams)
dtf_158 <- create_dtf_matrix(ECS158_exams)
dtf_256 <- create_dtf_matrix(ECS256_exams)
frequent_words <- c(colnames(dtf_50), colnames(dtf_132), colnames(dtf_145), colnames(dtf_152A),
                    colnames(dtf_154A), colnames(dtf_154B), colnames(dtf_156), colnames(dtf_158), colnames(dtf_256))
dtf <- dtf[,frequent_words]
dtf
