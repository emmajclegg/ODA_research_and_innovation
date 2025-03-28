# Script to pull off lists of most common organisations by country

# Read in dataset of organisations and countries from previous script
organisation_table <- readRDS("Outputs/organisation_table.rds")
tableau_projects_tidied <- readRDS("Outputs/tableau_projects_tidied.rds") 

# Set country of interest
country <- c("United Kingdom")

project_subset <- tableau_projects_tidied %>% 
  filter(Funder == "Foreign, Commonwealth and Development Office")

# Subset for list of organisations based in specified country, active 
# projects only, specified funder only
country_orgs <- organisation_table %>% 
  filter(# organisation_country %in% country,
         project_id %in% tableau_projects_tidied$id)

# Summarise organisations by number of projects
country_orgs_summarised <- country_orgs %>% 
  group_by(organisation_country, organisation_name) %>% 
  summarise(no_projects = n()) %>% 
  arrange(organisation_country, -no_projects)

write.csv(country_orgs_summarised, "country_orgs_summarised.csv")
