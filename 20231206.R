URL = "https://info.nhi.gov.tw/INAE4000/INAE4001S01"

txt = scan(URL, what = "character", encoding = "UTF-8", quiet = TRUE)

head(txt, 15)

txt_new = paste(txt, sep = "", collapse = " ")

TITLE.pos = gregexpr("<title>.*</title>", txt_new)
start.TITLE.pos = TITLE.pos[[1]][1]
end.TITLE.pos = start.TITLE.pos + attr(TITLE.pos[[1]], "match.length")[1] - 1

TITLE.word = substr(txt_new, start.TITLE.pos, end.TITLE.pos)

TITLE.word

TITLE.word = gsub("<title>", "", TITLE.word)
TITLE.word = gsub("</title>", "", TITLE.word)
TITLE.word

start.pos = gregexpr("<tr>", txt_new)
end.pos = gregexpr("</tr>", txt_new)

i = 1
sub.start.pos = start.pos[[1]][i]
sub.end.pos = end.pos[[1]][i] + attr(end.pos[[1]], "match.length")[i] - 1

sub_txt = substr(txt_new, sub.start.pos, sub.end.pos)
sub_txt

sub_txt = gsub('等候掛號人數：', '', sub_txt)
sub_txt = gsub('</?tr>', '', sub_txt)
sub_txt = gsub('</?td>', '', sub_txt)
sub_txt = gsub(' ', '', sub_txt)


NTU_info = function () {
  
  result = data.frame(item = c('等候掛號人數', '等候看診人數', '等候住院人數', '等候ICU人數', '等候推床人數'),
                      info = NA,
                      stringsAsFactors = FALSE)
  
  URL = "https://reg.ntuh.gov.tw/EmgInfoBoard/NTUHEmgInfo.aspx"
  
  txt = scan(URL, what = "character", encoding = "UTF-8", quiet = TRUE)
  txt_new = paste(txt, sep = "", collapse = " ")
  
  start.pos = gregexpr("<tr>", txt_new)
  end.pos = gregexpr("</tr>", txt_new)
  
  for (i in 1:5) {
    
    sub.start.pos = start.pos[[1]][i]
    sub.end.pos = end.pos[[1]][i] + attr(end.pos[[1]], "match.length")[i] - 1
    
    sub_txt = substr(txt_new, sub.start.pos, sub.end.pos)
    sub_txt = gsub('等.*：', '', sub_txt)
    sub_txt = gsub('</?tr>', '', sub_txt)
    sub_txt = gsub('</?td>', '', sub_txt)
    result[i,'info'] = gsub(' ', '', sub_txt)
    
  }
  
  result
  
}

NTU_info()

library(rvest)

URL = "https://reg.ntuh.gov.tw/EmgInfoBoard/NTUHEmgInfo.aspx"

website = read_html(URL)

needed_txt = website %>% html_nodes("tr") %>% html_text()
needed_txt

URL = "https://www.ptt.cc/bbs/AllTogether/index3245.html"
website = read_html(URL)

needed_html = website %>% html_nodes("a")
needed_html

needed_txt = needed_html %>% html_text()
needed_txt

intrested_pos = grep("[徵女]", needed_txt, fixed = TRUE)
needed_txt[intrested_pos]

needed_link = needed_html[intrested_pos] %>% html_attr("href")

i = 1
sub_link = paste("https://www.ptt.cc", needed_link[i], sep = "")
sub_website = read_html(sub_link) 

article_info = sub_website %>% html_nodes(".article-meta-value")
article_info

URL = "https://www.ptt.cc/bbs/AllTogether/index.html"
website = read_html(URL)

website %>% html_nodes("a") %>% .[8] %>% html_attr("href")