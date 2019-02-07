#' @title ImportPeaceData
#'
#' @description This function allows you import Peace customer data from the ODS.ODS_RO.vw_us_account_base.
#' @param
#' @keywords Peace customers
#' @export
#' @examples
#' ImportPeaceData()

ImportPeaceData <- function(
  Platform = 'Peace',
  StartTime = '2018-01-01',
  EndTime = today()){
  
  Con <- DBI::dbConnect(odbc::odbc(),
                        driver =  "{SQL Server};",
                        server = "RTPWDBDVSAS02",
                        Port = 1433)
  
  Query <- odbc::dbSendQuery(
    Con, "
    DECLARE @Platform VARCHAR(10)
    DECLARE	@StartTime datetime
    DECLARE @EndTime datetime
    SET @Platform = ?
    SET	@StartTime = ?
    SET @EndTime = ?
    SELECT *
    FROM ODS.ODS_RO.vw_us_account_base
    WHERE Platform = @Platform
    AND signMonth >= @StartTime
    AND SignMonth <= @EndTime
    ")
  
  odbc::dbBind(Query, list(Platform, StartTime, EndTime))
  odbc::dbFetch(Query) -> dat
  return(dat)
  odbc::dbClearResult(Query)
}
