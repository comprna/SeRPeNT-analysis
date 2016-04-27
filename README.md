# SeRPeNT analysis #
This README is intended to provide the necessary steps to reproduce the results, files and figures included in the following publication:

**The discovery potential of RNA processing profiles**

*Amadís Pagès, Ivan Dotu, Roderic Guigó and Eduardo Eyras*

[bioRxiv](http://biorxiv.org/content/early/2016/04/22/049809)

## Getting started

### Prerequisites

Git - [http://git-scm.com/](http://git-scm.com/)

Perl - [https://www.perl.org/get.html](https://www.perl.org/get.html)

Python - [https://www.python.org/downloads/](https://www.python.org/downloads/)

R - [https://www.r-project.org/](https://www.r-project.org/)

BEDTools - [https://github.com/arq5x/bedtools2/releases/latest](https://github.com/arq5x/bedtools2/releases/latest)

SRA Toolkit - [http://www.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software](http://www.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software)

SeRPeNT - [https://bitbucket.org/regulatorygenomicsupf/serpent/downloads](https://bitbucket.org/regulatorygenomicsupf/serpent/downloads)

STAR - [https://github.com/alexdobin/STAR/releases](https://github.com/alexdobin/STAR/releases)

Infernal - [http://eddylab.org/software/infernal/](http://eddylab.org/software/infernal/)

cutadapt - [https://github.com/marcelm/cutadapt](https://github.com/marcelm/cutadapt)

### Clone serpent-analysis

```
git clone https://amadis_pages@bitbucket.org/regulatorygenomicsupf/serpent-analysis.git
cd serpent-analysis
```

### Edit software dependencies

Edit ```mks/mkdefs.makefile``` to set up software dependencies

## Running the analyses

### Benchmarking SeRPeNT

```
make benchmarking
```

### Generating the extended annotation

```
make annotation
```

### Running the differential processing analysis

```
make diffproc
```