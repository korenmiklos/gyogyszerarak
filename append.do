clear
tempfile forgalom
import delimited "output/gyogyszer.csv", clear
save `forgalom', replace

import delimited "output/gyse.csv", clear
append using `forgalom'

replace teljes_ar = tb_tamogatas + teritesi_dij if missing(teljes_ar)

export delimited "output/gyogyszerarak.csv", replace