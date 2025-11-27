use SSBLIVE
go

select	a.Code
		, dbo.CutSortChar(a.LocalName) as LocalName
		, dbo.CutSortChar(a.EnglishName) as EnglishName
		, CAST(SUBSTRING(a.Com, 177, 5) AS varchar(5)) as DefaultClinicalAnswer
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 177, 5) AS varchar(5)),42845,2) as DefaultClinicalAnswerNameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 177, 5) AS varchar(5)),42845,1) as DefaultClinicalAnswerNameEN

		, CAST(SUBSTRING(a.Com, 65, 5) AS varchar(5)) as ClinicalAnswerCanUse01
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 65, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse01NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 65, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse01NameEN

		, CAST(SUBSTRING(a.Com, 71, 5) AS varchar(5)) as ClinicalAnswerCanUse02
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 71, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse02NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 71, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse02NameEN

		, CAST(SUBSTRING(a.Com, 77, 5) AS varchar(5)) as ClinicalAnswerCanUse03
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 77, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse03NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 77, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse03NameEN

		, CAST(SUBSTRING(a.Com, 83, 5) AS varchar(5)) as ClinicalAnswerCanUse04
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 83, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse04NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 83, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse04NameEN

		, CAST(SUBSTRING(a.Com, 89, 5) AS varchar(5)) as ClinicalAnswerCanUse05
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 89, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse05NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 89, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse05NameEN

		, CAST(SUBSTRING(a.Com, 95, 5) AS varchar(5)) as ClinicalAnswerCanUse06
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 95, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse06NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 95, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse06NameEN

		, CAST(SUBSTRING(a.Com, 101, 5) AS varchar(5)) as ClinicalAnswerCanUse07
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 101, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse07NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 101, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse07NameEN

		, CAST(SUBSTRING(a.Com, 107, 5) AS varchar(5)) as ClinicalAnswerCanUse08
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 107, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse08NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 107, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse08NameEN

		, CAST(SUBSTRING(a.Com, 113, 5) AS varchar(5)) as ClinicalAnswerCanUse09
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 113, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse09NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 113, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse09NameEN

		, CAST(SUBSTRING(a.Com, 119, 5) AS varchar(5)) as ClinicalAnswerCanUse10
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 119, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse10NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 119, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse10NameEN
		
		, CAST(SUBSTRING(a.Com, 125, 5) AS varchar(5)) as ClinicalAnswerCanUse11
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 125, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse11NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 125, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse11NameEN

		, CAST(SUBSTRING(a.Com, 131, 5) AS varchar(5)) as ClinicalAnswerCanUse12
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 131, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse12NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 131, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse12NameEN

		, CAST(SUBSTRING(a.Com, 131, 5) AS varchar(5)) as ClinicalAnswerCanUse12
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 131, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse12NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 131, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse12NameEN

		, CAST(SUBSTRING(a.Com, 137, 5) AS varchar(5)) as ClinicalAnswerCanUse13
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 137, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse13NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 137, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse13NameEN

		, CAST(SUBSTRING(a.Com, 143, 5) AS varchar(5)) as ClinicalAnswerCanUse14
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 143, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse14NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 143, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse14NameEN

		, CAST(SUBSTRING(a.Com, 149, 5) AS varchar(5)) as ClinicalAnswerCanUse15
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 149, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse15NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 149, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse15NameEN

		, CAST(SUBSTRING(a.Com, 155, 5) AS varchar(5)) as ClinicalAnswerCanUse16
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 155, 5) AS varchar(5)),42845,2) as ClinicalAnswerCanUse16NameTH
		, dbo.sysconname(CAST(SUBSTRING(a.Com, 155, 5) AS varchar(5)),42845,1) as ClinicalAnswerCanUse16NameEN
from	DNSYSCONFIG a
where	a.CtrlCode = 42054
order by a.Code
