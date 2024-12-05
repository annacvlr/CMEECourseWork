##Script following practical one of Introduction to Ecological and Evolutionary Data Science GIS


#packages that are required during the whole week are downloaded in this script
install.packages('openxlsx')
install.packages('ggplot2')
install.packages('gridExtra')
install.packages('dismo')
install.packages('ncf')          
install.packages('SpatialPack')  # Spatial clifford test
install.packages('spdep')        # Spatial dependence models
install.packages('spatialreg')   # Spatial regression using lags
install.packages('nlme')         # GLS models
install.packages('spgwr')        # Geographic weighted regression
install.packages('spmoran')      # Moran's I and Geary C
install.packages('landscapemetrics')
install.packages('vegan')
install.packages('geodata')


#packages are recalled here to be used in the script
library(terra)     # core raster GIS package
library(sf)        # core vector GIS package
library(units)     # used for precise unit conversion
library(geodata)   # Download and load functions for core datasets
library(openxlsx)  # Reading data from Excel files

#sf package handles coordinates spherically, this is turned off as some datasets have trouble with it 
sf_use_s2(FALSE)
#sf package will handle vector data 

#make population density map for British Isles 
pop_dens <- data.frame (
    n_km2 = c(260, 67, 151, 4500, 133),
    country = c('England', 'Scotland', 'Wales', 'London', 'Northern Ireland')
)
print(pop_dens)

#to create vector data - provide set of coordinates for points - use simple polygons to show the countries
# creating a matrix of pairs of coordinates forming edge of polygonb
# first and last coord need to be the same
scotland <- rbind(c(-5, 58.6), c(-3, 58.6), c(-4, 57.6),
                    c(-1.5, 57.6),  c(-2, 55.8), c(-3, 55), 
                  c(-5, 55), c(-6, 56), c(-5, 58.6))
england <- rbind(c(-2,55.8),c(0.5, 52.8), c(1.6, 52.8), 
                  c(0.7, 50.7), c(-5.7,50), c(-2.7, 51.5), 
                  c(-3, 53.4),c(-3, 55), c(-2,55.8))
wales <- rbind(c(-2.5, 51.3), c(-5.3,51.8), c(-4.5, 53.4),
                  c(-2.8, 53.4),  c(-2.5, 51.3))
ireland <- rbind(c(-10,51.5), c(-10, 54.2), c(-7.5, 55.3),
                  c(-5.9, 55.3), c(-5.9, 52.2), c(-10,51.5))

#convert to feature geometries (= simple coord sets w no projection info)
scotland <- st_polygon(list(scotland))
england <- st_polygon(list(england))
wales <- st_polygon(list(wales))
ireland <- st_polygon(list(ireland))

#put into simple feature column sfc - used to set coordinate reference system csr 
uk_eire_sfc <- st_sfc(wales, england, scotland, ireland, crs=4326)
plot(uk_eire_sfc, asp=1)

uk_eire_capitals <- data.frame(
    long = c(-0.1, -3.2, -3.2, -6.0, -6.25),
    lat = c(51.5, 51.5, 55.8, 54.6, 53.30), 
    name = c('London', 'Cardiff', 'Edinburgh', 'Belfast', 'Dublin')
)
uk_eire_capitals <- st_as_sf(uk_eire_capitals, coords=c('long', 'lat'), crs=4326)
print(uk_eire_capitals)

#vector geom operations
#do some geom operations - use buffer operation to create a polygon for london
st_pauls<- st_point(x=c(-0.098056, 51.513611))
london <- st_buffer(st_pauls, 0.25)
#remove london from England polygon - set differ popu densities for two regions 
england_no_london <- st_difference(england, london)
lengths(scotland) #lengths = number of components in polygon and how many points are in each component
lengths(england_no_london) 

wales <- st_difference(wales, england)
#intersection operation to seperate North Ire from Ireland. 
#create polugon that includes NIre and sticks out into sea 
ni_area <- st_polygon(list(cbind(x=c(-8.1, -6, -5, -6, -8.1), y = c(54.4, 56, 55, 54, 54.4))))

northern_ireland <- st_intersection(ireland, ni_area)
eire <- st_difference(ireland, ni_area)

uk_eire_sfc <- st_sfc(wales, england_no_london, scotland, london, northern_ireland, eire, crs=4326)
print(uk_eire_sfc)

#uk into a single feature
uk_country <- st_union(uk_eire_sfc[-6])
uk_country

#plot
par(mfrow = c(1,2), mar = c(3, 3, 1, 1))
plot(uk_eire_sfc, asp=1, col=rainbow(6))
plot(st_geometry(uk_eire_capitals), add=TRUE)
plot(uk_country, asp=1, col='lightblue')


#vector data and attributes <- data frame
#columns contain data for each location, each field is a geom column containing spatial data 
uk_eire_sf <- st_sf(name = c('Wales', 'England', 'Scotland', 'London', 'Northern Ireland', 'Eire' ), 
        geometry = uk_eire_sfc)
print(uk_eire_sf)

#an sf object has a simple plot method 
plot(uk_eire_sf['name'], asp=1)

uk_eire_sf$capital <- c('Cardiff', 'London', 'Edinburgh', NA, 'Belfast', 'Dublin')
print(uk_eire_sf)

#merge - add data to data frame by matcing data -- allows columns in two data frames that contain matching values
#by.x or by.y - which columns we match 
#default merge drops rows when it doesnt find matching data 
uk_eire_sf <- merge (uk_eire_sf, pop_dens, by.x = "name", by.y = "country", all.x = TRUE)
print(uk_eire_sf)

#spatial attributes of geom. 
uk_eire_centroids <- st_centroid(uk_eire_sf)
st_coordinates(uk_eire_centroids)

#area & length of a feature
uk_eire_sf$area <- st_area(uk_eire_sf)
uk_eire_sf$length <- st_length(st_cast(uk_eire_sf, 'MULTILINESTRING'))
print(uk_eire_sf)

#uk_eire_sf$area <- set_units(uk_eire_sf$area, 'kg')
uk_eire_sf$length <- as.numeric(uk_eire_sf$length)
st_distance(uk_eire_sf)
st_distance(uk_eire_centroids)

plot(uk_eire_sf['n_km2'], asp=1)
k_eire_sf$log_n_km2 <- log10(uk_eire_sf$n_km2)
plot(uk_eire_sf['log_n_km2'], asp=1, key.pos=4)
# Or you can have logarithimic labelling using logz
plot(uk_eire_sf['n_km2'], asp=1, logz=TRUE, key.pos=4)


#4326 is a code in EPSG database of spatial coord systems - shortcut for complicated set of parameters that define particular projection
#4326 is WSG84 - geo coord system widely used

#reprojection is differ - transform data from one set of coord to another 
#used to convert from a geo coord system w units in degrees to a projected coordinate syst w linear units 
#proj coord systems are trade off btw conserving distance, shape, area, bearings & is important to pick one appropiate to your area or analysis 

#Bri Nat grid
uk_eire_BNG <- st_transform(uk_eire_sf, 27700)
uk_eire_UTM50N <- st_transform(uk_eire_sf, 32650)
st_bbox(uk_eire_sf)
st_bbox(uk_eire_BNG)

par(mfrow = c(1,3), mar = c(3, 3, 1, 1))
plot(st_geometry(uk_eire_sf), asp=1, axes=TRUE, main= "WGS 84")
plot(st_geometry(uk_eire_BNG), axes = TRUE, main = "OSGB 1936 / BNG")
plot(st_geometry(uk_eire_UTM50N), axes = TRUE, main = "UTM 50N")


#prj4 strings 

#degrees not constant - 0.25deg buffered point for london is a poor choice - it is distorted in BNG map 
#london lat - deg long is 69km and degree lat is 111km 
#st_distance is noting that we have geog coord and is returning great circle distances in meters

st_pauls <- st_sfc(st_pauls, crs= 4326)
one_deg_west_pt <- st_sfc(st_pauls - c(1,0), crs=4326) #near goring
one_deg_north_pt <- st_sfc(st_pauls + c(0,1), crs = 4326)
#calc distance btw st pauls and each point
st_distance(st_pauls, one_deg_west_pt)

st_distance(st_transform(st_pauls, 27700), 
    st_transform(one_deg_west_pt, 27700))

london_bng <- st_buffer(st_transform(st_pauls, 27700), 25000)
england_not_london_bng <- st_difference(st_transform(st_sfc(england, crs=4326), 27700), london_bng)
others_bng <- st_transform(st_sfc(eire, northern_ireland, scotland, wales, crs = 4326), 27700)
corrected <- c(others_bng, london_bng, england_not_london_bng)

par(mar = c(3, 3, 1, 1))
plot(corrected, main = "25km radius London", axes = TRUE)


####RASTERS####
#spatial data type 
#regular grid space, defined by coordinate system on an origin point, resolution and number of rows and columns
#hold matrix of data

#build raster from scratch, set projection, bounds, resolution
#terra package needs EPSG:4326 (not only code)
uk_raster_WGS84 <- rast(xmin = -11, xmax = 2, ymin = 49.5, ymax = 59, 
                    res = 0.5, crs = "EPSG:4326")
hasValues(uk_raster_WGS84)

#add data
values(uk_raster_WGS84) <- cells(uk_raster_WGS84)
print(uk_raster_WGS84)

plot(uk_raster_WGS84)
plot(st_geometry(uk_eire_sf), add = TRUE, border = "black", lwd = 2, col = "#FFFFFF44")

#changing raster resolution - to have finer resolution 
#useful to make differ data sources have same resolution for an analysis

m <- matrix(c(1, 1, 3, 3,
              1, 2, 4, 3,
              5, 5, 7, 8,
              6, 6, 7, 7), ncol=4, byrow=TRUE)
square <- rast(m)

plot(square, legend=NULL)
text(square, digits=2)

#aggregating rasters 

#avg values
square_agg_mean <- aggregate(square, fact = 2, fun = mean)
plot(square_agg_mean, legend = NULL)
text(square_agg_mean, digits = 2)

#max values
square_agg_max <- aggregate(square, fact = 2, fun = max)
plot(square_agg_max, legend = NULL)
text(square_agg_max, digits = 2)

#modal values for categories 
square_agg_modal <- aggregate( square, fact = 2, fun = "modal")
plot(square_agg_modal, legend= NULL)
text(square_agg_modal, digits = 2)

#diaggregating rasters - requires a factor 
#duplicate nearest parent value 
square_disagg <-disagg(square, fact=2, method = "near")
plot(square_disagg, legend = NULL)
text(square_disagg, digits = 2)

#interpolate between the values to provide a smoother gradient between cells - does not make sense for categorical variable 
#bilinear interpolation
square_interp <- disagg(square, fact = 2, method = "bilinear")
plot(square_interp, legend = NULL)
text(square_interp, digits = 1 )

#reprojecting a raster - series of raster cell values in 1 projection and then want to insert representative values into a set of cells on a differ projection
# we can create vector grids to represent cell edges in the two raster grids so we can overplot them 


#make 2 sfc objects - in lower left and top right of 2 grids
uk_pts_WSG84 <- st_sfc(st_point(c(-11, 49.5)), st_point(c(2, 59)), crs= 4326)
uk_pts_BNG <- st_sfc(st_point(c(-2e5, 0)), st_point(c(7e5, 1e6)), crs = 27700)

#st_make_grid - create polygon w right cellsize
uk_grid_WGS84 <- st_make_grid(uk_pts_WSG84, cellsize=0.5)
uk_grid_BNG <- st_make_grid(uk_pts_BNG, cellsize = 1e5)

#reproject BNG grid into WGS84
uk_grid_BNG_as_WGS84 <- st_transform(uk_grid_BNG, 4326)

#plot 
par(mar = c(0, 0, 0, 0))
plot(uk_grid_WGS84, asp=1, border = "grey", xlim = c(-13, 4))
plot(st_geometry(uk_eire_sf), add = TRUE, border = "darkgreen", lwd = 2)
plot(uk_grid_BNG_as_WGS84, border = "red", add = TRUE)

#use project function - gives choice or interpolating a representative valuye from source data (method = bilinear) 
#or picking the cell value from the nearest neighbour to the new cell celtre (method = near) 

#create a target raster without data to use as template for reprojected data
uk_raster_BNG <- rast(xmin = -200000, xmax = 700000, ymin= 0, ymax = 1000000, 
            res = 100000, crs = "+init=EPSG:27700")
uk_raster_BNG_interp <- project(uk_raster_WGS84, uk_raster_BNG, method = "bilinear")
uk_raster_BNG_near <- project(uk_raster_WGS84, uk_raster_BNG, method = "near")

par(mfrow = c(1,2), mar = c(0,0,0,0))
plot(uk_raster_BNG_interp, main = "Interpolated", axes = FALSE, legend = FALSE)
text(uk_raster_BNG_interp, digit = 1)
plot(uk_raster_BNG_near, main = "Nearest Neighbour", axes = FALSE, legend = FALSE)
text(uk_raster_BNG_near)



###converting btw vector and raster data types##
#provide target raster and vector data - put it thru rasterize function 
#a vector attribute is chosen to assign cell values to their raster 
        # Point : if a point falls anywhere within a cell - that value is assigned to the cell
        # Linestring : if any part of the linestring falls within a cell - that value is assigned to cell
        # Polygon : if teh center of the cell falls within a polygon - the value from polygon is assigned to the cell
# fun assignment - allows you to set rules to decide which value wins (cell might have more than 1 possible value)

uk_20km <- rast(xmin = -200000, xmax = 650000, ymin= 0, ymax = 1000000, 
        res = 20000, crs="+init=EPSG:27700")
uk_eire_poly_20km <- rasterize(uk_eire_BNG, uk_20km, field = "name")
plot(uk_eire_poly_20km)

#you can represent bundary lines and polygon vertices as raster data - recasy polygon data 
# sp rasterisation process knows to treat the data differently - list of polygon veritces form a linear feature or set of points (( no longer as a closed loop -polygon))
#st_agr function to tell sf that attributes are constant - stop warnings
uk_eire_BNG$name <- as.factor(uk_eire_BNG$name)
st_agr(uk_eire_BNG) <- "constant"

#rasterizing lines
uk_eire_BNG_line <- st_cast(uk_eire_BNG, "LINESTRING")
uk_eire_line_20km <- rasterize(uk_eire_BNG_line, uk_20km, field = "name")
#rasterizing points 
#polygon > multipoint > point
uk_eire_BNG_point <- st_cast(st_cast(uk_eire_BNG, "MULTIPOINT"), "POINT")
uk_eire_point_20km <- rasterize(uk_eire_BNG_point, uk_20km, field = "name")

#plot differ outcomes 
color_palette <- hcl.colors(6, palette = "viridis", alpha = 0.5) # function to create nice plotting palette color

#plot raster 
par(mfrow = c(1,3), mar = c(1,1,1,1))
plot(uk_eire_poly_20km, col = color_palette, legend = FALSE, axes = FALSE)
plot(st_geometry(uk_eire_BNG), add = TRUE, border = "red")


plot(uk_eire_line_20km, col=color_palette, legend=FALSE, axes=FALSE)
plot(st_geometry(uk_eire_BNG), add=TRUE, border='red')

plot(uk_eire_point_20km, col=color_palette, legend=FALSE, axes=FALSE)
plot(st_geometry(uk_eire_BNG), add=TRUE, border='red')

# for polygons | cells included if cell in the polygon
# for lines    | cells included if the line touches the cell


#converting raster to vector 
# raster cell can be a polygon w value representing whole cell OR point w the valye representing the value at a specific location
# terra package - provides functions to handle both - for polygons youc an decide whether to dissolve cells w identical values into larger polygons or leave them all as individual cells 
#na.rm removes NA

poly_from_rast <- as.polygons(uk_eire_poly_20km, na.rm = FALSE) #get set of dissolved polygons including NA cells
cells_from_rast <- as.polygons(uk_eire_poly_20km, dissolve = FALSE) #get individual cells ( no dissolving )
points_from_rast <- as.points(uk_eire_poly_20km) #get indiv. points

#dissolved polygons have the original 6 features + new feature for NA values 
#undissolved polygons & points both have 817 features - one for each grid cell in rater w/out NA value
print(st_as_sf(poly_from_rast))
print(st_as_sf(cells_from_rast))
print(st_as_sf(points_from_rast))

#plot
par(mfrow = c(1,3), mar = c(1,1,1,1))
plot(poly_from_rast, key.pos = NULL)
plot(cells_from_rast, key.pos = NULL)
plot(points_from_rast, key.pos = NULL, pch = 4)



#uk_eire_sf$area <- as.numeric(uk_eire_sf$area)


###using data in files####
#  st_read  | sf    | reads most vector data
#  rast     | terra | reads most raster data 

#saving vector data into shapefile w st_write from sf
st_write(uk_eire_sf, "../data/uk/uk_eire_WGS84.shp")
st_write(uk_eire_BNG, '../data/uk/uk_eire_BNG.shp')

st_write(uk_eire_sf, '../data/uk/uk_eire_WGS84.geojson')
st_write(uk_eire_sf, '../data/uk/uk_eire_WGS84.gpkg')
#GeoJSON stopres coordinates and attributes in a single text file - technically guman readable but need to be familiar w JSON 
# GeoPackage stores vector data into a single SQLite3 database file. Various tabs in file hold info on data 

st_write(uk_eire_sf, '../data/uk/uk_eire_WGS84.json', driver='GeoJSON')


#saving raster data 
#GeoTIFF file format is one of most common GIS raster data formats - sma eas TIFF image file w/ embedded data describing origin, resolution, coordinate reference system of dtaa 
#you may also see a .tfw file - word file that contains same info and you should keep it w TIFF file 

# writeRaster  | terra | to save raster data 
writeRaster(uk_raster_BNG_interp, '../data/uk/uk_raster_BNG_interp.tif')
writeRaster(uk_raster_BNG_near, '../data/uk/uk_raster_BNG_ngb.asc', filetype='AAIGrid')

#loading vector data 
ne_110 <- st_read("../data/practical_data/ne_110m_admin_0_countries/ne_110m_admin_0_countries.shp") #ne_110m_admin_0_countries
life_exp <- read.csv (file = "../data/practical_data/WHOSIS_000001.csv")

plot(ne_110["GDP_MD"], asp = 1, main = "global GDP", logz = TRUE, key.pos = 4)
#then merge data 
ne_110 <- merge(ne_110, life_exp, by.x="ISO_A3_EH", by.y = "COUNTRY", all.x = TRUE)
#create sequence of break values to use for display 
bks <- seq (50, 85, by=0.25)
plot(ne_110['Numeric'], asp=1, main='Global 2016 Life Expectancy (Both sexes)',
      breaks=bks, pal=hcl.colors, key.pos=4)

#loading XY data 
so_data <- read.csv ("../data/practical_data/Southern_Ocean.csv", header = TRUE)
so_data <- st_as_sf(so_data, coords = c("long", "lat"), crs =4326)
print(so_data)


#loading raster data 
etopo_25 <- rast("../data/practical_data/etopo_25.tif")
print(etopo_25)
plot(etopo_25, plg = list(ext = c(190, 210, -90, 90)))

#to have useful colour scheme 
#set breaks, provide 2 colors, function colorRampPalette 
# need to set plot type = "continuous" 
#plg argument sets the extent of legend box - uses same coord system as map 
breaks <- seq(-10000, 6000, by = 250)
land_cols <- terrain.colors(24)
sea_pal <- colorRampPalette(c("darkslateblue", "steelblue", "paleturquoise"))
sea_cols <- sea_pal(40)
plot(etopo_25, axes = FALSE, breaks = breaks, col = c(sea_cols, land_cols), type = "continuous", plg = list(ext = c(190, 200, -90, 90)))


#raster stacks 
# raster data has multiple bands - single file can have layers of info for cells in rater grid 
#geodata package - get data w monthly data bands 
tmax <- worldclim_global(var = "tmax", res = 10, path = "../data")
print(tmax)

tmax_jan <- tmax[[1]]
tmax_jul <- tmax[[7]]
tmax_max <- max(tmax)

par(mfrow=c(2,2), mar=c(2,2,1,1))
bks <- seq(-50, 50, length=101)
pal <- colorRampPalette(c('lightblue','grey', 'firebrick'))
cols <- pal(100)
plg <- list(ext=c(190, 200, -90, 90))

plot(tmax_jan, col=cols, breaks=bks, 
     main='January maximum temperature', type='continuous', plg=plg)
plot(tmax_jul, col=cols, breaks=bks, 
     main='July maximum temperature', type='continuous', plg=plg)
plot(tmax_max, col=cols, breaks=bks, 
     main='Annual maximum temperature', type='continuous', plg=plg)



###overlaying raster and vector data####
