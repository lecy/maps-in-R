# Dowloading TIGER Shapefiles
# 
# GIS uses underlying 'shapefiles' in order to draw map borders and represent data using choropleth maps.
# 
# The interface for finding and downloading TIGER shapefiles is pretty reasonable, so this can be done directly on the site.
# 
# https://www.census.gov/geo/maps-data/data/tiger-line.html
# 
# These are big files and difficult to share, however, so it is nice to create an easily reproducible way to create the same map. You can do this by searching the FTP section of the download interface for the map you desire, copying the link, and using that to download the shapefile right into R.




### create a new directory for your data

dir.create( "shapefiles" )

setwd( "./shapefiles" )



### download TIGER shapefile from the census

# for information on available shapefiles:
#
# https://www.census.gov/geo/maps-data/data/tiger-line.html



download.file("ftp://ftp2.census.gov/geo/tiger/TIGER2010/TRACT/2010/tl_2010_36067_tract10.zip", "onondaga census tracts.zip" )

unzip( "onondaga census tracts.zip" )

file.remove( "onondaga census tracts.zip" )

dir()




# load and plot your shapefile

library( maptools )
library( sp )

syr <- readShapePoly( fn="tl_2010_36067_tract10", proj4string=CRS("+proj=longlat +datum=WGS84") )

plot( syr,  border="gray10" )
