## creating the basic dataframe to save and append in the shiny app


#-----------------------------------------------------------------------------
## Run this ##
##    |
##    V


# the dataframe
test_data <- data.frame(name = "alys", month = "April", year = 2021, notes = "first data entry")

# save to working directory
write.csv(test_data, 'test1.csv', row.names = FALSE)

# upload to dropbox, into the folder called dropbox_test_R
drop_upload('test1.csv', path = "dropbox_test_R")






#-----------------------------------------------------------------------------
## Dont need to run this ##
## but you can for interest 


# ## testing adding new rows to it
# # a new dataframe with same columns
# data_entry <- data.frame(name = "Cat", month = "Jan", year = 2021, notes = "Rbind trial")
# 
# # bind together
# data_added <- rbind(test_data, data_entry)
# 
# # save to working directory
# write.csv(data_added, 'test1.csv', row.names = FALSE)
# 
# # upload to dropbox, saving over the other file
# drop_upload('test1.csv', path = "dropbox_test_R")
