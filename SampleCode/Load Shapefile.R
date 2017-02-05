setwd( "..." )


# load and plot your shapefile

library( maptools )
library( sp )

syr <- readShapePoly( fn="01-05-2015", proj4string=CRS("+proj=longlat +datum=WGS84") )

plot( syr,  border="gray80" )



# Extract Parcel Data for Analysis

head( as.data.frame( syr ) )

dat <- as.data.frame( syr )

names( dat )

nrow( dat )

table( dat$LandUse )




# Examine Specific Neighborhood

these.downtown <- syr$Nhood == "Downtown"

downtown <- syr[ these.downtown , ]

these.downtown[ is.na(these.downtown) ] <- F

downtown <- syr[ these.downtown , ]

plot( downtown )



