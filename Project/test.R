# xml 형식의 데이터를 다루기 위해서 패키지를 다운 후 호출
install.packages("XML")
library(XML)

# 특정 함수를 사용하기 위해서 패키지를 다운 후 호출
install.packages("RCurl")
library(RCurl)

# rbind.fill() 함수를 사용하기 위해서 패키지를 호출
install.packages("plyr")
library(plyr)

# 요청주소 요소들 
url1 <- "http://api.visitkorea.or.kr/openapi/service/rest/KorService/"
url2 <- "?ServiceKey="
mykey <- "UJOag83AY010fwClWHxQ8OQ49aSudCZ%2FXTDXZxLaWFBxeeEQuDd2Md9RHggWjO77w80u3GQsGs3oA4WvAVYayg%3D%3D"
url3 <- "&numOfRows=100"
url4 <- "&MobileOS=ETC"
url5 <- "&MobileApp=TestApp"
url6 <- "&pageNo="
# url7 <- "&eventStartDate=20180401"
# url8 <- "&eventEndDate=20180430"
# url9 <- "&arrange=A"

# 원하는 값을 입력하는 부분
# 데이터를 가져올 카테고리 명
category <- "searchFestival"

# 데이터를 저장할 데이터 프레임을 선언
table <- data.frame()

# 위에 설정해 놓은 요청주소에 필요한 모든것을 이어붙여서 요청 주소를 생성
requestUrl <- paste(url1, category, url2, mykey, url3, url4, url5, url6, url7, url8, url8, sep="")

# 데이터의 총개수와 페이지 개수를 구하기 위해서 우선적으로 페이지 번호를 1으로 설정하여 데이터를 읽어들임
page = getForm(paste0(requestUrl, "1", sep=""), query="")

# xml형식의 파일을 Data frame의 형태로 변환하여 저장
doc = xmlToDataFrame(page)

# 데이터의 총 개수를 가져옴
totaldataNumber = as.numeric(doc[2,6])

# 데이터가 있는 페이지 번호를 구하기 위해서 전체 데이터 개수를 구한 후 100으로 나눔
totalPageNumber = (totaldataNumber%/%100) +1
try(
  {
    # 1번째 페이지부터 마지막 페이지까지 반복문을 실행
    for (pageNumber in 1:totalPageNumber) {
      # 요청주소 뒤에 페이지 번호를 붙여서 완벽한 주소를 생성
      Url <- paste0(requestUrl, pageNumber, sep="")
      # 주소로부터 데이터를 읽어 들임
      page = getForm(Url, query="")
      # 데이터를 우선적으로 xml 형식으로 가져옴
      doc = xmlParse(page)
      # xml 형식의 데이터를 List 형태의 데이터로 변환 후 저장
      doc = xmlToList(doc)
      # 현재 페이지의 데이터 개수를 확인
      index = 100
      # 마지막 페이지 번호인지 확인
      if(pageNumber == totalPageNumber){
        # 마지막 페이지이면 데이터의 개수가 100보다 작을 수 있으므로
        # 총 데이터 개수에 (총 페이지개수-1)*100
        index = totaldataNumber - ((totalPageNumber-1)*100)
      }
      
      # 페이지에 있는 데이터 수만큼 반복문 실행
      for(i in 1:index){
        # 실질적인 데이터 부분을 저장
        ex <- data.frame(doc[2]$body$items[i])
        # table이 비어있는지를 확인
        if(length(table)==0){
          # 비어있다면 데이터를 테이블에 저장
          table <- ex 
        }
        else{
          # 비어있지 않다면 rbind.fill 함수를 사용하여 table 뒤에 이어서 붙임
          table <- rbind.fill(tabel, ex)
        }
      }
    }
  },
  silent = TRUE
)