process mixcr {

    tag { "mixcr - ${filename}" } 
    publishDir "${outdir}/${group}/${filename}/MiXCR", mode: 'copy'
    label 'process_mixcr'

    input:
    tuple val(filename), val(group), val(sample), val(path), file(reads)
    val outdir
     
    output:
	file "${filename}.analysis.clonotypes.ALL.txt"


    script:
    """
	mixcr analyze shotgun \
		--species hs \
		--starting-material rna \
		--only-productive \
		${reads[0]} ${reads[1]} ${filename}.analysis
    """
}




