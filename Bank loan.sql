select *from [dbo].[bank_Loan_Data]
--KPI

--Total Loan of Apllication
select count(id) as Total_Loan_of_Apllication from [dbo].[bank_Loan_Data] as Total_number_of_Apllication

--(MTD - PMTD)/PMTD=MOM      MTD=قروض الشهر الحالية    PMTD=قروض الشهر الماضية  MOM= Month-over-month
--MTD
select COUNT(id) as MTD_Total_Loan_of_Apllication from[dbo].[bank_Loan_Data]
where MONTH([issue_date]) =12

--PMTD
select COUNT(id)as PMTD_Total_Loan_of_Apllication from [dbo].[bank_Loan_Data]
where MONTH([issue_date]) =11

--Total_Funded_amount
select SUM([loan_amount])as Total_Funded_amount from[dbo].[bank_Loan_Data]
--MTD_Total_Funded_amount
select SUM([loan_amount])as MTD_Total_Funded_amount from[dbo].[bank_Loan_Data]
where MONTH([issue_date])=12 and YEAR([issue_date])=2021

--PMTD_Total_Funded_amount

select SUM([loan_amount])as PMTD_Total_Funded_amount from[dbo].[bank_Loan_Data]
where MONTH([issue_date])=11 and YEAR([issue_date])=2021

--Total_Amount_recived
select sum([total_payment]) as Total_Amount_recived from[dbo].[bank_Loan_Data]

--MTD_Total_Amount_recived
select sum([total_payment]) as MTD_Total_Amount_recived from[dbo].[bank_Loan_Data]
where MONTH([issue_date])=12 and YEAR([issue_date])=2021

--PMTD_Total_Amount_recived
select sum([total_payment]) as PMTD_Total_Amount_recived from[dbo].[bank_Loan_Data]
where MONTH([issue_date])=11 and YEAR([issue_date])=2021

--%Average_Interst_rate
select AVG([int_rate])*100 as Average_Interst_rate from [dbo].[bank_Loan_Data]

--%MTD_Average_Interst_rate
select AVG([int_rate])*100 as MTD_Average_Interst_rate from [dbo].[bank_Loan_Data]
where MONTH([issue_date])=12 and YEAR([issue_date])=2021

--%PMTD_Average_Interst_rate
select round (AVG([int_rate]),4)*100 as MTD_Average_Interst_rate from [dbo].[bank_Loan_Data]
where MONTH([issue_date])=11 and YEAR([issue_date])=2021

--MTD_average_debt_to_income_ratio  DTI
select round (avg([dti]),4)*100 as MTD_avg_dti from [dbo].[bank_Loan_Data]
where MONTH([issue_date])=12 and YEAR([issue_date])=2021

--PMTD_average_debt_to_income_ratio  DTI
select round (avg([dti]),4)*100 as PMTD_avg_dti from [dbo].[bank_Loan_Data]
where MONTH([issue_date])=11 and YEAR([issue_date])=2021

------------------------------------------------------------------------

----Good_Loans
--How many number of % of Apllication have been recived for bad loan and good loans
select  
   ( count(case when [loan_status] ='Fully Paid' or [loan_status] ='Current'then[id]end)*100)
   /
   count ([id]) as Good_loan_percentage
from [dbo].[bank_Loan_Data]

--How many number of % of Apllication have been recived for  good loan
select COUNT( [id])as Good_Loan_Application from [dbo].[bank_Loan_Data]
where [loan_status]='Fully paid'or  [loan_status]='Current'

--Good_Loan_Funded_Amount
select sum ([loan_amount])as Good_Loan_Funded_Amount from [dbo].[bank_Loan_Data]
where [loan_status]='Fully paid'or  [loan_status]='Current'

--Good_Loan_Total_recived_Amount
select sum ([total_payment])as Good_Loan_Total_recived_Amount from [dbo].[bank_Loan_Data]
where [loan_status]='Fully paid'or  [loan_status]='Current'

----------------------------------------------------------------
---Bad loan

--Bad_loan_%
select 
     (COUNT(case when [loan_status] ='Charged Off'then [id] End)*100)
	 /
	 count([id]) AS Bad_Loan_percentage
from [dbo].[bank_Loan_Data]

--Bad_Loan_Applications
select count([id]) as Bad_Loan_Applications from [dbo].[bank_Loan_Data]
where [loan_status] = 'Charged Off'
--Bad_Loan_Funded_amount
select sum([id]) as Bad_Loan_Funded_amount from [dbo].[bank_Loan_Data]
where [loan_status] = 'Charged Off'
--Bad_Loan_amount_Recived
select sum([total_payment]) as Bad_Loan_amount_Recived from [dbo].[bank_Loan_Data]
where [loan_status] = 'Charged Off'

--------------------------------------------------------
--loan_status
select 
     [loan_status],
	 COUNT([id]) as Total_loan_application,
	 sum([total_payment]) as Total_amount_recived,
	 sum([loan_amount]) as Total_funded_amount,
	 avg([int_rate]*100) as Interest_rate,
	 AVG([dti]*100) as DTI
	 from [dbo].[bank_Loan_Data]
group by [loan_status]

--MTD_loan_status
select 
     [loan_status],
    sum([total_payment]) as MTD_Total_amount_recived,
	sum([loan_amount]) as MTD_Total_funded_amount
	from[dbo].[bank_Loan_Data]
	where MONTH([issue_date])=12
	group by  [loan_status]

--month_name
select 
 MONTH([issue_date]) as month_number,
 DATENAME(month,[issue_date]) as Month_name,
 count([id]) as Total_loan_applications,
 sum([loan_amount]) as Total_funed_amount,
 sum([total_payment]) as total_recived_amount
 from [dbo].[bank_Loan_Data]
 group by  MONTH([issue_date]) ,datename(month,[issue_date])
 order by month([issue_date])

 --term
 select 
   [term],
 sum([loan_amount]) as Total_funed_amount,
 sum([total_payment]) as total_recived_amount
 from [dbo].[bank_Loan_Data]
 group by  [term]
 order by [term]
