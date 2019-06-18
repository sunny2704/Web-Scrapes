api_key <- 'YOUR_API_KEY'
api_secret <- 'YOUR_API_SECRET'
access_token <- 'YOUR_ACCESS_TOKEN'
access_token_secret <- 'YOUR_ACCESS_TOKEN_SECRET'

library(twitteR)
library(tidyverse)
twitter_data <-read_csv("E:/CSA/twitter details.csv")
user_handles <- twitter_data$Twitter
setup_twitter_oauth(api_key, api_secret,access_token, access_token_secret)

for (i in 1:length(user_handles))
{
    tryCatch({existing_users <- lookupUsers(user_handles[i], includeNA = TRUE)
    user_info <-getUser(existing_users)
    info_df <- as.data.frame(user_info)
    
    if (grepl("GPA",ignore.case = TRUE, info_df$description)  == TRUE)
    {
      info_df$description <- info_df$description
      
    }else
    {
      info_df$description <- ' '
    }
    
    if (i == 1)
    {
      write.table(info_df,'twitter.csv', append = T, row.names = F, sep = ',')
      
    }else
    {
      write.table(info_df,'twitter.csv', append = T, col.names = F, row.names = F, sep = ',')
    } 
    
    }, error = function(e){
      
    })  
}