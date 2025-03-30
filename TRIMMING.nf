process TRIMMING {
    publishDir(params.trimmed_reads, mode: 'copy', pattern: 'trimmed_*_paired.fastq')
    publishDir(params.fastp_report, mode: 'copy', pattern: 'fastp.*')

    input:
    tuple val(sample_id), path(reads)

    output:
    path "trimmed_1_paired.fastq", emit: paired1
    path "trimmed_2_paired.fastq", emit: paired2
    path "fastp.json", emit: json_report
    path "fastp.html", emit: html_report

    script:
    """
    fastp \
    -i $reads \
    -I $reads \
    -o trimmed_1_paired.fastq \
    -O trimmed_2_paired.fastq \
    --cut_front --cut_tail \
    --cut_window_size 4 \
    --cut_mean_quality 15 \
    --length_required 36 \
    --thread 4 \
    --json fastp.json \
    --html fastp.html
    """
}
