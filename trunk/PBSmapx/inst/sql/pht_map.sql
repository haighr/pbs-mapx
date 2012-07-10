SET NOCOUNT ON 

SELECT 
  N.OBFL_HAIL_IN_NO as hail_in, 
  N.OBFL_SET_NO as set_no, 
  catch = Sum( CASE M.SPECIES_CODE
    WHEN @sppcode THEN M.LANDED + M.DISCARDED
    ELSE 0 END )
INTO #Catch
FROM 
  D_Merged_Catches M RIGHT OUTER JOIN
  B3_Fishing_Events N ON
  N.OBFL_HAIL_IN_NO = M.HAIL_IN_NO AND 
  N.OBFL_SET_NO = M.SET_NO
GROUP BY 
  N.OBFL_HAIL_IN_NO, N.OBFL_SET_NO

SELECT 
  COALESCE(-E.OBFL_START_LONGITUDE, -E.OBFL_END_LONGITUDE)AS X, 
  COALESCE(E.OBFL_START_LATITUDE, E.OBFL_END_LATITUDE) AS Y, 
  -E.OBFL_END_LONGITUDE AS X2, E.OBFL_END_LATITUDE AS Y2, 
  E.Fishing_Depth AS fdep, 
  CONVERT(char(10),E.Start_FE, 20) AS [date], 
  T.OBFL_VSL_CFV_NO AS cfv, 
  ISNULL(E.Duration, Null) AS eff, 
  C.catch AS @sppcode 
FROM 
  B2_Trips T RIGHT OUTER JOIN 
  (B3_Fishing_Events E LEFT OUTER JOIN 
  #Catch C ON 
  E.OBFL_HAIL_IN_NO = C.hail_in AND 
  E.OBFL_SET_NO = C.set_no ) ON 
  T.OBFL_HAIL_IN_NO = E.OBFL_HAIL_IN_NO 
WHERE 
  E.OBFL_GEAR_SUBTYPE_CDE=1 AND 
  (IsNull(E.OBFL_FE_SUCCESS_CDE,0)=0 OR 
  IsNull(E.OBFL_FE_SUCCESS_CDE,0)=1) AND
  COALESCE(-E.OBFL_START_LONGITUDE, -E.OBFL_END_LONGITUDE) IS NOT NULL AND
  COALESCE(E.OBFL_START_LATITUDE, E.OBFL_END_LATITUDE) IS NOT NULL

