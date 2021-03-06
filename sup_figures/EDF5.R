# =======================================================================================================
# This is a script for generating EDF58: Percentage of samples left when filtering outliers.
#
# Note that the final figure was generated by using inkscape by combining figures from this script for visualization purposes
#
# =======================================================================================================



#!/bin/R


#  Read in input data

edf5a=read.table("EDF5a_data.txt", sep="\t", header=T)
edf5b=read.table("EDF5b_data.txt", sep="\t", header=T)



#Libraries
library(ggplot2)
library(cowplot)
library(RColorBrewer)
library(ggpubr)
library(forcats)

fsize=15
RD_theme=theme_classic()+
	theme(axis.text.x= element_text(size=fsize),
	axis.text.y= element_text(size=fsize), 
	axis.title = element_text(size = fsize), 
    legend.text = element_text(size = fsize-1), 
    legend.title = element_text(size = fsize), 
    axis.ticks = element_line(size = 0.1),
	strip.background=element_blank(),
	panel.grid.major=element_blank(),
	panel.grid.minor=element_blank(),
	axis.text=element_text(size=9),
	panel.border=element_blank()) 

# Panel A

color.function <- colorRampPalette( c( "#CCCCCC" , "#104E8B" ) )

color.ramp <- color.function( 3)
edf5a$filter=factor(edf5a$filter,levels=c("RV_10KB", "RV_10KB_CADD", "RV_10KB_HPO", "RV_10KB_CADD_HPO", "HPO", "EXP_OUTLIER", "EXP_OUTLIER_ASE", "EXP_OUTLIER_PLI", "EXP_OUTLIER_HPO","EXP_OUTLIER_RIVER", "EXP_OUTLIER_RV", "EXP_OUTLIER_RV_CADD", "EXP_OUTLIER_RV_CADD_HPO"))

edf5a$filter=fct_rev(edf5a$filter)

edf5a_plot=ggplot(edf5a, aes(x=filter, y=value, fill=variable)) + 
	geom_bar(stat="identity", position=position_dodge()) + 
	xlab("Filter")+ ylab("% samples with at least 1 candidate gene")+ RD_theme+ scale_fill_manual(values=color.ramp) +coord_flip()



# Panel B
edf5b$filter=fct_rev(edf5b$filter)

edf5b_plot=ggplot(edf5b, aes(x=filter, y=value, fill=variable)) + 
	geom_bar(stat="identity", position=position_dodge()) + 
	xlab("Filter")+ ylab("% samples with at least 1 candidate gene")+ RD_theme+ scale_fill_manual(values=color.ramp) +coord_flip()

## combined_plot


combined_plot=ggarrange(edf5a_plot, edf5b_plot, ncol=2, nrow=1, common.legend = TRUE, legend="bottom")
