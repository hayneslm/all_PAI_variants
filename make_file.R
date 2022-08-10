install.packages("tidyverse")
install.packages("dplyr")
library(dplyr)
library(tidyverse)
library(readr)

PAI1seq = "VHHPPSYVAHLASDFGVRVFQQVAQASKDRNVVFSPYGVASVLAMLQLTTGGETQQQIQAAMGFKIDDKGMAPALRHLYKELMGPWNKDELSTTDAIFVQRDLKLVQGFMPHFFRLFRSTVKQVDFSEVERARFIINDWVKTHTKGMISNLLGKGAVDQLTRLVLVNALYFNGQWKTPFPDSSTHRRLFHKSDGSTVSVPMMAQTNKFNYTEFTTPDGHYYDILELPYHGDTLSMFIAAPYEKEVPLSALTNILSAQLISHWKGNMTRLPRLLVLPKFSLETEVDLRKPLENLGMTDMFRQFQADFTSLSDQEPLHVAQALQKVKIEVNESGTVASSSTAVIVSARMAPEEIIMDRPFLFVVRHNPTGTVLFMGQVMEP"
charPos = str_length(PAI1seq)
charIndex = c(1:charPos)
AAall = "ARNDCEQGHILKMFPSTWYV"
AAindex = c(1:20)

AllMuts = NULL

for (i1 in charIndex) {
  AA = substr(PAI1seq, i1, i1)
  Pos = i1
  for (i2 in AAindex) {
    Mut = substr(AAall, i2, i2)
    temprow = c(AA, Pos, Mut)
    AllMuts = rbind(AllMuts, temprow)
  }
}

rownames(AllMuts) <- NULL
AllMuts = AllMuts %>% as_tibble() %>% rename(AA = V1, Pos = V2, Mut = V3) %>% 
  filter(AA != Mut) %>% 
  mutate(Mutation = paste(AA,Pos,Mut, sep = ""))

write_csv(AllMuts,"PAI-1_missenseMutations.csv")
