SELECT F.FundCode, 
	N.NaVPLDate AS Date, 
	N.CCYExposure
FROM	tbl_FundsNavsAndPLs AS N LEFT JOIN
		tbl_FUnds AS F ON (F.id = N.FundId)