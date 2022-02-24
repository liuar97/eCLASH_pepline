#!/usr/bin/bash

tags="U2-1 U2-2 U2-3 U8-1 U8-2 U8-3"
for tag in $tags
do
mkdir ${ALIGNPATH}/${tag}
mkdir ${RESULTPATH}/${tag}
nohup STAR --genomeDir ${INDEXPATH} --readFilesIn ${DATAPATH}/${tag}.fa --outSAMtype BAM SortedByCoordinate --outFileNamePrefix ${ALIGNPATH}/${tag}/${tag}. --outFilterMultimapNmax 30 --outFilterMultimapScoreRange 0 --alignIntronMax 20 --chimSegmentMin 15 --chimJunctionOverhangMin 15 --chimMultimapNmax 900 --chimScoreJunctionNonGTAG 0 --chimMultimapScoreRange 0 --limitOutSJcollapsed 5000000 --outReadsUnmapped Fastx> ${ALIGNPATH}/${tag}/${tag}_STAR.log
obtain_interaction_pairs ${ALIGNPATH}/${tag}/${tag}.Chimeric.out.junction ${RESULTPATH}/${tag}/${tag}_interactions.tsv 
filter_interaction_pairs ${RESULTPATH}/${tag}/${tag}_interactions.tsv ${RESULTPATH}/${tag}/${tag}_snoRNA_interactions.tsv
done

search_for_matches "U2-1,U2-2,U2-3" "${RESULTPATH}/U2-1/U2-1_snoRNA_interactions.tsv,${RESULTPATH}/U2-2/U2-2_snoRNA_interactions.tsv,${RESULTPATH}/U2-3/U2-3_snoRNA_interactions.tsv" "${RESULTPATH}/U2/U2_"
search_for_matches "U8-1,U8-2,U8-3" "${RESULTPATH}/U8-1/U8-1_snoRNA_interactions.tsv,${RESULTPATH}/U8-2/U8-2_snoRNA_interactions.tsv,${RESULTPATH}/U8-3/U8-3_snoRNA_interactions.tsv" "${RESULTPATH}/U8/U8_"
search_for_matches "U2-1,U2-2,U2-3,U8-1,U8-2,U8-3" "${RESULTPATH}/U2-1/U2-1_snoRNA_interactions.tsv,${RESULTPATH}/U2-2/U2-2_snoRNA_interactions.tsv,${RESULTPATH}/U2-3/U2-3_snoRNA_interactions.tsv,${RESULTPATH}/U8-1/U8-1_snoRNA_interactions.tsv,${RESULTPATH}/U8-2/U8-2_snoRNA_interactions.tsv,${RESULTPATH}/U8-3/U8-3_snoRNA_interactions.tsv" "${RESULTPATH}/consensus/consensus_"




