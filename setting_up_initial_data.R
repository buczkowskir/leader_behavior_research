

### Data gathering and initial analysis of Leader data

### Ryan Buczkowski

### University of Mississippi

#-----------------------------------------------------#

# Loading Libraries
pacman::p_load('tidyverse')

# Importing Leader data
read_csv("C:/Users/ryanb/Dropbox/Research Practicum/practicum_project/CarterSmithThetas.csv") %>% 
  select(idacr, year, ccode, leadername, inyear, outyear, starts_with('theta2')) -> leaders

# Importing Varieties of Democracy data
read_csv("C:/Users/ryanb/Desktop/V-Dem-CY-Full+Others-v10.csv") %>% 
  select(country_name,
         COWcode,
         year,
         v2x_polyarchy,
         v2x_delibdem,
         v2x_delibdem,
         v2x_partip,
         v2x_egal) -> vdem

leaders %>% 
  rename('COWcode' = ccode) %>% 
  na.omit() %>% 
  mutate(year = map2(inyear, outyear, seq)) %>% 
  unnest(year) %>% 
  select(idacr, year, COWcode, leadername, starts_with('theta')) %>% 
  left_join(vdem) -> vdem_leaders

vdem_leaders %>% 
  write_csv(path = 'data/hawkishness_with_democractic_institutionalization.csv')
