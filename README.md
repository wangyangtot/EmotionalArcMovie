# Overview
EmotionalArcMovie is an interactive recommender system  that supports discovery of unknown
           movies
                    with the desired
                    sentiment arc to go beyond the static ranked list paradigm.
                    
Motived by the research paper[ The emotional arcs of stories are dominated by six basic shapes ](https://arxiv.org/abs/1606.07772)
 that used the NLP methodology to map emotional journeys of novel collections and identified 6 emotional arcs which describe all those stories,I decided to analized 9000 movie scripts and build a movie recommendation system engine.
 
 The example of an interactive main interface of engine as below:

[![Watch the video]](https://youtu.be/AeYTEjcYPZs)

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

The movie meta-information like youtubeId,genome vectors,movieID,could be downloaded the latest version of dataset from the [movieLens(https://github.com/wangyangtot/EmotionalArcMovie/blob/master/app/static/pig/EmotionalArcMovie.png)](https://grouplens.org/datasets/movielens/).

## Process the data cleaning
Like the way to run imsdb_scraping.ipynb scipts,consecutively run  
```combine_movielens_scripts.ipynb
write_genome_df.ipynb
write_movie_with_youtubeId.ipynb
rating_with_imdbId.ipynb
```
## Extract the emotional arcs
This is done by looking up each word of a given window in the [NRC Word-Emotion Association Lexicon](http://saifmohammad.com/WebPages/NRC-Emotion-Lexicon.htm), which associates words 2 sentiments (negative, positive). The code that extract the emotional content, smooth the arc trajectory and subsample 100 points of each movie  is in src/R_sentiment.r. It can be run in R interactive shell by a command:

```Rscript R_sentiment.r.```

The code creates a directory "../data/normed_sentiment/", where it stores the datapoints needed to trace the trajectory for each movie.

## K-means cluster
it will use all the 100-dimentional vectors of everymovie to fit  in 6 clusters, reducing the 100-dimensional emotional arc to 2-dimentio as well for visualizing on the plane.All results by k-means will be in a dicrectory ""../data/k-means-results/".

```k_means.ipynb```

## calculate the simlarities between each pair of movies concerning the genome and emotional arc
After having the 100-dimentional arcs and the  genome vector of every movie,we calculated the sentiment arc simmilarities ans genome similarities betwen each pair of  movies.this is done by c++ scipts calculate_genome_similarities.cpp and calculate_sentiment_similarities.cpp since wi will take more than one day but only 4 minutes in c++.

open the terminal and type in

```
gcc calculate_genome_similarities.cpp -o calculate_genome_similarities.out  
./calculate_genome_similarities.out
gcc calculate_sentiment_similarities.cpp -o calculate_genome_similarities.out  
./calculate_sentiment_similarities.out

```

## matrix factorization Collaborative Filtering
To build a recommend system for registered usrs,I applied the matrix factorization algorithm by using the ratings from Movielens. I used [turi create](https://github.com/apple/turicreate) to train the model  and save in the dirtory "..data/tc_matrix_factorization_model'.the code is 

```
turi_matrix_factorization.ipynb
```

# Develop a web app as recommendion system

This  is a a hybrid recommender system which integrates content and sentiment-based filtering in an
        interactive main interface. It based on the Collaborative Filtering(for the user having past history)
        and
        the content-based recommendation(for the user don't have the past history). And on top of it , the recommender
        give
        the user right to choose movies with centain type of emotional arc and adjust the influence of the emotional arc
        of
        movies.
        
To see more details about the project or to try the  web app,the link is(http://127.0.0.1:5000/EmotionalArcMovie) .


