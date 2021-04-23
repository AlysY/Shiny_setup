## Linking dropbox to your r


#-----------------------------------------------------------------------------
## Run this ##
##    |
##    V

install.packages('rdrop2')
library(rdrop2)

## authentification
drop_auth()
# save the token
token <- drop_auth()
saveRDS(token, file = "token.rds")

## account  info
library(dplyr)
drop_acc() %>% data.frame()

## create a new folder
drop_create('dropbox_test_R')


#-----------------------------------------------------------------------------
## Dont need to run this ##
## but you can for interest 

# ## Other functions to note
# ## save file
# write.csv(mtcars, 'mtcars2.csv')
# drop_upload('mtcars2.csv', path = "dropbox_test_R")
# 
# ## list files
# drop_dir(path ="dropbox_test_R" )
# 
# ## download file
# drop_download("dropbox_test_r/mtcars.csv", overwrite = TRUE)
