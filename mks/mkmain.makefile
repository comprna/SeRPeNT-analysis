# #######################
# mkmain.makefile
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #######################

include mks/mkdefs.makefile
include mks/mkparams.makefile

# Set of rules for plotting main figures

fig1:
	@if [ -a fig/main/figure_1.svg ]; then echo "[LOG]   Figure 1 exist"; fi
	@if [ -a fig/main/figure_1.svg ]; then :; else echo "[LOG]   Plotting figure 1"; fi

fig2a:
	@mkdir -p fig
	@mkdir -p fig/main
	@mkdir -p tmp
	@if [ -a fig/main/figure_2a.svg ]; then echo "[LOG]   Figure 2a exist"; fi
	@if [ -a fig/main/figure_2a.svg ]; then :; else echo "[LOG]   Plotting Figure 2a"; fi
	@if [ -a fig/main/figure_2a.svg ]; then :; else $(perlbin) src/plt/main/figure_2a.pl lines > tmp/inputR.tab; fi
	@if [ -a fig/main/figure_2a.svg ]; then :; else $(rbin) --vanilla --args tmp/inputR.tab fig/main/figure_2a.svg < src/plt/main/figure_2a.R > /dev/null; fi
	@rm -rf tmp

fig2b:
	@mkdir -p fig
	@mkdir -p fig/main
	@mkdir -p tmp
	@if [ -a fig/main/figure_2b.svg ]; then echo "[LOG]   Figure 2b exist"; fi
	@if [ -a fig/main/figure_2b.svg ]; then :; else echo "[LOG]   Plotting figure 2b"; fi
	@if [ -a fig/main/figure_2b.svg ]; then :; else $(perlbin) src/plt/main/figure_2b.pl $(mainfig2_sample) > tmp/inputR.tab; fi
	@if [ -a fig/main/figure_2b.svg ]; then :; else $(rbin) --vanilla --args tmp/inputR.tab tmp/input.neWick < src/plt/main/figure_2b.R > /dev/null; fi
	@if [ -a fig/main/figure_2b.svg ]; then :; else $(pythonbin) src/d3/convert_newick_json.py tmp/input.neWick > tmp/clusters.json; fi
	@if [ -a fig/main/figure_2b.svg ]; then :; else $(perlbin) src/d3/transform_json_annotation.pl tmp/clusters.json dat/$(mainfig2_sample)/annotation.bed > tmp/flare.json; fi
	@if [ -a fig/main/figure_2b.svg ]; then :; else cp src/d3/index.html tmp/index.html; fi
	@if [ -a fig/main/figure_2b.svg ]; then :; else cp src/d3/index_old.html tmp/index_old.html; fi
	@if [ -a fig/main/figure_2b.svg ]; then :; else echo "1. Open file 'tmp/index_old.html' with browser"; fi
	@if [ -a fig/main/figure_2b.svg ]; then :; else echo "2. Press 'Save as SVG' button"; fi
	@if [ -a fig/main/figure_2b.svg ]; then :; else echo "3. Save file as 'tmp/index_old.svg'"; fi
	@if [ -a fig/main/figure_2b.svg ]; then :; else read -p "Press any key when done to continue..." -n 1 -s; fi
	@if [ -a fig/main/figure_2b.svg ]; then :; else cat tmp/index_old.svg | sed 's/link"/link" style="fill: none; stroke: #ccc; stroke-width: 1.5px;"/g' | sed 's/circle style="/circle style="stroke: steelblue; stroke-width: 1.5px; /g' > fig/main/figure_2b.svg; fi
	@rm -rf tmp

fig2c:
	@if [ -a fig/main/figure_2c.svg ]; then echo "[LOG]   Figure 2c exist"; fi
	@if [ -a fig/main/figure_2c.svg ]; then :; else echo "[LOG]   Plotting figure 2c"; fi

fig3a:
	@mkdir -p fig
	@mkdir -p fig/main
	@mkdir -p tmp
	@if [ -a fig/main/figure_3a.svg ]; then echo "[LOG]   Figure 3a exist"; fi
	@if [ -a fig/main/figure_3a.svg ]; then :; else echo "[LOG]   Plotting Figure 3a"; fi
	@if [ -a fig/main/figure_3a.svg ]; then :; else $(perlbin) src/plt/main/figure_3a.pl $(mainfig3_nprofiles) > tmp/inputR.tab; fi
	@if [ -a fig/main/figure_3a.svg ]; then :; else $(rbin) --vanilla --args tmp/inputR.tab fig/main/figure_3a.svg < src/plt/main/figure_3a.R > /dev/null; fi
	@rm -rf tmp

fig3b:
	@mkdir -p fig
	@mkdir -p fig/main
	@mkdir -p tmp
	@if [ -a fig/main/figure_3b.svg ]; then echo "[LOG]   Plotting figure 3b"; fi
	@if [ -a fig/main/figure_3b.svg ]; then :; else echo "[LOG]   Plotting Figure 3b"; fi
	@if [ -a fig/main/figure_3b.svg ]; then :; else $(perlbin) src/plt/main/figure_3b.pl $(mainfig3_foldchange) > tmp/inputR.tab; fi
	@if [ -a fig/main/figure_3b.svg ]; then :; else $(rbin) --vanilla --args tmp/inputR.tab fig/main/figure_3b.svg < src/plt/main/figure_3b.R > /dev/null; fi
	@rm -rf tmp

fig3c:
	@if [ -a fig/main/figure_3c.svg ]; then echo "[LOG]   Figure 3c exist"; fi
	@if [ -a fig/main/figure_3c.svg ]; then :; else echo "[LOG]   Plotting figure 3c"; fi

fig4a:
	@mkdir -p fig
	@mkdir -p fig/main
	@mkdir -p tmp
	@if [ -a fig/main/figure_4a.svg ]; then echo "[LOG]   Figure 4a exist"; fi
	@if [ -a fig/main/figure_4a.svg ]; then :; else echo "[LOG]   Plotting Figure 4a"; fi
	@if [ -a fig/main/figure_4a.svg ]; then :; else $(perlbin) src/plt/main/figure_4a.pl dat/dicer/serpent_annotation_extended.deseq $(mkvalidation_pval) > tmp/inputR.tab; fi
	@if [ -a fig/main/figure_4a.svg ]; then :; else $(rbin) --vanilla --args tmp/inputR.tab fig/main/figure_4a.svg $(mkvalidation_pval) < src/plt/main/figure_4a.R > /dev/null; fi
	@rm -rf tmp

fig4b:
	@mkdir -p fig
	@mkdir -p fig/main
	@mkdir -p tmp
	@if [ -a fig/main/figure_4b.svg ]; then echo "[LOG]   Figure 4b exist"; fi
	@if [ -a fig/main/figure_4b.svg ]; then :; else echo "[LOG]   Plotting Figure 4b"; fi
	@if [ -a fig/main/figure_4b.svg ]; then :; else $(perlbin) src/plt/main/figure_4b.pl dat/dicer/serpent_annotation_extended.deseq $(mkvalidation_pval) > tmp/inputR.tab; fi
	@if [ -a fig/main/figure_4b.svg ]; then :; else $(rbin) --vanilla --args tmp/inputR.tab fig/main/figure_4b.svg $(mkvalidation_pval) < src/plt/main/figure_4b.R > /dev/null; fi
	@rm -rf tmp

fig4c:
	@mkdir -p fig
	@mkdir -p fig/main
	@mkdir -p tmp
	@if [ -a fig/main/figure_4c.svg ]; then echo "[LOG]   Figure 4c exist"; fi
	@if [ -a fig/main/figure_4c.svg ]; then :; else echo "[LOG]   Plotting Figure 4c"; fi
	@if [ -a fig/main/figure_4c.svg ]; then :; else $(perlbin) src/plt/main/figure_4c.pl dat/dicer/serpent_annotation_extended.deseq $(mkvalidation_pval) > tmp/inputR.tab; fi
	@if [ -a fig/main/figure_4c.svg ]; then :; else $(rbin) --vanilla --args tmp/inputR.tab fig/main/figure_4c.svg $(mkvalidation_pval) < src/plt/main/figure_4c.R > /dev/null; fi
	@rm -rf tmp

fig4aold:
	@mkdir -p fig
	@mkdir -p fig/main
	@mkdir -p tmp
	@echo "[LOG]   Plotting figure 4A"
	@$(perlbin) src/plt/main/figure_4a.pl > tmp/inputR.tab
	@$(rbin) --vanilla --args tmp/inputR.tab fig/main/figure_4a.svg < src/plt/main/figure_4a.R > /dev/null
	@rm -rf tmp

fig4bold:
	@mkdir -p fig
	@mkdir -p fig/main
	@mkdir -p tmp
	@echo "[LOG]   Plotting figure 4B"
	@$(perlbin) src/plt/main/figure_4b.pl > tmp/inputR.tab
	@$(rbin) --vanilla --args tmp/inputR.tab fig/main/figure_4b.svg < src/plt/main/figure_4b.R > /dev/null

fig3aold2:
	@echo "Plotting Figure 3a"
	@mkdir -p fig
	@mkdir -p fig/main
	@mkdir -p tmp
	@$(perlbin) src/plt/main/figure_3a.pl dat/$(mainfig3_sample1)/profiles.dat dat/$(mainfig3_sample2)/profiles.dat $(mainfig3_profile1) $(mainfig3_profile2) $(mainfig3_sample1) $(mainfig3_sample2)> tmp/inputR.dat
	@$(rbin) --vanilla --args tmp/inputR.dat fig/main/figure_3a.svg < src/plt/main/figure_3a.R > /dev/null
	@rm -rf tmp

fig3cold2:
	@echo "Plotting figure 3c"
	@mkdir -p fig
	@mkdir -p fig/main
	@mkdir -p tmp
	@$(perlbin) src/plt/main/figure_3cd.pl dat/$(mainfig3_sample1)/profiles.dat dat/$(mainfig3_sample1)/annotation.bed dat/$(mainfig3_sample2)/profiles.dat dat/$(mainfig3_sample2)/annotation.bed $(mainfig3_profile1) $(mainfig3_profile2) > tmp/inputR.dat
	@$(rbin) --vanilla --args tmp/inputR.dat fig/main/figure_3c.svg < src/plt/main/figure_3cd.R > /dev/null
	@rm -rf tmp

fig3dold2:
	@echo "Plotting figure 3d"
	@mkdir -p fig
	@mkdir -p fig/main
	@mkdir -p tmp
	@$(perlbin) src/plt/main/figure_3cd.pl dat/$(mainfig3_sample2)/profiles.dat dat/$(mainfig3_sample2)/annotation.bed dat/$(mainfig3_sample1)/profiles.dat dat/$(mainfig3_sample1)/annotation.bed $(mainfig3_profile2) $(mainfig3_profile1) > tmp/inputR.dat
	@$(rbin) --vanilla --args tmp/inputR.dat fig/main/figure_3d.svg < src/plt/main/figure_3cd.R > /dev/null
	@rm -rf tmp
