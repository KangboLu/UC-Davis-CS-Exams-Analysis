# data frame specification:
# it has column names: 'course name', 'year offered', 'major', 'quiz average'
# Course name. We will have ECS 132, 145 and 158.
# Year/quarter offered. E.g. 2012.1 is Winter 2012, 2012.2 is Spring 2012, 2015.3 is Fall 2015.
#   This data will be used to determine whether there has been some time trend in my quiz grades in recent years.
# Student major (CS, CSE only).
# Overall quiz average.

# Preparing data for statistical analysis
# ==================================================================
# creating data frame includes ECS 132, ECS 145, ECS 158 quiz data
# ================================================================
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

# creating ECS 145 quiz data frame
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

# creating ECS 158 quiz data frame
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

#=======================================================================
# 95% Confidence Interval for each course's population mean quiz average
#=======================================================================
# 95% Confidence Interval for ECS 132 population mean quiz average
ECS132_sample_mean <- mean(quiz_132_data[["quiz average"]])
ECS132_sample_variance <- mean(quiz_132_data[["quiz average"]]^2) - ECS132_sample_mean^2
ECS132_sample_std <- sqrt(ECS132_sample_variance)
radius <- 1.96 * ECS132_sample_std / sqrt(nrow(quiz_132_data))
cat("Approx. 95% CI for population mean quiz average for ECS132 =",
    ECS132_sample_mean - radius,"to", ECS132_sample_mean + radius,"\n")

# 95% Confidence Interval for ECS 145 population mean quiz average
ECS145_sample_mean <- mean(quiz_145_data[["quiz average"]])
ECS145_sample_variance <- mean(quiz_145_data[["quiz average"]]^2) - ECS145_sample_mean^2
ECS145_sample_std <- sqrt(ECS145_sample_variance)
radius <- 1.96 * ECS145_sample_std / sqrt(nrow(quiz_145_data))
cat("Approx. 95% CI for population mean quiz average for ECS145 =",
    ECS132_sample_mean - radius,"to", ECS145_sample_mean + radius,"\n")

# 95% Confidence Interval for ECS 158 population mean quiz average
ECS158_sample_mean <- mean(quiz_158_data[["quiz average"]])
ECS158_sample_variance <- mean(quiz_158_data[["quiz average"]]^2) - ECS158_sample_mean^2
ECS158_sample_std <- sqrt(ECS158_sample_variance)
radius <- 1.96 * ECS158_sample_std / sqrt(nrow(quiz_158_data))
cat("Approx. 95% CI for population mean quiz average for ECS158 =",
    ECS158_sample_mean - radius,"to", ECS158_sample_mean + radius,"\n")

#================================================================================
# 95% Confidence Interval for the difference in ECS132 and ECS145 Population Mean
#================================================================================
# p_hat1 − p_hat2 ± R
p_hat1 <- ECS132_sample_mean
p_hat2 <- ECS145_sample_mean
R <- 1.96 * sqrt( (ECS132_sample_variance/nrow(quiz_145_data)) + (ECS145_sample_variance/nrow(quiz_145_data)) )
cat("\nApprox. 95% CI for the difference in ECS132 and ECS145 Population Mean =",
    p_hat1 - p_hat2 - R,"to", p_hat1 - p_hat2 + R,"\n")

#==============================================================================================================
# 95% Confidence Interval for the difference in population mean quiz averages in ECS 145 between the two majors
#==============================================================================================================
# p_hat1 − p_hat2 ± R
ECS_145 <- subset(student_quiz, student_quiz["course name"] == "ECS 145")
CSEin145 <- unlist(subset(ECS_145, ECS_145["major"] == "CSE", select = "quiz average"))
CSin145 <- unlist(subset(ECS_145, ECS_145["major"] == "CS", select = "quiz average"))
p_hat1 <- mean(CSEin145)
p_hat2 <- mean(CSin145)
varCSEin145 <- mean(CSEin145^2) - p_hat1^2
varCSin145 <- mean(CSin145^2) - p_hat2^2
R <- 1.96 * sqrt( (varCSEin145/length(CSin145)) + (varCSin145/length(CSin145)) )
cat("\nApprox. 95% CI for the difference in population mean quiz averages in ECS 145 between the two majors =",
    p_hat1 - p_hat2 - R,"to", p_hat1 - p_hat2 + R,"\n")
