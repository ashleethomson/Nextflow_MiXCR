process mixcr {

    tag { "mixcr - ${filename}" } 
    publishDir "${outdir}/${group}/${filename}/MiXCR", mode: 'copy'
    label 'process_mixcr'

    input:
    tuple val(filename), val(group), val(sample), val(path), file(reads)
    val outdir
     
    output:
	file "${filename}.filtered.clonotypes.ALL.txt"
	file "${filename}.analysis.clonotypes.ALL.txt"


    script:
    """
	mixcr analyze shotgun \
		--species hs \
		--starting-material rna \
		--only-productive \
		${reads[0]} ${reads[1]} ${filename}.analysis

	awk -F "\t" '{ if (\$2>=10.0) print (\$2"\t"\$6"\t"\$7"\t"\$8"\t"\$9) }' ${filename}.analysis.clonotypes.ALL.txt > {filename}.filtered.clonotypes.ALL.txt
    """
}




