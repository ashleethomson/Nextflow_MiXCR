process mixcr {

    tag { "mixcr - ${filename}" } 
    publishDir "${outdir}/${group}/${filename}/MiXCR", mode: 'copy'
    label 'process_mixcr'

    input:
    tuple val(filename), val(group), val(sample), val(path), file(reads)
    val outdir
     
    output:
	file "${filename}.analysis.clna"
	file "${filename}.analysis.clonotypes.ALL.txt"
	file "${filename}.analysis.clonotypes.IGH.txt"
	file "${filename}.analysis.clonotypes.IGK.txt"
	file "${filename}.analysis.clonotypes.IGL.txt"
	file "${filename}.analysis.clonotypes.TRA.txt"
	file "${filename}.analysis.clonotypes.TRB.txt"
	file "${filename}.analysis.clonotypes.TRD.txt"
	file "${filename}.analysis.clonotypes.TRG.txt"
	file "${filename}.analysis.extended.vdjca"
	file "${filename}.analysis.report"
	file "${filename}.analysis.rescued_0.vdjca"
	file "${filename}.analysis.rescued_1.vdjca"
	file "${filename}.analysis.vdjca"

    script:
    """
	mixcr analyze shotgun \
		--species hs \
		--starting-material rna \
		--only-productive \
		${reads[0]} ${reads[1]} ${filename}.analysis
    """
}




