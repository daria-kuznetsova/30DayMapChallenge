capture log close

/*==================================================
project:       November 3rd, 2022. Day 3 of 30 Day Map Challenge
			   Polygons maps
Author:        Daria Kuznetsova 
E-email:       
url:           https://github.com/daria-kuznetsova

----------------------------------------------------
Creation Date:     Nov 3, 2022
Modification Date:  
Do-file version:   01

References:    	   
1. 
2. world map shapefiles: World Bank, World Country Polygons - Very High Definition 
accessed at https://datacatalog.worldbank.org/search/dataset/0038272/World-Bank-Official-Boundaries

Map projection:
map projection is web mercator

Dependencies: spmap, cleanplots
To install: 
net install cleanplots, from("https://tdmize.github.io/data/cleanplots")
ssc install spmap

Input: 			     
Output:             
==================================================*/

/*==================================================
              0: Program set up
==================================================*/
version 17
drop _all

/*==================================================
              1: Mapping
==================================================*/

set scheme cleanplots
graph set window fontface "Arial Narrow"

use data.dta, clear

* interpolate some missing values 
mipolate internet year, generate(internet2) nearest by(countryname)
order internet2, after(internet)

* map of internet penetration rates
graph drop _all

forvalues i = 1990(1)2020 {
	
colorpalette plasma, n(9) nograph reverse	 
local colors `r(p)'

spmap internet using "../world_shapefiles/world_shp2.dta" if year == `i', id(_ID) ///
	clm(custom) clb(0 6 12.5 25 37.5 50 62.5 75 87.5 100) ///
	fcolor("`colors'") 	///
	ndocolor(gs5) ndsize(0.05) ndpattern(solid)  ///
	legstyle(2)	legend(pos(7) size(2.5) region(fcolor(gs15))) ///
	ocolor(black ..) osize(0.05 ..)	///
	title("Internet penetration" "`i'", size(9pt)) ///
	ndfcolor(gs14) ///
	note("Source: World Bank Development Indicators. Missing values are interpolated via nearest neighbour interpolation.", size(6pt))
	
	graph export `i'.png, replace
}

* combine png's into a single gif (I used a free online service)

exit

* end of do.file