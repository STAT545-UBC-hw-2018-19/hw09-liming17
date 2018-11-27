all: report.html letterCounting.html

clean:
	rm -f words.txt histogram.tsv histogram.png report.md report.html letterCount.tsv letter.png letterCounting.html letterReport.md

report.html: report.rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'

histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

histogram.tsv: histogram.r words.txt
	Rscript $<

letterCount.tsv: letterCounting.R words.txt
	Rscript $<

letter.png: letterCount.tsv
	Rscript -e 'library(ggplot2); ggplot(read.delim("$<"), aes(x = letters, y = x)) + geom_bar(stat = "identity") + xlab("letters") + ylab("frequency") + labs(title = "Letter Counting"); ggsave("$@")'
	rm Rplots.pdf

letterCounting.html: letterReport.Rmd letterCount.tsv letter.png
	Rscript -e 'rmarkdown::render("$<")'

words.txt: /usr/share/dict/words
	cp $< $@

# words.txt:
#	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'
