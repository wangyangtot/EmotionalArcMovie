#this script doing the sentiment analysis  for select scripts.by using
#i) the select movies scripts are found in '../data/select_texts/'
#-------------------------
#the progression:
#1) he emotional arc of each movie script was calculated by exploiting the default labelled lexicon developed at the Nebraska Literary Laboratory. To that end, each script was partitioned into sentences and for each sentence the valence was calculated by assigning every word its sentimental value δ ∈ ( -1,1), where -1 referred to emotionally negative terms; and 1 referred to emotionally positive terms according to the lexico.
#2)I applies three smoothing methods which include a moving average, Loess((Locally Weighted Scatterplot Smoothing)[6], and Discrete Cosine Transform (DCT)to smooth the trajectory.
#3) the resulting trajectory was uniformly sub-sampled to have 100 points so that each script sentiment arc could be represented using the scrpts timing from 0% (beginning of the movie) to 100% (end of the movie).
#4) save the every selected movie's 100-dimentional vectors  to '../data/normed_sentiment/'
#------------------------
path_to_load<-"../data/select_texts/"
path_to_save<-"../data/normed_sentiment/"
file_names=list.files(path = path_to_load,recursive = TRUE)
i<-1
for (file in file_names) {
print(i)
i <- (i+ 1)
load_file_path<-paste(path_to_load,file,sep="")
save_file_path<-paste(path_to_save,file,sep="")
text<- get_text_as_string(load_file_path)
sentence<- get_sentences(text)
sentiment <- get_sentiment(sentence)
normed_sentiment <- get_dct_transform(sentiment, scale_range = T, low_pass_size = 5)
write.table(normed_sentiment,save_file_path, row.names = FALSE, col.names=FALSE, sep = "\t")
}
