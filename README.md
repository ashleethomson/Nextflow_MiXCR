# MiXCR Pipeline

## Usage

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


