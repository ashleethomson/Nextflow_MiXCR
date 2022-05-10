// These have been replaced by `WorkflowMain.groovy` script in the 'lib' dir
/*def printVersion(String version) {
	println(
		"""
		==============================================================
			   MIXCR PIPELINE ${version}		
		==============================================================
		""".stripIndent()
	)
}

def printHelpMessage() {
	println(
		"""
		Nextflow Arguments:
			-profile <str>			Which Nextflow profile to use: SHOULD always be 'conda,slurm'
			-N <str>			SAGC email that a notification of completion will be sent to
		
		Mandatory Arguments:
			--outdir <path>			Path to output directory
			--samplesheet <path>		Path to sample sheet
			--email <str>			Your email
			--partition <str>		Which HPC partition to use ('sahmri_prod_hpc' or 'sahmri_cancer_hpc')
		""".stripIndent()
	)
}

def callHelp(Map args, String version) {

	if(args.help) {
		printVersion(version)
		printHelpMessage()
		System.exit(0)
	}

}
*/

/*
The rest of these should be like the above, I just don't have time
*/
// Check provided arguments
def checkAndSetArgs(Map args) {

	// Map object to return
	def ret = [:] // Doing this cause can't edit 'args'
	ret.putAll(args)

	// Variables
	def hpc_partition = [ 'sahmri_prod_hpc', 'sahmri_cancer_hpc' ]

	// Check required arguments are not empty
	try {
		assert args.outdir
		assert args.samplesheet
		assert args.email
		assert args.partition
	} catch (AssertionError e) {
		println("""ERROR: Check the following arguments:
			--outdir
			--samplesheet
			--email
			--partition\n""")

		println(e.getMessage())
		System.exit(1)
	}

	// Check user provided file path exists
	File ss = new File(args.samplesheet)
	try {
		assert ss.exists()
	} catch (AssertionError e) {
		println("ERROR: $args.samplesheet does not exist.")
		println(e.getMessage())
		System.exit(1)
	}

	try {
		assert !ss.isEmpty()
	} catch (AssertionError e) {
		println("ERROR: $args.samplesheet is empty.")
		println(e.getMessage())
		System.exit(1)
	}

	ret = ret.findAll({!['help'].contains(it.key)})
	return ret
}

def printArguments(Map args) {

	required = [ 'outdir', 'email', 'samplesheet' ]
	subset_required = args.subMap(required)

	genome = [ 
		'assembly', 'gtf', 'starfuse_ctat', 'arriba_staridx', 'arriba_blacklist', 
		'arriba_ctyoband', 'arriba_knownfus', 'arriba_proteindom', 'fusioncatcher_db'
	]
	subset_genome = args.subMap(genome)

	resources = args.findAll { k,v -> !(k in required + genome) }.keySet()
	subset_resources = args.subMap(resources)

	lst = [ subset_required, subset_genome, subset_resources ]

	println(
		"""
		##################################################
		################### Arguments ####################
		""".stripIndent())

	lst.each { l -> 
		l.each {key, value ->

			if(value instanceof java.util.ArrayList) {
				println("$key:")
				value.each { v -> 
					println("  $v")
			}
			} else {
				println("$key: $value")
			}
		}
		println('')
	}
}

def getSampleFromCSV(csvPath) {

	File csv = new File(csvPath)
	def csv_lines = csv.readLines()
	csv_lines.remove(0) // Remove header row

	// Iterate over each line and get reads + other info needed
	// by the pipeline
	def lst = []
	def reads = []
	csv_lines.each { line ->
		line_list = line.tokenize(',')

		// R1/R2 files - ganky
		path = file([line_list[0], line_list[1], line_list[2]].join('/'))
		read_regx = [path, line_list[3] + '_{1,2}.fastq.gz'].join('/')

		// Add reads to read list
		reads.add(read_regx)

		// Add items to 'lst'
		lst.addAll(
			[ [ line_list[3], // file name (needs to be first to join on)
				line_list[1],
				line_list[2],
				path ] ]
		)
	}

	// Multiple assignment in the pipeline
	return [reads, lst]
}
