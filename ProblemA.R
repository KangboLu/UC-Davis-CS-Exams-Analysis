# data frame specification:
# it has column names: 'course name', 'year offered', 'major', 'quiz average'
# Course name. We will have ECS 132, 145 and 158.
# Year/quarter offered. E.g. 2012.1 is Winter 2012, 2012.2 is Spring 2012, 2015.3 is Fall 2015.
#   This data will be used to determine whether there has been some time trend in my quiz grades in recent years.
# Student major (CS, CSE only).
# Overall quiz average.

# Preparing data for statistical analysis
# ================================
# creating ECS 132 quiz data frame
# ================================
quiz_132_f13 <- read.table("http://heather.cs.ucdavis.edu/~matloff/132/Hwk/ProblemAData/132/F13.txt", header = FALSE)
quiz_132_f13 <- cbind(rep("2013.3", nrow(quiz_132_f13)), quiz_132_f13)
colnames(quiz_132_f13) <- c("year offered", "major", "quiz average")
# quiz_132_f13
quiz_132_w15 <- read.table("http://heather.cs.ucdavis.edu/~matloff/132/Hwk/ProblemAData/132/W15.txt", header = FALSE)
quiz_132_w15 <- cbind(rep("2015.1", nrow(quiz_132_w15)), quiz_132_w15)
colnames(quiz_132_w15) <- c("year offered", "major", "quiz average")
# quiz_132_w15
quiz_132_w16 <- read.table("http://heather.cs.ucdavis.edu/~matloff/132/Hwk/ProblemAData/132/W16.txt", header = FALSE)
quiz_132_w16 <- cbind(rep("2016.1", nrow(quiz_132_w16)), quiz_132_w16)
colnames(quiz_132_w16) <- c("year offered", "major", "quiz average")
# quiz_132_w16
quiz_132_w17 <- read.table("http://heather.cs.ucdavis.edu/~matloff/132/Hwk/ProblemAData/132/W17.txt", header = FALSE)
quiz_132_w17 <- cbind(rep("2017.1", nrow(quiz_132_w17)), quiz_132_w17)
colnames(quiz_132_w17) <- c("year offered", "major", "quiz average")
# quiz_132_w17
quiz_132_data <- rbind(quiz_132_f13, quiz_132_w15, quiz_132_w16, quiz_132_w17)
quiz_132_data <- cbind(rep("ECS 132", nrow(quiz_132_data)), quiz_132_data)
colnames(quiz_132_data) <- c("course name", "year offered", "major", "quiz average")
# quiz_132_data

# ================================
# creating ECS 145 quiz data frame
# ================================
quiz_145_f14 <- read.table("http://heather.cs.ucdavis.edu/~matloff/132/Hwk/ProblemAData/145/F14.txt", header = FALSE)
quiz_145_f14 <- cbind(rep("2014.3", nrow(quiz_145_f14)), quiz_145_f14)
colnames(quiz_145_f14) <- c("year offered", "major", "quiz average")
# quiz_145_f14
quiz_145_w17 <- read.table("http://heather.cs.ucdavis.edu/~matloff/132/Hwk/ProblemAData/145/W17.txt", header = FALSE)
quiz_145_w17 <- cbind(rep("2017.1", nrow(quiz_145_w17)), quiz_145_w17)
colnames(quiz_145_w17) <- c("year offered", "major", "quiz average")
# quiz_145_w17
quiz_145_data <- rbind(quiz_145_f14, quiz_145_w17)
quiz_145_data <- cbind(rep("ECS 145", nrow(quiz_145_data)), quiz_145_data)
colnames(quiz_145_data) <- c("course name", "year offered", "major", "quiz average")
# quiz_145_data

# ================================
# creating ECS 158 quiz data frame
# ================================
quiz_158_f13 <- read.table("http://heather.cs.ucdavis.edu/~matloff/132/Hwk/ProblemAData/158/F13.txt", header = FALSE)
quiz_158_f13 <- cbind(rep("2013.3", nrow(quiz_158_f13)), quiz_158_f13)
colnames(quiz_158_f13) <- c("year offered", "major", "quiz average")
# quiz_158_f13
quiz_158_f17 <- read.table("http://heather.cs.ucdavis.edu/~matloff/132/Hwk/ProblemAData/158/F17.txt", header = FALSE)
quiz_158_f17 <- cbind(rep("2017.3", nrow(quiz_158_f17)), quiz_158_f17)
colnames(quiz_158_f17) <- c("year offered", "major", "quiz average")
# quiz_158_f17
quiz_158_s16 <- read.table("http://heather.cs.ucdavis.edu/~matloff/132/Hwk/ProblemAData/158/S16.txt", header = FALSE)
quiz_158_s16 <- cbind(rep("2016.2", nrow(quiz_158_s16)), quiz_158_s16)
colnames(quiz_158_s16) <- c("year offered", "major", "quiz average")
# quiz_158_s16
quiz_158_w15 <- read.table("http://heather.cs.ucdavis.edu/~matloff/132/Hwk/ProblemAData/158/W15.txt", header = FALSE)
quiz_158_w15 <- cbind(rep("2017.3", nrow(quiz_158_w15)), quiz_158_w15)
colnames(quiz_158_w15) <- c("year offered", "major", "quiz average")
# quiz_158_w15
quiz_158_data <- rbind(quiz_158_f13, quiz_158_f17, quiz_158_s16, quiz_158_w15)
quiz_158_data <- cbind(rep("ECS 158", nrow(quiz_158_data)), quiz_158_data)
colnames(quiz_158_data) <- c("course name", "year offered", "major", "quiz average")
# quiz_158_data

# Combine 132, 145, and 159 data and modify course name column data
student_quiz <- rbind(quiz_132_data, quiz_145_data, quiz_158_data)
major_name_modifer <- function(name) ifelse(name=="LCSI", "CS", "CSE")
student_quiz["major"] <- lapply(student_quiz["major"], major_name_modifer)
student_quiz