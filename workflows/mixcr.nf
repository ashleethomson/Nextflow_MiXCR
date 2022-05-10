/*
Analysis of T- and B- cell receptor repertoire sequencing data
	- MiXCR
*/

// Import processes used by sub-workflow
include { mixcr } from './../modules/mixcr/3.0.13/mixcr'


/*
Call the sub-workflow: MiXCR pipeline
*/

workflow mixcr_pipeline {
	take:
		ch_samples
	
	main:

		mixcr(
			ch_samples,
			params.outdir
		)
}
