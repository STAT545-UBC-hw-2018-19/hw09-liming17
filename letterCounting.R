words <- readLines("words.txt")
letterCount <- sapply(letters, function(x) x<-sum(x==unlist(strsplit(words,""))))
write.table(letterCount, "letterCount.tsv",
						sep = "\t", row.names = FALSE, quote = FALSE)