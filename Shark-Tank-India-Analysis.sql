-- review the table
select * from stk..data

-- Analysis 01- total episodes telecasted into SharkTankIndia

select max(EpNo) as Maximum_Episode from stk..data
select count(distinct EpNo) from stk..data

-- Analysis 02- pitches that had pitched onto the SharkTankIndia

select count(distinct brand) from stk..data

-- Analysis 03- Pitches Converted(gets funding from SharkTankIndia) in Percentage


select cast(sum(a.converted_not_converted) as float)/cast(count(*) as float) total_pitches from(
select amount_invested_lakhs, case when amount_invested_lakhs>0 then 1 else 0 end as converted_not_converted from stk..data) a


-- Analysis 03- total males participated in SharkTankIndia


select sum(male) from stk..data


-- Analysis 04- total female partcipated into SharkTankIndia

select sum(female) from stk..data

-- Analysis 04- Gender ratio in Shark Tank India

select sum(female)/sum(male) from stk..data


-- Analysis 05- Total Invested Amount into the Show

select sum(amount_invested_lakhs) from stk..data


--  Analysis 06- AVG Equity Taken by the Sharks

select avg(a.equit_taken_p) from
(select * from stk..data where equit_taken_P>0) a


-- Analysis 07- highest deal done into SharkTankIndia

select max(amount_invested_lakhs) from stk..data


-- Analysis 08- highest equity taken by the sharks


select max(equit_taken_p) from stk..data


-- Analysis 09- startups having at least women

select sum(female_count) from
(select female, case when female>0 then 1 else 0 end as female_count from stk..data) a


-- Analysis 10- pitches converted having atleast one women

select sum(b.female_count) from (
select case when a.female>0 then 1 else 0 end as female_count, a.* from
(select * from stk..data where deal !='No Deal') a)b


-- Analysis 11- AVG team Members


select avg(team_members) from stk..data


-- Analysis 12- amount invested per deal by SharkTankIndia


select avg(a.[Amount_Invested_lakhs]) from(
select * from stk..data where deal !='No Deal') a


-- Analysis 13- AVG age group of contestants


select avg_age ,count(avg_age) cnt from stk..data group by  avg_age order by cnt desc


-- Analysis 14- location group of contestent


select location ,count(location) cnt from stk..data group by location order by cnt desc


-- Analysis 15- sector group of contestent


select sector ,count(sector) cnt from stk..data group by sector order by cnt desc


-- Analysis 16- partner Deals


select F32 as partners ,count(F32) cnt from stk..data where F32 !='-' group by F32 order by cnt desc 




-- Analysis 16- which is the startup in which the highest amount has been invested in each domain/sector


select c.* from
(select brand,sector,amount_invested_lakhs, rank() over(partition by sector order by amount_invested_lakhs desc) rnk
from stk..data) c

where c.rnk=1