process mixcr {

    tag { "mixcr - ${filename}" } 
    publishDir "${outdir}/${group}/${filename}/MiXCR", mode: 'copy'
    label 'process_mixcr'

    input:
    tuple val(filename), val(group), val(sample), val(path), file(reads)
    val outdir
     
    output:
    file "${filename}_analysis.clna"
	file "${filename}_analysis.clonotypes.ALL.txt"
	file "${filename}_analysis.clonotypes.IGH.txt"
	file "${filename}_analysis.clonotypes.IGK.txt"
	file "${filename}_analysis.clonotypes.IGL.txt"
	file "${filename}_analysis.clonotypes.TRA.txt"
	file "${filename}_analysis.clonotypes.TRB.txt"
	file "${filename}_analysis.clonotypes.TRD.txt"
	file "${filename}_analysis.clonotypes.TRG.txt"
	file "${filename}_analysis.extended.vdjca"
	file "${filename}_analysis.report"
	file "${filename}_analysis.rescued_0.vdjca"
	file "${filename}_analysis.rescued_1.vdjca"
	file "${filename}_analysis.vdjca"

    script:
    """
    	mixcr analyze shotgun \
        	--species hs \
        	--starting-material rna \
        	--only-productive \
        	${reads[0]} ${reads[1]} \
        	--report /${PWD}/${filename}
    """
}




