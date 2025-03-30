process INDEX {
    publishDir(params.indexedreference, mode: 'copy')

    input:
    path reference

    output:
    path "${reference}.*", emit: indexed_files
    path reference, emit: base_reference

    script:
    """
    bwa index $reference
    """
}
