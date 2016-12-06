#' @title Merge stats with County names
#' @author Avi Blinder
#' @description Merge CRAN log data with County names
#' @param cran_log  dataftame containing CRAN log data
#' @param countries Countries lookup table
#' data(sample_log)
#' data(countries)
#' cran_summary(sample_log,countries)
#' @export

cran_summary <- function(cran_log,countries){

  multiple_pack_Stats_full <- merge(cran_log,countries,by.x = "country",by.y="country_iso_code")

}

