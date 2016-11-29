#' @title CRAN Stats for single package
#' @author Avi Blinder
#' @description Download CRAN data related to several packages in a range of dates
#' @param from_date  Starting date for downloading CRAN Repositories
#' @param to_date  end date for downloading CRAN Repositories
#' @param sel_package_name  Single package name for analysis
#' @export
#' @examples
#' cran_stats_by_package('2016-11-01','2016-11-02',"sparklyr")



cran_stats_by_package <- function(from_date,to_date,sel_package_name){

  ##
  start_date <- lubridate::ymd(from_date)
  end_date <- lubridate::ymd(to_date)

  all_days <- seq(start_date, end_date, by = 'day')
  years <- lubridate::year(all_days)

  urls <- paste0('http://cran-logs.rstudio.com/', years, '/', all_days, '.csv.gz')

  package_stats <- c()
  for (i in 1:length(urls)) {
    stats_df <- c()
    tmp <- tempfile()
    download.file(urls[i], tmp)
    unzipped_file <- read.csv( gzfile(tmp), sep="\t",header=TRUE,
                               stringsAsFactors=FALSE)
    rm(tmp)
    #
    names(unzipped_file) <- "ConcatCol"
    unzipped_file_df <- tidyr::separate(unzipped_file,'ConcatCol',sep = ",",
                                 into = c("date","time","size","r_version","r_arch","r_os",
                                          "package_name","package_version","country","ip_id"))
    unzipped_file_df_pck <- subset(unzipped_file_df,unzipped_file_df$package_name == sel_package_name)
    package_stats <- rbind(package_stats,unzipped_file_df_pck)
  }
  package_stats
}
######################################################################################
#' @return A dataframe with log date of a full date
#' @title CRAN Stats for a specific date
#' @author Avi Blinder
#' @description Download a full CRAN Log for a specific date
#' @param Date date of CRAN log to be downloaded
#' @export
#'

cran_stats_by_day <- function(Date){

  start <- lubridate::ymd(Date)


  ##Create regex for package name
  urls <- paste0('http://cran-logs.rstudio.com/',
                 lubridate::year(start), '/', start, '.csv.gz')

  package_stats <- c()
  stats_df <- c()
  tmp <- tempfile()
  download.file(urls, tmp)
  unzipped_file <- read.csv( gzfile(tmp), sep="\t",header=TRUE,
                             stringsAsFactors=FALSE)
  rm(tmp)
  #remove header
  names(unzipped_file) <- "ConcatCol"
  unzipped_file_df <- tidyr::separate(unzipped_file,'ConcatCol',sep = ",",
                               into = c("date","time","size","r_version","r_arch","r_os",
                                        "package_name","package_version","country","ip_id"))
}
#######################################################################################
#' @return dataframe with log information
#' @title CRAN Stats for several packages
#' @author Avi Blinder
#' @description Download CRAN log data related to several packages in
#' a range of dates
#' @param from_date  Starting date for downloading CRAN Repositories
#' @param to_date  end date for downloading CRAN Repositories
#' @param sel_package_name  Single package name for analysis
#' @export
#'
cran_stats_by_packages <- function(from_date,to_date,sel_package_name){


  ##
  start_date <- lubridate::ymd(from_date)
  end_date <- lubridate::ymd(to_date)

  all_days <- seq(start_date, end_date, by = 'day')
  years <- lubridate::year(all_days)

  urls <- paste0('http://cran-logs.rstudio.com/', years, '/', all_days, '.csv.gz')

  package_stats <- c()
  for (i in 1:length(urls)) {
    stats_df <- c()
    tmp <- tempfile()
    download.file(urls[i], tmp)
    unzipped_file <- read.csv( gzfile(tmp), sep="\t",header=TRUE,
                               stringsAsFactors=FALSE)
    rm(tmp)
    #
    names(unzipped_file) <- "ConcatCol"
    unzipped_file_df <- tidyr::separate(unzipped_file,'ConcatCol',sep = ",",
                                 into = c("date","time","size","r_version","r_arch","r_os",
                                          "package_name","package_version","country","ip_id"))
    unzipped_file_df_pck <- subset(unzipped_file_df,unzipped_file_df$package_name %in% sel_package_name)
    package_stats <- rbind(package_stats,unzipped_file_df_pck)
  }
  package_stats
}
