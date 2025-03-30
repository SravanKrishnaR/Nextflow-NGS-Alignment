process ALIGNMENT {
    publishDir(params.output_dir, mode: 'copy')

    input:
    path trimmed_1_paired
    path trimmed_2_paired
    path base_reference
    path indexed_files

    output:
    path "*", emit: aligned_bam

    script:
    """
    bwa mem ${base_reference} \
    ${trimmed_1_paired} ${trimmed_2_paired} > aligned.sam

    samtools view -S -b aligned.sam > aligned.bam
    samtools sort aligned.bam -o sorted_aligned.bam
    samtools index sorted_aligned.bam
    """
}
