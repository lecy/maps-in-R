


# install.packages( "leaflet" )

library( leaflet )



code.violations <- read.csv("https://raw.githubusercontent.com/subartle/orangespot/master/data/code%20violations.csv")

lat.lon <- code.violations[ c("lat","lon","Complaint.Type","Identifier") ]

lat.lon <- na.omit( lat.lon )

      
syr.map <- leaflet(data=lat.lon ) %>% 
     
            addProviderTiles("CartoDB.Positron", tileOptions(minZoom=10, maxZoom=17))  %>%
     
            setView(lng=-76.13, lat=43.03, zoom=13) %>%
     
            setMaxBounds(lng1=-75, lat1=41, lng2=-77,  lat2=45)

# syr.map



# COLOR CODE POINTS

# highlight bed bugs

col.vec <- ifelse( code.violations$Complaint.Type == "Bed Bugs", "orange", NA )

addCircles( syr.map, lng = lat.lon$lon, lat = lat.lon$lat, col=col.vec, popup=lat.lon$Complaint.Type )






# ONLY OPEN CASES - HIGHLIGHT BED BUGS

code.violations <- read.csv("https://raw.githubusercontent.com/subartle/orangespot/master/data/code%20violations.csv")

lat.lon <- code.violations[ code.violations$Violation.Status == "Open" , c("lat","lon","Complaint.Type","Identifier") ]

lat.lon <- na.omit( lat.lon )

head( lat.lon )


 
# COMBINE CODE VIOLATIONS FOR EACH PROPERTY

dat <- NULL

for( i in unique(lat.lon$Identifier ) )
{
   temp <- lat.lon[ lat.lon$Identifier == i , ]
   
   first.row <- temp[1,]
   
   if( nrow(temp) > 1 )
   { 
      complaint.type <- paste( temp$Complaint.Type, collapse="; " ) 
      first.row$Complaint.Type <- complaint.type
   }

   first.row$Severity <- 10 + nrow(temp)
   
   dat <- rbind( dat, first.row )
   
}

write.csv( dat, "OpenViolations.csv" )



library( leaflet )

# READ IN DATA

violations <- read.csv( "https://raw.githubusercontent.com/lecy/maps-in-R/master/Data/OpenCodeViolations.csv" )


# COLOR CODE POINTS

syr.map <- leaflet(data=violations ) %>% 
     
            addProviderTiles("CartoDB.Positron", tileOptions(minZoom=10, maxZoom=17))  %>%
     
            setView(lng=-76.14, lat=43.05, zoom=14) %>%
     
            setMaxBounds(lng1=-75, lat1=41, lng2=-77,  lat2=45)
            
# highlight bed bugs

col.vec <- ifelse( grepl("Bed Bugs", violations$Complaint.Type, ignore.case=TRUE), "orange", NA )

addCircles( syr.map, lng = violations$lon, lat = violations$lat, popup = violations$Complaint.Type, 
            col=col.vec, radius=violations$Severity, fillColor="black", fillOpacity=0.5 )











# crimes <- read.csv( "https://raw.githubusercontent.com/lecy/hedonic-prices/master/Data/lat.long.csv" )
#
# addCircles( syr.map, lng = crimes$lon, lat = crimes$lat )





# addCircles( l, lng = lon, lat = lat, radius = 10, layerId = NULL, group = NULL,
# stroke = TRUE, color = "#03F", weight = 5, opacity = 0.5, fill = TRUE,
# fillColor = color, fillOpacity = 0.2, dashArray = NULL, popup = NULL,
# options = pathOptions(), data = getMapData(map))















