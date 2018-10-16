# Overview
EmotionalArcMovie is an interactive recommender system  that supports discovery of unknown
           movies
                    with the desired
                    sentiment arc to go beyond the static ranked list paradigm.
                    
Motived by the research paper("https://arxiv.org/abs/1606.07772")
 that used the NLP methodology to map emotional journeys of novel collections and identified 6 emotional arcs which describe all those stories,I decided to analized 9000 movie scripts and build a movie recommendation system engine.
 
 The example of an interactive main interface of engine as below:

The detailed project introduction is https://annavm.github.io/Project_Plotline/example/:

# Requirements and installation

It is recommended to use the Anaconda distribution, to install a set of standard required packages. Once Anaconda is installed, please type:

```conda install numpy pandas matplotlib```

The additional required Python packages are listed in the file requirements.txt. In order to install them, please type:

```pip install -r requirements.txt```

# Usage and data pipeline
The scripts are obtained by scraping 1100 movies from website IMSDb and 23576 from springfieledspringfiled. You can automatically download  them by running the code in src/imsdb_scraping .ipynb and src/scraping_springField_movieScripts.ipynb.

```cd src/
jupyter notebook```

run imsdb_scraping .ipynb and scraping_springField_movieScripts.ipynb.
Above code will creates a directory data/imsdb_scraping,and springField_scraping where they stores the movie scripts, along with some metainformation.
