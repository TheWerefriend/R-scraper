library(rvest)
source("variables.R")

for (com in communes) {
  sesh <- html_session(url)
  gform <- html_form(sesh)[[1]]
  Sys.sleep(2)
  for (parc in parcelles) {
    t0 <- Sys.time()
    
    filled <- set_values(gform,
                         ddlCommune = com,
                         tbParcelle = parc)
    resp <- submit_form(sesh, filled, submit = "btnSubmit")
    
    t1 <- Sys.time()
    delay <- as.numeric(t1-t0)
    
    name <- paste(str(com), parc, ".rds")
    saveRDS(resp, file = name)

    Sys.sleep(5 * delay)
  }
}
