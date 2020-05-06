# Set parameters and install packages: 
options(max.print = 1000000000)
getOption("max.print")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("biomaRt")
library("biomaRt")

# Instantiate the ensembl data:
ensembl = useMart("ensembl",host='http://Dec2015.archive.ensembl.org',dataset="hsapiens_gene_ensembl")

# Observe the datasets: 
datasets <-  listDatasets(ensembl)
datasets
# Discover what you can pick out of the ensembl: 
listAttributes(ensembl)
# Select the ensembl_gene_id, HUGO gene symbol, Gene description, Number of transcripts, Chromosome, Strand, GC%, Gene Type, Status, and Phenotype Description: 
genes <- getBM(attributes=c('ensembl_gene_id','hgnc_symbol','description','transcript_count','chromosome_name','strand','percentage_gc_content','gene_biotype','status', 'phenotype_description'), mart = ensembl)
genes
# Filter and include only data on the positive strand:
pos_gene_strand <-  genes[!(genes$strand == '-1'),]
pos_gene_strand
#Evidence of Positive Strands:
pos_gene_strand$strand
# Make a boxplot of GC content for each gene_biotype: 
library(ggplot2)
ggplot(pos_gene_strand) + geom_boxplot(mapping = aes(x = percentage_gc_content, fill = gene_biotype)) + ggtitle(label = "Boxplot Analysis: GC Percentage Based on Gene Biotype") + labs(fill = 'Gene Biotype') + scale_x_continuous(name = 'Percentage of GC Content')



