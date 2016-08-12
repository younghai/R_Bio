#Chapter 5 : DNA Sequence Statistics - Part 2
##Q1
## Sequence �� list obj.�� �����ϱ�
library(seqinr)
dengue<-read.fasta(file="E:\\My files\\Documents\\Biospin\\den1.fasta", seqtype="DNA")
dengueseq<-dengue[[1]]  ## amended from the book code

## Sliding Window Plot �� �׸��� Function �����
slidingwindowplot <- function(windowsize, inputseq)
{
  starts<-seq(from=1, to=length(inputseq)-windowsize, by=windowsize)
  n<- length(starts)
  chunkGCs<-numeric(n)
  for (i in 1:n){
    chunk <-inputseq[starts[i]:(starts[i]+windowsize-1)]
    chunkGC<-GC(chunk)
    chunkGCs[i]<-chunkGC
  }
  plot(starts,chunkGCs,type="b", xlab="Nucleotide start position", ylab="GC content")
}

## 200 nucleotides ¥�� window plot �׸��� 
slidingwindowplot(200, dengueseq)

##Q2
leprae<-read.fasta(file="E:\\My files\\Documents\\Biospin\\leprae.fasta", seqtype="DNA")
lepraeseq<-leprae[[1]]

slidingwindowplot(20000,lepraeseq)

##Q3
AT<-function(inputseq)
{
  mytable<-count(inputseq,wordsize=1)
  mylength<-length(inputseq)
  myAs<-mytable[[1]]
  myTs<-mytable[[4]]
  myAT<-(myAs+myTs)/mylength
  return(myAT)
}
AT(lepraeseq)

##Q4
slidingwindowplotAT<-function(windowsize,inputseq)
{
  starts<-seq(1, length(inputseq)-windowsize,by=windowsize)
  n<-length(starts)
  chunkATs<-numeric(n)
  for (i in 1:n){
    chunk<-inputseq[starts[i]:starts[i]+windowsize-1]
    chunkAT<-AT(chunk)
    chunkATs[i] <- chunkAT
  }
  plot(starts,chunkATs, type='b',xlab="Nucleotide start position", ylab="AT content")
}
slidingwindowplotAT(20000,lepraeseq)


##Q5 
#MANUAL
count(lepraeseq,1)
count(lepraeseq,3) ## GAC�� 34��° ���� �ֽ��ϴ�.


a<-as.numeric(count(lepraeseq,1)[[1]])
c<-as.numeric(count(lepraeseq,1)[[2]])
g<-as.numeric(count(lepraeseq,1)[[3]])
t<-as.numeric(count(lepraeseq,1)[[4]])

gac<-as.numeric(count(lepraeseq,3)[34])

rho_GAC<- gac/sum(count(lepraeseq,3))/((a*c*g)/(sum(count(lepraeseq,1)))**3)

#Built-in Function
rho(lepraeseq,wordsize=3)