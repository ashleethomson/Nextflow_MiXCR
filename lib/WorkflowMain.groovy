class WorkflowMain {
    public static String printVersion(String version) {
		def message = ''
        message += """
		==============================================================
			   MIXCR PIPELINE ${version}		
		==============================================================
		""".stripIndent()

        println(message)
    }

	public static String printHelpMessage() {
		def message = ''
		message += """
		Nextflow Arguments:
			-profile <str>			Which Nextflow profile to use: Should ALWAYS be 'conda,slurm'
			-N <str>			SAGC email that a notification of completion will be sent to
		
		Mandatory Arguments:
			--outdir <str>			Path to output directory
			--samplesheet <str>		Path to sample sheet
			--email <str>			Your email
			--partition <str>		Which HPC partition to use ('sahmri_prod_hpc' or 'sahmri_cancer_hpc')
		""".stripIndent()
        println(message)
	}

    public static void callHelp(boolean help, String version) {
		if (help) {
            def temp_outdir = new File('false')
            if (temp_outdir.exists()) {
                temp_outdir.deleteDir()
            }
			printVersion(version)
			printHelpMessage()
			System.exit(0)
		}
	}
}
