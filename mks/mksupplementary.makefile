# #######################
# mksuppfigures.makefile
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #######################

include mks/mkdefs.makefile
include mks/mkparams.makefile

# Set of rules for plotting supplementary figures and tables

fig1:
	@if [ -a fig/supp/supplementary_figure_1.svg ]; then echo "[LOG]   Supplementary figure 1 exist"; fi
	@if [ -a fig/supp/supplementary_figure_1.svg ]; then :; else echo "[LOG]   Plotting supplementary figure 1"; fi

fig2:
	@mkdir -p fig
	@mkdir -p fig/supp
	@if [ -a fig/supp/supplementary_figure_2.svg ]; then echo "[LOG]   Supplementary Figure 2 exist"; fi
	@if [ -a fig/supp/supplementary_figure_2.svg ]; then :; else echo "[LOG]   Plotting Supplementary Figure 2"; fi
	@if [ -a fig/supp/supplementary_figure_2.svg ]; then :; else mkdir -p tmp; fi
	@if [ -a fig/supp/supplementary_figure_2.svg ]; then :; else $(perlbin) src/plt/supp/supplementary_figure_2.pl > tmp/inputR.tab; fi
	@if [ -a fig/supp/supplementary_figure_2.svg ]; then :; else $(rbin) --vanilla --args tmp/inputR.tab fig/supp/supplementary_figure_2.svg < src/plt/supp/supplementary_figure_2.R > /dev/null; fi
	@if [ -a fig/supp/supplementary_figure_2.svg ]; then :; else rm -rf tmp; fi

fig3:
	@if [ -a fig/supp/supplementary_figure_3.svg ]; then echo "[LOG]   Supplementary figure 3 exist"; fi
	@if [ -a fig/supp/supplementary_figure_3.svg ]; then :; else echo "[LOG]   Plotting supplementary figure 3"; fi
	@if [ -a fig/supp/supplementary_figure_3.svg ]; then :; else mkdir -p tmp; fi
	@if [ -a fig/supp/supplementary_figure_3.svg ]; then :; else $(perlbin) src/plt/supp/supplementary_figure_3.pl dfp/normalvstumour/diffprofiles.dat dat/li_ratios_mirnas.bed > tmp/inputR.tab; fi
	@if [ -a fig/supp/supplementary_figure_3.svg ]; then :; else $(rbin) --vanilla --args tmp/inputR.tab fig/supp/supplementary_figure_3.svg < src/plt/supp/supplementary_figure_3.R > /dev/null; fi
	@if [ -a fig/supp/supplementary_figure_3.svg ]; then :; else rm -rf tmp; fi

fig4:
	@if [ -a fig/supp/supplementary_figure_4.svg ]; then echo "[LOG]   Supplementary figure 4 exist"; fi
	@if [ -a fig/supp/supplementary_figure_4.svg ]; then :; else echo "[LOG]   Plotting supplementary figure 4"; fi

fig5:
	@mkdir -p fig
	@mkdir -p fig/supp
	@if [ -a fig/supp/supplementary_figure_5.svg ]; then echo "[LOG]   Supplementary Figure 5 exists"; fi
	@if [ -a fig/supp/supplementary_figure_5.svg ]; then :; else echo "[LOG]   Plotting Supplementary Figure 5"; fi
	@if [ -a fig/supp/supplementary_figure_5.svg ]; then :; else mkdir -p tmp; fi
	@if [ -a fig/supp/supplementary_figure_5.svg ]; then :; else $(perlbin) src/plt/supp/supplementary_figure_5.pl dat/serpent_annotation_novel.bed > tmp/inputR.tab; fi
	@if [ -a fig/supp/supplementary_figure_5.svg ]; then :; else $(rbin) --vanilla --args tmp/inputR.tab fig/supp/supplementary_figure_5.svg < src/plt/supp/supplementary_figure_5.R > /dev/null; fi
	@if [ -a fig/supp/supplementary_figure_5.svg ]; then :; else rm -rf tmp; fi

fig6:
	@if [ -a fig/supp/supplementary_figure_6.svg ]; then echo "[LOG]   Supplementary figure 6 exist"; fi
	@if [ -a fig/supp/supplementary_figure_6.svg ]; then :; else echo "[LOG]   Plotting supplementary figure 6"; fi

fig7:
	@mkdir -p fig
	@mkdir -p fig/supp
	@mkdir -p fig/supp/parts
	@if [ -a fig/supp/supplementary_figure_6.svg ]; then echo "[LOG]   Supplementary Figure 7 exists"; fi
	@if [ -a fig/supp/supplementary_figure_6.svg ]; then :; else echo "[LOG]   Plotting Supplementary Figure 7"; fi
	@if [ -a fig/supp/supplementary_figure_6.svg ]; then :; else mkdir -p tmp; fi
	@if [ -a fig/supp/supplementary_figure_6.svg ]; then :; else $(perlbin) src/plt/supp/supplementary_figure_6.pl dat/dicer/serpent_annotation_extended.deseq $(mkvalidation_pval) > tmp/inputR.tab; fi
	@if [ -a fig/supp/supplementary_figure_6.svg ]; then :; else $(rbin) --vanilla --args tmp/inputR.tab fig/supp/parts/supplementary_figure_7 $(mkvalidation_pval) < src/plt/supp/supplementary_figure_6.R > /dev/null; fi
	@if [ -a fig/supp/supplementary_figure_6.svg ]; then :; else rm -rf tmp; fi

fig8:
	@if [ -a fig/supp/supplementary_figure_8.svg ]; then echo "[LOG]   Supplementary Figure 8 exists"; fi
	@if [ -a fig/supp/supplementary_figure_8.svg ]; then :; else echo "[LOG]   Plotting Supplementary Figure 8"; fi
	@if [ -a fig/supp/supplementary_figure_8.svg ]; then :; else mkdir -p tmp; fi
	@if [ -a fig/supp/supplementary_figure_8.svg ]; then :; else $(perlbin) src/plt/supp/supplementary_figure_6.pl dat/drosha/serpent_annotation_extended.deseq $(mkvalidation_pval) > tmp/inputR.tab; fi
	@if [ -a fig/supp/supplementary_figure_8.svg ]; then :; else $(rbin) --vanilla --args tmp/inputR.tab fig/supp/parts/supplementary_figure_8 $(mkvalidation_pval) < src/plt/supp/supplementary_figure_6.R > /dev/null; fi
	@if [ -a fig/supp/supplementary_figure_8.svg ]; then :; else rm -rf tmp; fi

fig9:
	@if [ -a fig/supp/supplementary_figure_9.svg ]; then echo "[LOG]   Supplementary Figure 9 exists"; fi
	@if [ -a fig/supp/supplementary_figure_9.svg ]; then :; else echo "[LOG]   Plotting Supplementary Figure 8"; fi
	@if [ -a fig/supp/supplementary_figure_9.svg ]; then :; else mkdir -p tmp; fi
	@if [ -a fig/supp/supplementary_figure_9.svg ]; then :; else $(perlbin) src/plt/supp/supplementary_figure_6.pl dat/exportin/serpent_annotation_extended.deseq $(mkvalidation_pval) > tmp/inputR.tab; fi
	@if [ -a fig/supp/supplementary_figure_9.svg ]; then :; else $(rbin) --vanilla --args tmp/inputR.tab fig/supp/parts/supplementary_figure_9 $(mkvalidation_pval) < src/plt/supp/supplementary_figure_6.R > /dev/null; fi
	@if [ -a fig/supp/supplementary_figure_9.svg ]; then :; else rm -rf tmp; fi

fig10:
	@if [ -a fig/supp/supplementary_figure_9.svg ]; then echo "[LOG]   Supplementary figure 9 exist"; fi
	@if [ -a fig/supp/supplementary_figure_9.svg ]; then :; else echo "[LOG]   Plotting supplementary figure 9"; fi

fig11:
	@if [ -a fig/supp/supplementary_figure_10.svg ]; then echo "[LOG]   Supplementary figure 10 exist"; fi
	@if [ -a fig/supp/supplementary_figure_10.svg ]; then :; else echo "[LOG]   Plotting supplementary figure 10"; fi
	
tab1:
	@mkdir -p fig
	@mkdir -p fig/supp
	@if [ -a fig/supp/supplementary_table_1.tab ]; then echo "[LOG]   Supplementary Table 1 exist"; fi
	@if [ -a fig/supp/supplementary_table_1.tab ]; then :; else echo "[LOG]   Generating Supplementary Table 1"; fi
	@if [ -a fig/supp/supplementary_table_1.tab ]; then :; else $(perlbin) src/plt/supp/supplementary_table_1.pl > fig/supp/supplementary_table_1.tab; fi

tab2:
	@mkdir -p fig
	@mkdir -p fig/supp
	@if [ -a fig/supp/supplementary_table_2.tab ]; then echo "[LOG]   Supplementary Table 2 exist"; fi
	@if [ -a fig/supp/supplementary_table_2.tab ]; then :; else echo "[LOG]   Generating Supplementary Table 2"; fi
	@if [ -a fig/supp/supplementary_table_2.tab ]; then :; else $(perlbin) src/plt/supp/supplementary_table_2.pl lines > fig/supp/supplementary_table_2.tab; fi

tab3:
	@mkdir -p fig
	@mkdir -p fig/supp
	@if [ -a fig/supp/supplementary_table_3.tab ]; then echo "[LOG]   Supplementary Table 3 exist"; fi
	@if [ -a fig/supp/supplementary_table_3.tab ]; then :; else echo "[LOG]   Generating Supplementary Table 3"; fi
	@if [ -a fig/supp/supplementary_table_3.tab ]; then :; else $(perlbin) src/plt/supp/supplementary_table_3.pl lines > fig/supp/supplementary_table_3.tab; fi

tab4:
	@mkdir -p fig
	@mkdir -p fig/supp
	@if [ -a fig/supp/supplementary_table_4.tab ]; then echo "[LOG]   Supplementary Table 4 exist"; fi
	@if [ -a fig/supp/supplementary_table_4.tab ]; then :; else echo "[LOG]   Generating Supplementary Table 4"; fi
	@if [ -a fig/supp/supplementary_table_4.tab ]; then :; else $(perlbin) src/plt/supp/supplementary_table_4.pl lines > fig/supp/supplementary_table_4.tab; fi

tab5:
	@mkdir -p fig
	@mkdir -p fig/supp
	@if [ -a fig/supp/supplementary_table_5.tab ]; then echo "[LOG]   Supplementary Table 5 exist"; fi
	@if [ -a fig/supp/supplementary_table_5.tab ]; then :; else echo "[LOG]   Generating supplementary Table 5"; fi
	@if [ -a fig/supp/supplementary_table_5.tab ]; then :; else $(perlbin) src/plt/supp/supplementary_table_5.pl compartments > fig/supp/supplementary_table_5.tab; fi

tab6:
	@mkdir -p fig
	@mkdir -p fig/supp
	@if [ -a fig/supp/supplementary_table_6.tab ]; then echo "[LOG]   Supplementary Table 6 exist"; fi
	@if [ -a fig/supp/supplementary_table_6.tab ]; then :; else echo "[LOG]   Generating supplementary Table 6"; fi
	@if [ -a fig/supp/supplementary_table_6.tab ]; then :; else $(perlbin) src/plt/supp/supplementary_table_6.pl > fig/supp/supplementary_table_6.tab; fi

dat1:
	@mkdir -p fig
	@mkdir -p fig/supp
	@if [ -a fig/supp/supplementary_data_1.tab ]; then echo "[LOG]   Supplementary Data 1 exist"; fi
	@if [ -a fig/supp/supplementary_data_1.tab ]; then :; else echo "[LOG]   Generating Supplementary Data 1"; fi
	@if [ -a fig/supp/supplementary_data_1.tab ]; then :; else $(perlbin) src/plt/supp/supplementary_data_1.pl dat/serpent_annotation_novel.bed dat/friedlander_micrornas_annotation.bed dat/dashr_sncrna_annotation.bed dat/serpent_annotation_novel.hits $(suppdat1_pvalue) > fig/supp/supplementary_data_1.tab; fi

dat2:
	@mkdir -p fig
	@mkdir -p fig/supp
	@if [ -a fig/supp/supplementary_data_2.gtf ]; then echo "[LOG]   Supplementary Data 2 exist"; fi
	@if [ -a fig/supp/supplementary_data_2.gtf ]; then :; else echo "[LOG]   Generating Supplementary Data 2"; fi
	@if [ -a fig/supp/supplementary_data_2.gtf ]; then :; else $(perlbin) src/plt/supp/supplementary_data_2.pl dat/serpent_annotation_extended.bed > fig/supp/supplementary_data_2.gtf; fi

dat3:
	@mkdir -p fig
	@mkdir -p fig/supp
	@if [ -a fig/supp/supplementary_data_3.tab ]; then echo "[LOG]   Supplementary Data 3 exist"; fi
	@if [ -a fig/supp/supplementary_data_3.tab ]; then :; else echo "[LOG]   Generating Supplementary Data 3"; fi
	@if [ -a fig/supp/supplementary_data_3.tab ]; then :; else $(perlbin) src/plt/supp/supplementary_data_3.pl 2.5 > fig/supp/supplementary_data_3.tab; fi
