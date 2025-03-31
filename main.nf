include { TRIMMING } from './TRIMMING.nf'
include { INDEX } from './INDEX.nf'
include { ALIGNMENT } from './ALIGNMENT.nf'

workflow {
    reads_ch = Channel.fromFilePairs(params.reads)
    reference_ch = Channel.fromPath(params.reference)

    trimmed_reads = TRIMMING(reads_ch)
    indexed_reference = INDEX(reference_ch)
    ALIGNMENT(
        trimmed_reads.paired1,
        trimmed_reads.paired2,
        indexed_reference.base_reference,
        indexed_reference.indexed_files
    )
}
