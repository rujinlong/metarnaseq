process HUMANN {
    label "metarnaseq_humann"

    input:
    tuple val(sampleID), file(reads1), file(reads2)

    output:
    path("annoHumann_${sampleID}")

    when:
    task.ext.when == null || task.ext.when

    """
    zcat $reads1 $reads2 | gzip > ${sampleID}.fq.gz
    humann --input ${sampleID}.fq.gz --output annoHumann_${sampleID} --threads $task.cpus --memory-use 'maximum' --nucleotide-database ${params.db_biobakery}/humann3/chocophlan --protein-database ${params.db_biobakery}/humann3/uniref --metaphlan-options "--bowtie2db ${params.db_biobakery}/metaphlan"
    rm -rf ${sampleID}.fq.gz
    """
}
