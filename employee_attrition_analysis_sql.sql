CREATE DATABASE employee_attrition_analysis1;
use employee_attrition_analysis1;
rename table employee_attrition_analysis to employee_attrition;
select * from employee_attrition;
select count(employee_number) from employee_attrition;

-- details of employees under attrition having 5+ experiance between age 27 and 35 and its count:
select * from employee_attrition
where age between 27 and 35
and total_working_years >= 5;
select count(*) from employee_attrition
where age between 27 and 35
and total_working_years >= 5;

-- employees having max & min salary department-wise with hike less than 13%:
select department,
         max(monthly_income),
         min(monthly_income)
from employee_attrition
where percent_salary_hike < 13
group by department;

-- average salary by Job Role for employees who left the company:
select 
    job_role,
    round(avg(monthly_income), 2) as Average_Salary
from employee_attrition
where attrition = 'Yes'
group by job_role
order by Average_Salary desc;

-- gender distribution among employees who left the company:
select 
    gender,
    COUNT(*) as Attrition_Count
from employee_attrition
where Attrition = 'Yes'
group by Gender;

-- attrition rate by department: 
select 
    Department,
    COUNT(case when attrition = 'Yes' then 1 end) as Attrition_Count,
    COUNT(*) as Total_Employees,
    ROUND(
        COUNT(case when attrition = 'Yes' then 1 end) * 100.0 / COUNT(*),2
    ) as Attrition_Rate
from employee_attrition
group by department
order by Attrition_Rate DESC;

-- overtime impact on attrition
select 
    over_time,
    COUNT(*) as Employee_Count,
    COUNT(case when attrition = 'Yes' then 1 end) as Attrition_Count,
    ROUND(
        COUNT(case when attrition = 'Yes' then 1 end) * 100.0 / COUNT(*),2
    ) as Attrition_Rate
from employee_attrition
group by over_time;
