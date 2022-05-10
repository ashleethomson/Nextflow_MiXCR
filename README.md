# New ALL Fusion-Calling Pipeline

This is an updated version of the previous ALL [Fusion calling pipeline][fusion]. It uses new
fusion calling software, whilst also using a newer version of `Nextflow` (DSL2).

## Installation

Clone the repository to your system:

```bash
$ git clone --recurse-submodules https://github.com/sagc-bioinformatics/nf-gene-fusion-ALL-SAGC.git
```

Check out the help page by running the following command:

```bash
$ nextflow run main.nf --help

==============================================================
	   ALL GENE-FUSION NEXTFLOW PIPELINE 0.0.1
==============================================================


Nextflow Arguments:
	-profile <str>			Which Nextflow profile to use: Should ALWAYS be 'conda,slurm'
	-N <str>			SAGC email that a notification of completion will be sent to

Mandatory Arguments:
	--outdir <str>			Path to output directory
	--samplesheet <str>		Path to sample sheet
	--email <str>			Your email
	--partition <str>		Which HPC partition to use ('sahmri_prod_hpc' or
					'sahmri_cancer_hpc')
```

## Usage

The pipeline is built around the same sample-sheet that was used by the old fusion and variant
calling pipelines. Some of the columns are redundant, however I've left it all the same for
compatibility reasons.

### 1. Create a Sample-sheet

The sample-sheet is a _CSV_ file of the following structure:

```text
path,group,sample,filename,R1,R2
<path>,GROUP,TEST-0001,TEST-0001-XT,TEST-0001-XT_1.fastq.gz,TEST-0001-XT_2.fastq.gz
```

The columns are as follows:

- **path** = Path to parent directory of all ALL Fastq files
- **group** = Age group that sample belongs to e.g. _AYAII_
- **sample** = Sample identifier e.g. _AYAII_0001_
- **filename** = Fastq file basename e.g. _AYAII-0001-DIA1-PB_
- **R1/R2** = Fastq filename (e.g `AYAII-0001-DIA1-PB_R1.fastq.gz`)

The `group` and `sample` values are actually sub directories of `path`. The pipeline gets samples
by building the following `path` internally:

```text
|--------------- path --------------| |-group-|  |--sample--|
/cancer/storage/raw_fastq/ALL/RNAseq/   AYAII/   AYAII_0001/   <fastq reads at this level>
```

### 2. Run the Pipeline

Use the following command to run the pipeline:

```shell
nextflow run \
    main.nf \
    -profile slurm,conda \
    -N email@gmail.com \
    --outdir ./outdir \
    --samplesheet <path>/test.csv \
    --email email@gmail.com \
    --partition sahmri_prod_hpc
```

[fusion]: https://github.com/sagc-bioinformatics/nf-gene-fusion-ALL
