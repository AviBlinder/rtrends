#' @title Merge stats with County names
#' @author Avi Blinder
#' @description Merge CRAN log data with County names
#' @param cran_log  dataftame containing CRAN log data
#' data(sample_log)
#' cran_summary(sample_log)
#' @export

cran_summary <- function(cran_log){
  data(countries)
  multiple_pack_Stats_full <- merge(packages_stats,countries,by.x = "country",by.y="country_iso_code")

}


