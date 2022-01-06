# This script executes an EMLassemblyline workflow.

# Initialize workspace --------------------------------------------------------

# Update EMLassemblyline and load

remotes::install_github("EDIorg/EMLassemblyline")
library(EMLassemblyline)

# Define paths for your metadata templates, data, and EML

path_templates <- paste0(getwd(), "/edi.1045/metadata_templates")
path_data <- paste0(getwd(), "/edi.1045/data_objects")
path_eml <- paste0(getwd(), "/edi.1045/eml")

# Create metadata templates ---------------------------------------------------

# Below is a list of boiler plate function calls for creating metadata templates.
# They are meant to be a reminder and save you a little time. Remove the 
# functions and arguments you don't need AND ... don't forget to read the docs! 
# E.g. ?template_core_metadata

# Create core templates (required for all data packages)

EMLassemblyline::template_core_metadata(
  path = path_templates,
  license = "CCBY",
  file.type = ".txt")

# Create table attributes template (required when data tables are present)

EMLassemblyline::template_table_attributes(
  path = path_templates,
  data.path = path_data,
  data.table = "soil_wood_samples_loc_info_2016_2019.csv")

# Create categorical variables template (required when attributes templates
# contains variables with a "categorical" class)

EMLassemblyline::template_categorical_variables(
  path = path_templates, 
  data.path = path_data)

# Create geographic coverage (required when more than one geographic location
# is to be reported in the metadata).

# EMLassemblyline::template_geographic_coverage(
#   path = path_templates, 
#   data.path = path_data, 
#   data.table = "", 
#   lat.col = "",
#   lon.col = "",
#   site.col = "")

# Create taxonomic coverage template (Not-required. Use this to report 
# taxonomic entities in the metadata)

# remotes::install_github("EDIorg/taxonomyCleanr")
# library(taxonomyCleanr)
# 
# taxonomyCleanr::view_taxa_authorities()
# 
# EMLassemblyline::template_taxonomic_coverage(
#   path = path_templates, 
#   data.path = path_data,
#   taxa.table = "",
#   taxa.col = "",
#   taxa.name.type = "",
#   taxa.authority = 3)

# Make EML from metadata templates --------------------------------------------

# Once all your metadata templates are complete call this function to create 
# the EML.

EMLassemblyline::make_eml(
  path = path_templates,
  data.path = path_data,
  eml.path = path_eml, 
  dataset.title = "Palmyra Atoll soil and/or wood density sampling locations used in the carbon storage analysis", 
  temporal.coverage = c("2016", "2019"), 
  geographic.description = "Palmyra Atoll", 
  geographic.coordinates = c("5.88333", "-162.04300", "5.87100", "-162.08300"), 
  maintenance.description = "completed", 
  data.table = c("soil_wood_samples_loc_info_2016_2019.csv"), 
  data.table.name = c("Palmyra Atoll Soil and Wood Sample attributes  2016 and 2019"),
  data.table.description = c("Additional information of trees and soil samples"),
  other.entity = c("soil_wood_samples_location_palmyra_2016_2019.zip"),
  other.entity.name = c("Shapefiles with geospatil data"),
  other.entity.description = c("zip file with all necessary files to read in the location of the sampling for this project"),
  user.id = "palmyra_priject",
  user.domain = "EDI", 
  package.id = "1045.1")
