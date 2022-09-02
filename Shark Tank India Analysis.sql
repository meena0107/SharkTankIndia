PROJECT ANALYSIS AND QUERIES
-- review the table
select * from stk..data

-- Analysis 01- Total episodes telecasted into SharkTankIndia

select max(EpNo) as Maximum_Episode from stk..data
select count(distinct EpNo) from stk..data

-- Analysis 02- Pitches that had pitched onto the SharkTankIndia

select count(distinct brand) from stk..data

-- Analysis 03- Pitches Converted(gets funding from SharkTankIndia) in Percentage


select cast(sum(a.converted_not_converted) as float)/cast(count(*) as float) total_pitches from(
select amount_invested_lakhs, case when amount_invested_lakhs>0 then 1 else 0 end as converted_not_converted from stk..data) a


-- Analysis 04- Total males participated in SharkTankIndia


select sum(male) from stk..data


-- Analysis 05- Total female partcipated into SharkTankIndia

select sum(female) from stk..data

-- Analysis 06- Gender ratio in Shark Tank India

select sum(female)/sum(male) from stk..data


-- Analysis 07- Total Invested Amount into the Show

select sum(amount_invested_lakhs) from stk..data


--  Analysis 08- AVG Equity Taken by the Sharks

select avg(a.equit_taken_p) from
(select * from stk..data where equit_taken_P>0) a


-- Analysis 09- Highest deal done into SharkTankIndia

select max(amount_invested_lakhs) from stk..data


-- Analysis 10- Highest equity taken by the sharks


select max(equit_taken_p) from stk..data


-- Analysis 11- Startups having at least women

select sum(female_count) from
(select female, case when female>0 then 1 else 0 end as female_count from stk..data) a


-- Analysis 12- Pitches converted having atleast one women

select sum(b.female_count) from (
select case when a.female>0 then 1 else 0 end as female_count, a.* from
(select * from stk..data where deal !='No Deal') a)b


-- Analysis 13- AVG team Members 


select avg(team_members) from stk..data


-- Analysis 14- Amount invested per deal by SharkTankIndia


select avg(a.[Amount_Invested_lakhs]) from(
select * from stk..data where deal !='No Deal') a


-- Analysis 15- AVG age group of contestants


select avg_age ,count(avg_age) cnt from stk..data group by  avg_age order by cnt desc


-- Analysis 16- Location group of contestent


select location ,count(location) cnt from stk..data group by location order by cnt desc


-- Analysis 17- Sector group of contestent


select sector ,count(sector) cnt from stk..data group by sector order by cnt desc


-- Analysis 18- Partner Deals


select Team_Partners ,count(Team_Partners) cnt from stk..data where Team_Partners !='-' group by Team_Partners order by cnt desc 


-- Analysis 19- Which is the startup in which the highest amount has been invested in each domain/sector


select c.* from
(select brand,sector,amount_invested_lakhs, rank() over(partition by sector order by amount_invested_lakhs desc) rnk
from stk..data) c

where c.rnk=1