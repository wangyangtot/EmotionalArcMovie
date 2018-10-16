# Overview
EmotionalArcMovie is an interactive recommender system  that supports discovery of unknown
           movies
                    with the desired
                    sentiment arc to go beyond the static ranked list paradigm.
                    
Motived by the research paper[ The emotional arcs of stories are dominated by six basic shapes ](https://arxiv.org/abs/1606.07772)
 that used the NLP methodology to map emotional journeys of novel collections and identified 6 emotional arcs which describe all those stories,I decided to analized 9000 movie scripts and build a movie recommendation system engine.
 
 The example of an interactive main interface of engine as below:

The detailed project introduction is https://annavm.github.io/Project_Plotline/example/:

# Requirements and installation

It is recommended to use the Anaconda distribution, to install a set of standard required packages. Once Anaconda is installed, please type:

```conda install numpy pandas matplotlib```

The additional required Python packages are listed in the file requirements.txt. In order to install them, please type:

```pip install -r requirements.txt```

# Usage and data pipeline
##Download the data source
The scripts are obtained by scraping 1100 movies from website [IMSDb](https://www.imsdb.com/) and 23576 from [springfieledspringfiled](https://www.springfieldspringfield.co.uk/). You can automatically download  them by running the code in src/imsdb_scraping .ipynb and src/scraping_springField_movieScripts.ipynb.

```
cd src/
jupyter notebook
```

and then run imsdb_scraping.ipynb and scraping_springField_movieScripts.ipynb.
Above code will creates a directory data/imsdb_scraping,and springField_scraping where they stores the movie scripts, along with some meta-information.

The movie meta-information like youtubeId,genome vectors,movieID,could be downloaded the latest version of dataset from the [movieLens](https://grouplens.org/datasets/movielens/).

## Process the data cleaning
Like the way to run imsdb_scraping.ipynb scipts,consecutively run  
```combine_movielens_scripts.ipynb
write_genome_df.ipynb
write_movie_with_youtubeId.ipynb
rating_with_imdbId.ipynb
```
## Extract the emotional arcs
This is done by looking up each word of a given window in the [NRC Word-Emotion Association Lexicon](http://saifmohammad.com/WebPages/NRC-Emotion-Lexicon.htm), which associates words 2 sentiments (negative, positive). The code that extract the emotional content, smooth the arc trajectory and subsample 100 points of each movie and is in src/R_sentiment.r. It can be run in R interactive shell by command:
```Rscript R_sentiment.r.```

The code creates a directory "../data/normed_sentiment/, where it stores the datapoints needed to trace the trajectory for each movie.

## K-means cluster



