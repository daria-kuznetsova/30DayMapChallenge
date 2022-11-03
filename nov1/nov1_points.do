capture log close

/*==================================================
project:       November 1st, 2022. Day 1 of 30 Day Map Challenge
			   Point maps
Author:        Daria Kuznetsova 
E-email:       
url:           https://github.com/daria-kuznetsova

----------------------------------------------------
Creation Date:     Nov 1, 2022
Modification Date:  
Do-file version:   01

References:    	   
1. internet shutdowns: https://www.top10vpn.com/research/cost-of-internet-shutdowns/2021/
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

*cd "C:\Users\Daria\Documents\UIOWA\30daymap\nov1"

/*==================================================
              1: Mapping
==================================================*/

* set scheme and font 
set scheme cleanplots
graph set window fontface "Arial Narrow"

* open dataset
use internet_shutdowns.dta, clear

* create additional variables for a legend 	 
gen scatter_v = 1
gen duration_v = .
. replace duration_v = 5 in 1
. replace duration_v = 1000 in 2
. replace duration_v = 5000 in 3
. replace duration_v = 7500 in 4
. replace duration_v = 12200 in 5

* plot legend and save as a separate plot
twoway scatter duration_v scatter_v [w = duration_v], msymbol(O) ///
mfcolor(cyan%40) mlcolor(none) || /// /* scatterplot for circles */
scatter duration_v scatter_v, /// /* a separate scatterplot for labels */
mlabposition(3) xscale(off) yscale(off) xscale(range(0 0.5)) ylabel(,nogrid) ///
xlabel(,nogrid) msymbol(none) mlabel(duration_v) mlabgap(vlarge) mlabsize(4pt) mlabcolor(white) legend(off) ///
scale(1.25) aspectratio(1.25) fxsize(20) /// /*set how much space we want to designate for the legend */
graphregion(fcolor(black) color(black))  plotregion(fcolor(black) color(black)) ///
title("Duration of shutdows, hours", size(6pt) color(white)) ///
saving(legend, replace)

* plot map
spmap using "../world_shapefiles/world_shp2.dta", ///
id(_ID) ///
point(data("internet_shutdowns.dta") xcoord(_CX) ycoord(_CY) ///
proportional(duration_hrs) size(medium) fcolor(cyan%40) ocolor(pink%0) shape(O ..))  ///
label(xcoord(_CX) ycoord(_CY) label(country_name) size(4.2pt) ///
gap(1pt) position(12) color(white)) ///
fcolor(gs8) ndocolor(gs5) ndsize(0.05) ndpattern(solid) ///
ocolor(gs5 ..) osize(0.025 ..) ///
graphregion(fcolor(black) color(black))  plotregion(fcolor(black) color(black)) ///
saving(map, replace)

* combine together
graph combine "legend.gph" "map.gph", ///
cols(2) xsize(6.5) ysize(4) iscale(0.85) ///
title("Location and duration of internet shutdowns in 2021", size(8pt) color(white)) ///
graphregion(fcolor(black)) ///
note("Source: Top10VPN.com accessed @ https://www.top10vpn.com/research/cost-of-internet-shutdowns/2021", size(5.5pt) color(white))

graph export "internet_shutdowns.png", replace width(1000)

exit

* end of do.file