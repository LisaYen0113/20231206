URL = "https://info.nhi.gov.tw/INAE4000/INAE4001S01"

txt = scan(URL, what = "character", encoding = "UTF-8", quiet = TRUE)

head(txt, 15)

txt_new = paste(txt, sep = "", collapse = " ")

TITLE.pos = gregexpr("<title>.*</title>", txt_new)
start.TITLE.pos = TITLE.pos[[1]][1]
end.TITLE.pos = start.TITLE.pos + attr(TITLE.pos[[1]], "match.length")[1] - 1

TITLE.word = substr(txt_new, start.TITLE.pos, end.TITLE.pos)

TITLE.word