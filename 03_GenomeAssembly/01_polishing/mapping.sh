#!/bin/bash


CPU=$1
INPUT=$2
SR_1=$3
SR_2=$4
PREFIX=$5
LR=$6

#MAPPING SHORT READS ON ASSEMBLY
minimap2 -ax sr --MD -t "$CPU" "$INPUT" "$SR_1" "$SR_2" > "$PREFIX"_sr.sam

#trasforma file SAM in BAM
samtools view -b "$PREFIX"_sr.sam > "$PREFIX"_sr.bam
#rimuove file SAM
rm "$PREFIX"_sr.sam

#sorta il BAM e lo indicizza
samtools sort -@"$CPU" -o "$PREFIX"_sr_sorted.bam "$PREFIX"_sr.bam
samtools index "$PREFIX"_sr_sorted.bam

#MAPPING LONG READS ON ASSEMBLY
minimap2 -ax map-pb --MD -t "$CPU" "$INPUT" "$LR" > "$PREFIX"_lr.sam

#trasforma file SAM in BAM
samtools view -b "$PREFIX"_lr.sam > "$PREFIX"_lr.bam
#rimuove file SAM
rm "$PREFIX"_lr.sam

#sorta il BAM e lo indicizza
samtools sort -@"$CPU" -o "$PREFIX"_lr_sorted.bam "$PREFIX"_lr.bam
samtools index "$PREFIX"_lr_sorted.bam 
