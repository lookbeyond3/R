install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")

library(rJava)
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_161')
library(DBI)
library(RJDBC) #rJava에 의존적, rJava 먼저 로딩할 것


##Oracle 연동(Oracle 11g)
#driver
drv=JDBC("oracle.jdbc.driver.OracleDriver", 
         
         "C:\\oraclexe\\app\\oracle\\product\\11.2.0\\server\\jdbc\\lib\\ojdbc6.jar")

#DB 연동
conn=dbConnect(drv, "jdbc:oracle:thin:@//192.168.137.201:1521/orcl", "java00", "java00")

rst=dbGetQuery(conn, "SELECT * FROM board")
rst
head(rst)
