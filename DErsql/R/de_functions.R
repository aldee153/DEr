#' @title ImportEvergreenData
#'
#' @description This function allows you import Evergreen customer data from the ODS.ODS_RO.vw_us_account_base.
#' @param
#' @keywords
#' @export
#' @examples
#' ImportEvergreenData()

ImportEvergreenData <- function(
  LatestRatePlanGroup = 'Evergreen',
  StartTime = '2018-01-01',
  EndTime = '2018-12-31'){

  Con <- DBI::dbConnect(odbc::odbc(),
                        driver =  "{SQL Server};",
                        server = "RTPWDBDVSAS02",
                        Port = 1433)

  Query <- odbc::dbSendQuery(
    Con, "
    DECLARE @LatestRatePlanGroup VARCHAR(10)
    DECLARE	@StartTime datetime
    DECLARE @EndTime datetime

    SET @LatestRatePlanGroup = ?
    SET	@StartTime = ?
    SET @EndTime = ?

    SELECT *
    FROM ODS.ODS_RO.vw_us_account_base
    WHERE LatestRatePlanGroup = @LatestRatePlanGroup
    AND signMonth >= @StartTime
    AND SignMonth <= @EndTime
    ")

  odbc::dbBind(Query, list(LatestRatePlanGroup, StartTime, EndTime))
  odbc::dbFetch(Query) -> dat
  return(dat)
  odbc::dbClearResult(Query)
}
