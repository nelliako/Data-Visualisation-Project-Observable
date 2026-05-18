# Load libraries
library(tidyverse)
library(jsonlite)
library(dplyr)

# Load data
raw_data <- fromJSON("~/Desktop/Data Viz readings/Coursework/Data Visualisation project/data.json", simplifyDataFrame = TRUE)

# Extract and convert
nodes <- as_tibble(raw_data$nodes)
links <- as_tibble(raw_data$links)

# Check if it worked
print("Here are the first few nodes:")
head(nodes)

View(nodes)
View(links)

# Nodes analysis: Overview of the number of songs by Oceanus Folk by year 
number_of_songs <- nodes %>% filter(genre=="Oceanus Folk") %>% group_by(release_date) %>% summarize(n())
View(number_of_songs)

# Q1
# Edges analysis: Influence
destination_nodes <- nodes %>% filter(genre =="Oceanus Folk") %>% pull(id)
View(destination_nodes)

influence <- links %>% 
  filter(`Edge Type` %in% c("InStyleOf", "InterpolatesFrom", "CoverOf", "LyricalReferenceTo", "DirectlySamples"), target %in% destination_nodes) # select source, year, link type

influence_for_cleaning <- influence %>% select(`Edge Type`, source)
View(influence)
View(influence_for_cleaning)

source_vector <- influence %>% pull(source)

group_by_year <- nodes %>% filter(id %in% source_vector) %>% select(release_date, genre, id, name) 
group_by_year_w_edges <- group_by_year %>% left_join(influence_for_cleaning, by = c("id" = "source"), relationship = "many-to-many")
View(group_by_year_w_edges)

# Cleaning
q1_data <- group_by_year_w_edges %>% 
  # 1.Remove the unwanted genre
  filter(genre != 'Oceanus Folk') %>% 
  
  # 2.Ensure each work is only counted once 
  distinct(id, name, genre, release_date, .keep_all = TRUE) %>% 
  
  # 3.Total rows for that specific year
  add_count(release_date, name = "total_a_year") %>% 
  
  # 4.Total rows for that year AND genre combo
  add_count(release_date, genre, name = "total_per_genre_a_year") %>% 
  
  # 5.Organize by date
  arrange(release_date)

View(q1_data)

write.csv(q1_data, "q1_data.csv", row.names = FALSE)

# Adding original Oceanus Folk songs to group_by_year, variation of group_by_year df
group_by_year_incl_oceanus <- nodes %>% filter(id %in% source_vector | genre=='Oceanus Folk') %>% group_by(release_date) %>% summarise(n())
View(group_by_year_incl_oceanus) 

# Saving to csv
# Save number_of_songs
write.csv(number_of_songs, "number_of_songs.csv", row.names = FALSE)

# Save group_by_year
write.csv(group_by_year, "group_by_year.csv", row.names = FALSE)

# Save group_by_year_incl_oceanus
write.csv(group_by_year_incl_oceanus, "group_by_year_incl_oceanus.csv", row.names = FALSE)

# Q2
# Getting genre and artists names of the source nodes
genres <- nodes %>% filter(id %in% source_vector) %>% select(`Node Type`, id, name, genre)
View(genres)

new_source_vector <- genres %>% pull(id)

# Adding artists for Q2
artists_df <- links %>% filter(target %in% new_source_vector, `Edge Type` %in% c("PerformerOf", "ComposerOf", "ProducerOf", "LyricistOf"))  %>% select(source, `Edge Type`, target)
artists_source <- artists_df %>% pull(source)
artists <- nodes %>% filter(id %in% artists_source) %>% select(id, `Node Type`, name)
View(artists)
# MemberOf
# bands_source <- artists %>% filter(`Node Type` == 'MusicalGroup') %>% pull(id)
# artists_from_band <- links %>% filter(`Edge Type` == 'MemberOf', target %in% bands_source) %>% select(source, `Edge Type`, target)
# View(artists_from_band)
# bands_for_nodes <- artists_from_band %>% pull(source)
# 
# artists_band <- nodes %>% filter(id %in% bands_for_nodes) %>% select(id, `Node Type`, name)
# View(artists_band)
# 
# 
# # Joining artists names and songs they perform etc that were influenced by Oceanus 
# # Firstly bands and artists
# artist_stacked_w_musgroup <- bind_rows(artists, artists_band)
# View(artist_stacked_w_musgroup)

# Secondly artists with the df that has songs ids

combined_data <- artists_df %>%
  left_join(artists, by = c("source" = "id"), relationship = "many-to-many")
View(combined_data)

# Thirdly artist, songs and genres
final_df_artists_genres <- genres %>% left_join(combined_data, by = c("id" = "target"), relationship = "many-to-many") %>% group_by(genre) %>% mutate(total_work = n(), total_album = sum(`Node Type.x` == "Album", na.rm = TRUE), 
                                                                                                                                                                   total_song = sum(`Node Type.x` == "Song", na.rm = TRUE)) 
View(final_df_artists_genres)

# De-dupe final df
frame_unique <- final_df_artists_genres %>% distinct()
View(frame_unique)

# Frame 1 for Q2
frame_1 <- frame_unique %>%
  distinct(id, genre, name.x, `Node Type.x`, .keep_all = TRUE) %>% group_by(genre) %>% mutate(total_work = n(), total_album = sum(`Node Type.x` == "Album", na.rm = TRUE), 
                                                                                              total_song = sum(`Node Type.x` == "Song", na.rm = TRUE)) %>% arrange(desc(total_work), genre)
View(frame_1)
write.csv(frame_1, "q2p1.csv")

# Frame 2 for Q2
frame_2 <- frame_unique %>%
  distinct(id, source, `Node Type.y`, .keep_all = TRUE) %>% group_by(name.y) %>% mutate(total_work = n(), total_album = sum(`Node Type.x` == "Album", na.rm = TRUE), total_song = sum(`Node Type.x` == "Song", na.rm = TRUE)) %>% arrange(desc(total_work), name.y)
View(frame_2)
write.csv(frame_2, "q2p2.csv")

View(artists_df)
View(artists)

# Save group_by_year
write.csv(genres, "genres.csv", row.names = FALSE)
write.csv(artists, "artists.csv", row.names = FALSE)

# Q3.1
# Specifying my source/target
sailor <- nodes %>% filter(name=='Sailor Shift') %>% pull(id)

# All years when Sailor Shift became active 
sailor_related_songs <- links %>% filter(`Edge Type` %in% c("PerformerOf", "ComposerOf", "ProducerOf", "LyricistOf"), source %in% c(sailor) | target %in% c(sailor))

source_sailor_vector <- sailor_related_songs %>% pull(source)

target_sailor_vector <-sailor_related_songs %>% pull(target)
  
sailor_activity <- nodes %>% filter(id %in% source_sailor_vector | id %in% target_sailor_vector) %>% group_by(release_date) %>% select(`Node Type`, name, id, release_date, genre)
View(sailor_activity)

# Is Sailor a member of any band?
sailor_band_target_edges <- links %>% filter(`Edge Type` == 'MemberOf', source %in% c(sailor)) %>% pull(target)
sailor_band_nodes <- nodes %>% filter(id %in% c(sailor_band_target_edges)) %>% select(`Node Type`, id, name) %>% pull(id)
View(sailor_band_nodes)

# Ivy Echoes added to sailor_activity
sailor_related_songs <- links %>% filter(`Edge Type` %in% c("PerformerOf", "ComposerOf", "ProducerOf", "LyricistOf"), source %in% c(sailor) | target %in% c(sailor) | source %in% c(sailor_band_nodes) | target %in% c(sailor_band_nodes))
source_sailor_vector <- sailor_related_songs %>% pull(source)
                                         
target_sailor_vector <-sailor_related_songs %>% pull(target)
                                        
sailor_activity <- nodes %>% filter(id %in% source_sailor_vector | id %in% target_sailor_vector) %>% group_by(release_date) %>% select(`Node Type`, name, id, release_date, genre)
View(sailor_activity)

# songs by Ivy Echoes 
ivy_echoes_related_songs <- links %>% filter(`Edge Type` %in% c("PerformerOf", "ComposerOf", "ProducerOf", "LyricistOf"), source %in% c(sailor_band_nodes) | target %in% c(sailor_band_nodes))
source_ivy_vector <- ivy_echoes_related_songs %>% pull(source)

target_ivy_vector <-ivy_echoes_related_songs %>% pull(target)

ivy_activity <- nodes %>% filter(id %in% source_ivy_vector | id %in% target_ivy_vector) %>% group_by(release_date) %>% select(`Node Type`, name, id, release_date, genre)
View(ivy_activity)

# Q3.2
influence_on_oceanus <- links %>% 
  filter(`Edge Type` %in% c("InStyleOf", "InterpolatesFrom", "CoverOf", "LyricalReferenceTo", "DirectlySamples"), source %in% destination_nodes)

View(influence_on_oceanus)
target_vector <- influence_on_oceanus %>% pull(target)

# Getting genres that influenced Oceanus Folk 
influence_by_year_genre_dirty <- nodes %>% filter(id %in% c(target_vector)) %>% select(name, genre, id, release_date) %>% distinct(name, genre, id, release_date, .keep_all = TRUE)
genre_influence_timeline <- influence_by_year_genre_dirty %>% group_by(release_date, genre) %>%
  summarise(count = n(), .groups = 'drop') %>% arrange(release_date)

#genres_influence_on_oceanus_draft <- nodes %>% filter(id %in% target_vector) %>% select(release_date, genre, name, id)

View(genre_influence_timeline)
write_csv(genre_influence_timeline, "genre_influence_timeline.csv")


