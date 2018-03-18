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

# read files and store in each course's exam vector
remove_latex_term <- function(file) gsub("([{]?)[\\](.)*[}]", " ", readLines(file))
collapse_exam <- function(exam) unlist(lapply(exam, remove_latex_term))
ECS50_exams <- collapse_exam(ECS50_exams)
ECS132_exams <- collapse_exam(ECS132_exams)
ECS145_exams <- collapse_exam(ECS145_exams)
ECS152A_exams <- collapse_exam(ECS152A_exams)
ECS154A_exams <- collapse_exam(ECS154A_exams)
ECS154B_exams <- collapse_exam(ECS154B_exams)
ECS156_exams <- collapse_exam(ECS156_exams)
ECS158_exams <- collapse_exam(ECS158_exams)
ECS256_exams <- collapse_exam(ECS256_exams)

# remove stopwords for better analysis
clean_corpus <- function(file) {
  corpus <- Corpus(VectorSource(file))
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  stop_words <- c("item", "cdot", "find", "copy", "make", "suppose", stopwords())
  corpus <- tm_map(corpus, removeWords, stop_words)
  corpus <- tm_map(corpus, stripWhitespace)
  return(corpus)
}
corpus <- clean_corpus(ECS50_exams)
corpus <- TermDocumentMatrix(corpus)
corpus

# create term frequency data frame for a given exam
getTermsFrequency <- function(corpus.tdm){
  all.terms <- findFreqTerms(corpus.tdm)
  freq = tm_term_score(x = corpus.tdm, terms = all.terms, FUN = slam::row_sums)
  terms <- names(freq); names(freq) <- NULL
  corpora.allTermsFrequency <- data.frame(term = terms, freq = freq)
  corpora.allTermsFrequency[order(corpora.allTermsFrequency$freq, decreasing = T), ]
}
corpus <- getTermsFrequency(corpus)
corpus

# drawing word cloud
visualizeWordcloud <- function(ftm.df){
  mypal <- brewer.pal(8,"Dark2")
  wordcloud(words = ftm.df$term,
            freq = ftm.df$freq, 
            colors = mypal, 
            scale=c(2,.1),
            random.order = F, max.words = 500)
}
visualizeWordcloud(corpus)
