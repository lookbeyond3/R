localeToCharset()
a="안녕"
Encoding(a)

install.packages("KoNLP")
library(KoNLP)

install.packages("ggplot2")
library(ggplot2)

install.packages("dplyr")
library(dplyr)


#R과 Java 연동하기
install.packages("Rserve")
library(Rserve)

rm(list=ls()) #모든 객체 삭제
gc() #사용이 종료된 객체가 사용하고 있던 메모리를 자동으로 해제
