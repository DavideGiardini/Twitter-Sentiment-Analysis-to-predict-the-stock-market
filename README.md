# Evaluating the efficiency of Twitter Sentiment Analysis as a tool of prediction for the stock market
This research wants to build a time serie of the polarity of tweets related to a cluster of firms, and compare it to the time serie of the same firms in the stock market. The chosen firms are: Apple, Google, Nike, Nestlé, Beyond Meat, Bayer and NovaVax.<br>

## Download and Analysis
To download all the tweets related to the firms I used Twitter's API. I wrote all the code in R, and automated it thanks to **Windows Task Manager**, so that the download would have started every day at the same our, by itself. The downloaded tweets were then automatically uploaded to OneDrive, so that I could access them at any time.<br>

I also implemented an automated **Gmail notification** that would notified me that the download was correctly occured and would send me some general statistics.<br>

I then proceded to clean all the data, lemmatize it, and analyze it.
In order to sentiment analyze it I used 3 methods:
1. **Naive Bayes**<br> Based on the Bayes Theorem, the algorithm classifies every tweet as "positive" or "negative" using the ["MPQA Subjectivity Lexicon"](https://mpqa.cs.pitt.edu/lexicons/subj_lexicon/) by Janyce Wiebe.
2. **Syuzhet**<br> Uses [package Syuzhet](https://cran.r-project.org/web/packages/syuzhet/syuzhet.pdf) and homonym dictionary to give a score to each tweet.
3. **udpipe**<br> Uses [package UdPipe](https://cran.r-project.org/web/packages/udpipe/udpipe.pdf) (with the MPQA subj lexicon) to give a score to each tweet. Has the possibility to use inensifier, weakeners and modifiers (so that it can, for example, distinguish between "good", "very good", "quite good" and "not good")

## Visualizations
The data was then visualized using R package "ggplot2". Here is some example of some of the graph I built, using Google as reference:
<p align = "center">
  <img height = "250" src="https://user-images.githubusercontent.com/98034877/175571677-4f21a6a8-a76d-46dd-8e8d-52c6488db619.png">
  <img height = "250" src="https://user-images.githubusercontent.com/98034877/175571706-5225b0d7-a5e4-4376-947c-f310b3101e9a.png">
  <img height = "350" src="https://user-images.githubusercontent.com/98034877/175571688-c6127c49-5ccc-49e9-b4d4-d0d75e76ae88.png">
  <img height = "350" src="https://user-images.githubusercontent.com/98034877/175571721-e43ceaf0-f9ff-412a-b57f-ade55ab4f510.png">
</p>


## Conclusions
In order to evaluate the existence of a relationship of causality between the tweets and the closing price of the firm, I built a test based on [Granger Causality Test](https://en.wikipedia.org/wiki/Granger_causality) that I called "Close Test".
This test brought very positive results highlighting numerous relationship of causality, summarized in the next table:
<p align = "center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/98034877/175568807-2e53a0b3-a7c2-49dc-8928-40715f4f6230.png">
</p>

>where: <br>
>"n" = number of significant reletionship found <br>
>"\*" = number of relationship with a p.value < 0.10 <br>
>"\*\*" = number of relationship with a p.value < 0.05 <br>
>"\*\*\*" = number of relationship with a p.value < 0.01 <br>

The Test Score also found that, in our cluster of firms, using the tweets that only refer to the value of the firm in the stock market (for ex containing: $AAPL, $GOOGL, ecc.) (*dataset "stock"*) is more suitable for a short term prevision (forecasting the closing prize of the same day), while using the tweet tha refer to the company in general (for ex containing also: Apple, Google, ecc.) (*dataset "score"*) is more suitable for longer term prevision (forecasting the value in the next days). As summarized by the next table:
<p align = "center">
  <img width="521" alt="image" src="https://user-images.githubusercontent.com/98034877/175570883-25463150-16a3-4fbf-b014-76e5ec616a60.png">
</p>
