capture log close

/*==================================================
project:       November 4, 2022. Day 4 of 30 Day Map Challenge
			   Color Friday: Green
Author:        Daria Kuznetsova 
E-email:       
url:           https://github.com/daria-kuznetsova

----------------------------------------------------
Creation Date:     Nov 4, 2022
Modification Date:  
Do-file version:   01

References:    	   
1. World Bank Development Indicators
2. World map shapefiles: World Bank, World Country Polygons - Very High Definition 
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


graph set window fontface "Bahnschrift Light Condensed"

use energy.dta, clear

colorpalette RdYlGn, n(9) nograph
local colors `r(p)'

spmap energy_consump using "../world_shapefiles/world_shp2.dta" if year == 2019, id(_ID) ///
	clm(custom) clb(0 6 12.5 25 37.5 50 62.5 75 87.5 100) ///
	fcolor("`colors'") 	///
	ndocolor(gs5) ndsize(0.05) ndpattern(solid)  ///
	legstyle(2)	legend(pos(7) size(2.5) region(fcolor(gs4)) color(white)) ///
	ocolor(gs4 ..) osize(0.05 ..)	///
	title("Renewable energy consumption (% of total final energy consumption), 2019", ///
	size(12pt) color(white)) ///
	ndfcolor(gs14) ///
	graphregion(fcolor(gs4) color(gs4))  plotregion(fcolor(gs4) color(gs4)) ///
	note("Source: World Bank Development Indicators. By Daria Kuznetsova", size(6.5pt) color(white))
	
graph export energy_consumption.png, replace

exit

* end of do.file