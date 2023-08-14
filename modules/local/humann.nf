process HUMANN {
    tag "$meta.id"
    label "metarnaseq_humann"

    input:
    tuple val(meta), path(reads)

    output:
    path "annoHumann_*"

    when:
    task.ext.when == null || task.ext.when

    script:
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    zcat ${reads[0]} ${reads[1]} | gzip > ${prefix}.fq.gz
    humann --input ${prefix}.fq.gz --output annoHumann_${prefix} --threads $task.cpus --memory-use 'maximum' --nucleotide-database ${params.db}/humann3/chocophlan --protein-database ${params.db}/humann3/uniref --metaphlan-options "--bowtie2db ${params.db}/humann3/metaphlan"
    rm -rf ${prefix}.fq.gz
    """
}
